import 'dart:async';

import 'package:attendance_app/controllers/admin_controller.dart';
import 'package:attendance_app/controllers/auth_controller.dart';
import 'package:attendance_app/models/attendance_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

class AttendanceController extends GetxController {
  RxList<AttendanceModel> attendanceList = <AttendanceModel>[].obs;
  var isLoading = false.obs;
  StreamSubscription? _attendanceSub;

  @override
  void onInit() {
    super.onInit();
    print("AttendanceController INIT");
    // String today = DateFormat('yyyy-MM-dd').format(DateTime.now());
    // ever(Get.find<AuthController>().uid, (uidValue) {
    //   if (uidValue.isNotEmpty) {
    //     String today = '2025-07-31'; // nanti bisa dynamic
    //     // fetchAttendance(today, uidValue);
    //     listenAttendance(today, uidValue);
    //   }
    // });

    // String today = '2025-07-31';
    // String uid = Get.find<AuthController>().uid.value;
    // // fetchAttendance(today, uid);
    // if (uid.isNotEmpty) {
    //   listenAttendance(today, uid); // ⬅️ bukan fetch sekali, tapi stream
    // }

    ever(Get.find<AuthController>().uid, (uidValue) {
      if (uidValue.isNotEmpty) {
        String today = '2025-07-31'; // nanti dynamic
        startAttendanceListener(today, uidValue);
      } else {
        _attendanceSub?.cancel(); // klo logout, matiin stream
        attendanceList.clear();
      }
    });
  }

  void startAttendanceListener(String dateId, String uid) {
    // cancel kalau ada stream lama
    _attendanceSub?.cancel();

    final adminC = Get.find<AdminController>();
    final isAdmin = adminC.isAdminMode.value;

    Query<Map<String, dynamic>> query;
    if (isAdmin) {
      query = FirebaseFirestore.instance
          .collection('attendance')
          .doc(dateId)
          .collection('records');
    } else {
      query = FirebaseFirestore.instance
          .collection('attendance')
          .doc(dateId)
          .collection('records')
          .where('uid', isEqualTo: uid);
    }

    _attendanceSub = query.snapshots().listen((snapshot) {
      attendanceList.value = snapshot.docs
          .map((doc) => AttendanceModel.fromMap(doc.data()))
          .toList();

      print("STREAM UPDATE: ${snapshot.docs.length} docs");
    }, onError: (e) {
      print("Error in attendance stream: $e");
    });
  }

  @override
  void onClose() {
    _attendanceSub?.cancel();
    super.onClose();
  }


  // // STREAMING DATA
  // void listenAttendance(String dateId, String uid) {
    
  //   // kalau ada subscription lama, cancel dulu biar ga numpuk
  //   _attendanceSub?.cancel();

  //   final adminC = Get.find<AdminController>();
  //   final isAdmin = adminC.isAdminMode.value;

  //   Query<Map<String, dynamic>> query;

  //   if (isAdmin) {
  //     query = FirebaseFirestore.instance
  //         .collection('attendance')
  //         .doc(dateId)
  //         .collection('records');
  //   } else {
  //     query = FirebaseFirestore.instance
  //         .collection('attendance')
  //         .doc(dateId)
  //         .collection('records')
  //         .where('uid', isEqualTo: uid);
  //   }

  //   _attendanceSub = query.snapshots().listen((snapshot) {
  //     attendanceList.value = snapshot.docs
  //         .map((doc) => AttendanceModel.fromMap(doc.data()))
  //         .toList();

  //     print("STREAM UPDATE: ${snapshot.docs.length} docs");
  //     for (var doc in snapshot.docs) {
  //       print("RAW STREAM DATA: ${doc.data()}");
  //     }
  //   }, onError: (e) {
  //     print("Error in attendance stream: $e");
  //   });
  // }

  // @override
  // void onClose() {
  //   _attendanceSub?.cancel(); // ⬅️ biar ga memory leak
  //   super.onClose();
  // }

  // //FETCH/AMBIL DATA

  // void fetchAttendance(String dateId, String uid) async {
  //   try {
  //     isLoading.value = true;

  //     final adminC = Get.find<AdminController>();
  //     final isAdmin = adminC.isAdminMode.value;

  //     QuerySnapshot<Map<String, dynamic>> snapshot;

  //     if (isAdmin) {
  //       // ADMIN MODE: ambil semua data dari hari itu
  //       snapshot = await FirebaseFirestore.instance
  //           .collection('attendance')
  //           .doc(dateId)
  //           .collection('records')
  //           .get();
  //     } else {
  //       // USER MODE: filter berdasarkan UID
  //       snapshot = await FirebaseFirestore.instance
  //           .collection('attendance')
  //           .doc(dateId)
  //           .collection('records')
  //           .where('uid', isEqualTo: uid)
  //           .get();
  //     }

  //     attendanceList.value = snapshot.docs
  //         .map((doc) => AttendanceModel.fromMap(doc.data()))
  //         .toList();

  //     print("DOCS LENGTH: ${snapshot.docs.length}");
  //     for (var doc in snapshot.docs) {
  //       print("RAW DATA: ${doc.data()}");
  //     }
  //   } catch (e) {
  //     print('Error fetching attendance: $e');
  //   } finally {
  //     isLoading.value = false;
  //   }
  // }

  //ambil data dengan history nya

  Future<void> fetchAllAttendanceHistory() async {
    try {
      isLoading.value = true;

      List<AttendanceModel> allData = [];

      final snapshot = await FirebaseFirestore.instance
          .collection('attendance')
          .get(); // ambil semua tanggal (document ID = date)

      for (var dateDoc in snapshot.docs) {
        final dateId = dateDoc.id;

        final recordsSnapshot = await FirebaseFirestore.instance
            .collection('attendance')
            .doc(dateId)
            .collection('records')
            .get(); // ambil semua data per tanggal

        final records = recordsSnapshot.docs
            .map((doc) => AttendanceModel.fromMap(doc.data()))
            .toList();

        allData.addAll(records);
      }

      attendanceList.value = allData;
    } catch (e) {
      print('Error fetching all attendance: $e');
    } finally {
      isLoading.value = false;
    }
  }
}
