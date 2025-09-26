import 'dart:async';
import 'package:attendance_app/controllers/auth_controller.dart';
import 'package:attendance_app/controllers/date_controller.dart';
import 'package:attendance_app/models/attendance_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class AttendanceController extends GetxController {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  RxList<AttendanceModel> attendanceList = <AttendanceModel>[].obs;
  RxList<AttendanceModel> historyPerEmployee = <AttendanceModel>[].obs;
  final authC = Get.find<AuthController>();
  var isLoading = false.obs;
  var selectedHour = "Jam Hadir".obs;
  List<String> hours = ["Jam Hadir", "Jam Keluar"];

  final descriptionController = TextEditingController();
  void setInitialData(AttendanceModel attendance) {
    status.value = attendance.status ?? '';
    descriptionController.text = attendance.description ?? '';
  }

  ///UNTUK NOTIFIKASI REPORT
  var notifications = <Map<String, dynamic>>[].obs;
  var groupedNotifications = <String, List<Map<String, dynamic>>>{}.obs;

  var name = "".obs;
  var employeeId = "".obs;
  var issue = "".obs;
  var status = "pending".obs;
  var position = "".obs;
  var division = "".obs;

  var searchQuery = ''.obs;
  var selectedDivision = 'Semua'.obs;

  final issues = [
    "Wajah Tidak Terdeteksi",
    "Wajah Tidak Terdaftar",
    "Sistem Error",
  ];

  final List<String> divisionList = [
    'Semua',
    'IT',
    'PIKP',
    'APTIKA',
    'Persandian dan Statistik',
    'Sekretariat',
  ];

  @override
  void onInit() {
    super.onInit();
    listenNotifications();
    streamAllAttendance();
  }

 Future<String> saveAttendance({
  required String employeeId,
  required String name,
  required String position,
  required String division,
  required String mode, // "checkIn" atau "checkOut"
}) async {
  try {
    DateTime now = DateTime.now();
    String today = DateFormat('yyyy-MM-dd').format(now);
    String currentTime = DateFormat('HH:mm').format(now);

    // cek dokumen absensi hari ini
    QuerySnapshot snapshot = await _firestore
        .collection("attendance")
        .where("employeeId", isEqualTo: employeeId)
        .where("date", isEqualTo: today)
        .get();

    if (mode == "checkIn") {
      if (snapshot.docs.isNotEmpty) {
        return "⚠️ Hari ini sudah absen masuk!";
      }

      String description;
      if (now.hour < 7 || (now.hour == 7 && now.minute <= 30)) {
        description = "Tepat Waktu";
      } else if (now.hour < 17) {
        description = "Terlambat";
      } else {
        return "❌ Sudah lewat jam absensi (17:00)";
      }

      await _firestore.collection("attendance").add({
        "employeeId": employeeId,
        "name": name,
        "position": position,
        "division": division,
        "date": now,
        "checkIn": currentTime,
        "checkOut": null,
        "description": description,
        "status": "Hadir",
        "timestamp": FieldValue.serverTimestamp(),
      });

      return "✅ Check-in berhasil 🎉";
    } else if (mode == "checkOut") {
      if (snapshot.docs.isEmpty) {
        return "⚠️ Belum ada absen masuk hari ini!";
      }
      if (snapshot.docs.length > 1) {
        return "⚠️ Data absen duplikat, hubungi admin!";
      }

      var doc = snapshot.docs.first;
      if (doc["checkOut"] != null) {
        return "⚠️ Sudah absen keluar!";
      }

      await _firestore.collection("attendance").doc(doc.id).update({
        "checkOut": currentTime,
        "timestamp": now.toIso8601String(),
      });

      return "✅ Check-out berhasil 🎉";
    }

    return "❌ Mode tidak dikenal!";
  } catch (e) {
    return "Error: $e";
  }
}

//STREAM ALL ATTENDANCE
void streamAllAttendance() {
  attendanceList.bindStream(
    _firestore
        .collection("attendance")
        .orderBy("timestamp", descending: true) // pake field yg pasti ada
        .snapshots()
        .map((snapshot) => snapshot.docs
            .map((doc) => AttendanceModel.fromFirestore(doc))
            .toList()),
  );
}



  ///FETCH HISTORY PER EMPLOYEE
  Future<void> fetchHistoryByEmployee(String employeeId) async {
    try {
      isLoading.value = true;
      print("Fetching history for employeeId: $employeeId");

      final snapshot = await FirebaseFirestore.instance
          .collection("attendance")
          .where("employeeId", isEqualTo: employeeId)
          .orderBy("date", descending: true)
          .get();

      print("Query returned ${snapshot.docs.length} docs");
      for (var doc in snapshot.docs) {
        print("DocID: ${doc.id}, data: ${doc.data()}");
      }

      final history = snapshot.docs
          .map((doc) => AttendanceModel.fromFirestore(doc))
          .toList();

      historyPerEmployee.assignAll(history);
    } catch (e, st) {
      print("🔥 Error fetch history by employee: $e");
      print(st);
    } finally {
      isLoading.value = false;
    }
  }

  ///STREAM HISTORY PER MONTH & YEAR (langsung query ke firestore biar nge stream yg terpilih nya aja dan gk berat)
  void streamAttendanceByMonth(String employeeId, DateTime selectedDate) {
    final firstDay = DateTime(selectedDate.year, selectedDate.month, 1);
    final lastDay = DateTime(selectedDate.year, selectedDate.month + 1, 0);

    historyPerEmployee.bindStream(
      _firestore
          .collection("attendance")
          .where("employeeId", isEqualTo: employeeId)
          .where("date", isGreaterThanOrEqualTo: firstDay)
          .where("date", isLessThanOrEqualTo: lastDay)
          .orderBy("date", descending: false)
          .snapshots()
          .map((snapshot) => snapshot.docs
              .map((doc) => AttendanceModel.fromFirestore(doc))
              .toList()),
    );
  }

  //UNTUK DROPDOW
  List<String> get dropdownOptions {
    if (selectedHour.value == "Jam Hadir") {
      return ["Jam Keluar"];
    }
    return ["Jam Hadir"];
  }

  void changeHour(String value) {
    selectedHour.value = value;
  }

  // UPDATE Employee
  Future<void> updateAttendance(AttendanceModel attendance) async {
    try {
      await _firestore
          .collection("employees")
          .doc(attendance.employeeId) // pastikan model lu ada field id / docId
          .update({
        "status": attendance.status,
        "description": attendance.description,
      });

      Get.snackbar("Sukses", "Data karyawan berhasil diupdate!");
    } catch (e) {
      Get.snackbar("Error", "Gagal update data: $e");
    }
  }

  Future<void> sendReport() async {
    try {
      await _firestore.collection("attendance").add({
        "employeeId": employeeId.value,
        "name": name.value,
        "uid": authC.uid.value,
        "checkIn": null,
        "checkOut": null,
        "description": issue.value,
        "status": "Tidak Hadir",
        "issueStatus": status.value,
        "issueDate": FieldValue.serverTimestamp(),
        "date": FieldValue.serverTimestamp(),
      });

      // reset form setelah kirim
      employeeId.value = "";
      name.value = "";
      issue.value = "";
      status.value = "pending";
    } catch (e) {
      print("Error kirim report: $e");
      rethrow;
    }
  }

  void listenNotifications() {
    _firestore
        .collection("attendance")
        .orderBy("issueDate", descending: true)
        .snapshots()
        .listen((snapshot) {
      print("Notif snapshot: ${snapshot.docs.length} docs"); // DEBUG
      final data = snapshot.docs.map((doc) {
        final d = doc.data();
        print("docID: ${doc.id}, issueDate: ${d["issueDate"]}"); // DEBUG
        return {
          "employeeId": d["employeeId"],
          "name": d["name"] ?? "",
          "issueDate":
              (d["issueDate"] as Timestamp?)?.toDate() ?? DateTime.now(),
          "description": d["description"] ?? "",
          "issueStatus": d["issueStatus"] ?? "",
        };
      }).where((item) {
        // filter: notifikasi hanya yg ada masalah
        final desc = item["description"]?.toString() ?? "";
        return [
          "Wajah Tidak Terdeteksi",
          "Wajah Tidak Terdaftar",
          "Sistem Error",
        ].contains(desc);
      }).toList();

      // simpan list notifikasi
      notifications.assignAll(data);

      // Group by issueDate
      final Map<String, List<Map<String, dynamic>>> grouped = {};
      for (var item in data) {
        final date = _formatDate(item["issueDate"]);
        if (!grouped.containsKey(date)) {
          grouped[date] = [];
        }
        grouped[date]!.add(item);
      }

      groupedNotifications.assignAll(grouped);
    });
  }

  String _formatDate(DateTime date) {
    final now = DateTime.now();
    final yesterday = now.subtract(Duration(days: 1));

    if (date.year == now.year &&
        date.month == now.month &&
        date.day == now.day) {
      return "Hari Ini";
    } else if (date.year == yesterday.year &&
        date.month == yesterday.month &&
        date.day == yesterday.day) {
      return "Kemarin";
    } else {
      return "${date.day} ${_monthName(date.month)} ${date.year}";
    }
  }

  String _monthName(int month) {
    const bulan = [
      "Januari",
      "Februari",
      "Maret",
      "April",
      "Mei",
      "Juni",
      "Juli",
      "Agustus",
      "September",
      "Oktober",
      "November",
      "Desember"
    ];
    return bulan[month - 1];
  }

  String formatDateTime(DateTime time) {
    const bulan = [
      "Januari",
      "Februari",
      "Maret",
      "April",
      "Mei",
      "Juni",
      "Juli",
      "Agustus",
      "September",
      "Oktober",
      "November",
      "Desember"
    ];

    final tanggal = "${time.day} ${bulan[time.month - 1]} ${time.year}";
    final jam =
        "${time.hour.toString().padLeft(2, '0')}:${time.minute.toString().padLeft(2, '0')}";

    return "$tanggal - $jam";
  }

  void setSearchQuery(String value) {
    searchQuery.value = value.toLowerCase();
  }

  List<AttendanceModel> get filteredAttendanceList {
  var result = attendanceList.toList();
  final query = searchQuery.value.toLowerCase();
  final division = selectedDivision.value;

  final dateC = Get.find<DateController>();
  final selectedDate = dateC.selectedDate.value;

  // 1️⃣ Filter tanggal spesifik (exact day)
  result = result.where((e) {
    if (e.date == null) return false;

    // Cocokkan hari, bulan, tahun
    return e.date!.year == selectedDate.year &&
           e.date!.month == selectedDate.month &&
           e.date!.day == selectedDate.day;
  }).toList();

  // 2️⃣ Filter division
if (division != 'Semua') {
  result = result.where((e) {
    final div = (e.division).toLowerCase().trim();
    final selectedDiv = division.toLowerCase().trim();
    print("🔥 From Firestore division: ${e.division}");
    return div == selectedDiv;
  }).toList();
  
}


  // 3️⃣ Filter nama (search)
  if (query.isNotEmpty) {
    final startsWithList =
        result.where((e) => e.name.toLowerCase().startsWith(query)).toList();

    final containsList = result
        .where((e) =>
            !e.name.toLowerCase().startsWith(query) &&
            e.name.toLowerCase().contains(query))
        .toList();

    result = [...startsWithList, ...containsList];
  }

  return result;
}




}
