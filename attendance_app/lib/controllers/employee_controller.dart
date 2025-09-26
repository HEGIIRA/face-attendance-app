import 'dart:convert';
import 'package:get/get.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/employee_model.dart';
import 'package:http/http.dart' as http;

class EmployeeController extends GetxController {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  var employees = <EmployeeModel>[].obs;
  var isLoading = false.obs;

  var statusMessage = ''.obs;
  final baseUrl = 'https://97b1308c14ab.ngrok-free.app';

  var name = "".obs;
  var position = "".obs;
  var division = "".obs;
  var tempId = "".obs;

  var selectedDivision = 'Semua'.obs;
  var searchQuery = ''.obs;

  void setName(String value) => name.value = value;
  void setDivision(String value) => division.value = value;
  void setPosition(String value) => position.value = value;
  void setTempId(String value) => tempId.value = value;

  // list manual bidang
  final List<String> divisionList = [
    'Semua',
    'IT',
    'PIPK',
    'Aptika',
    'Persandian dan Statistik',
    'Sekretariat',
  ];

  @override
  void onInit() {
    super.onInit();
    // kalau mau semua data:
    fetchEmployees();

    // kalau mau khusus user login:
    // final uid = Get.find<AuthController>().currentUser!.uid;
    // loadEmployees(uid);
  }

  Future<String?> registerFace({
  required String tempId,
  required String name,
  required String division,
  required String position,
}) async {
  try {
    print("=== REGISTER FACE START ===");
    print("tempId: $tempId");
    print("name: $name");
    print("division: $division");
    print("position: $position");

    var query = await FirebaseFirestore.instance
        .collection("users")
        .where("division", isEqualTo: division)
        .limit(1)
        .get();

    if (query.docs.isEmpty) {
      print("ERROR: Division $division tidak ada di Firestore");
      throw Exception("Division $division tidak ada di Firestore");
    }

    String ownerUid = query.docs.first.id;
    print("ownerUid didapat: $ownerUid");

    final url = Uri.parse('$baseUrl/register');
    print("POST to: $url");

    final res = await http.post(
      url,
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({
        'temp_id': tempId,
        'name': name,
        'division': division,
        'position': position,
        'ownerUid': ownerUid,
      }),
    );

    print("Response status: ${res.statusCode}");
    print("Response body: ${res.body}");

    if (res.statusCode == 200) {
      final data = jsonDecode(res.body);
      print("Decoded response: $data");

      if (data['success'] == true) {
        print("Simpan Firestore BERHASIL ✅");
        return data['employeeId']; 
      } else {
        print("Register gagal ❌ : ${data['msg']}");
        return null;
      }
    } else {
      print("Request gagal. statusCode=${res.statusCode}");
      return null;
    }
  } catch (e, s) {
    print("CATCH ERROR: $e");
    print("STACKTRACE: $s");
    statusMessage.value = 'Error register: $e';
    return null;
  }
}



  Future<void> fetchEmployees() async {
    try {
      isLoading.value = true;
      final snapshot = await _firestore.collection("employees").get();
      employees.assignAll(
        snapshot.docs.map((doc) => EmployeeModel.fromFirestore(doc)).toList(),
      );
    } catch (e) {
      Get.snackbar("Error", "Gagal ambil data: $e");
    } finally {
      isLoading.value = false;
    }
  }

  EmployeeModel? getEmployeeById(String id) {
    try {
      return employees.firstWhere((e) => e.id == id);
    } catch (e) {
      return null;
    }
  }

  //PENCARIAN CASE-INSENSITIVE (BUAT SEARCH BAR NAMA KARYAWAN)
  void setSearchQuery(String value) {
    searchQuery.value = value.toLowerCase();
  }

  List<EmployeeModel> get filteredEmployeeList {
    var result = employees.toList();
    final query = searchQuery.value.toLowerCase();
    final division = selectedDivision.value;

    // Filter berdasarkan division
    if (division != 'Semua') {
      result = result.where((e) => e.division == division).toList();
    }

    // Filter berdasarkan pencarian nama
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

  void loadEmployees(String currentUid) {
    _firestore
        .collection("employees")
        .where("ownerUid", isEqualTo: currentUid)
        .snapshots()
        .listen((snapshot) {
      employees.assignAll(
        snapshot.docs.map((doc) => EmployeeModel.fromFirestore(doc)).toList(),
      );
    });
  }

  Future<EmployeeModel?> getEmployeeDetail(String employeeId) async {
  try {
    final doc = await _firestore.collection('employees').doc(employeeId).get();
    if (!doc.exists) return null;
    return EmployeeModel.fromFirestore(doc);
  } catch (e) {
    print("Error fetch detail: $e");
    return null;
  }
}


  // UPDATE Employee
  Future<void> updateEmployee(EmployeeModel employee) async {
    try {
      await _firestore
          .collection("employees")
          .doc(employee.id) // pastikan model lu ada field id / docId
          .update({
        "name": employee.name,
        "division": employee.division,
        "position": employee.position,
      });

      Get.snackbar("Sukses", "Data karyawan berhasil diupdate!");
    } catch (e) {
      Get.snackbar("Error", "Gagal update data: $e");
    }
  }

  // DELETE Employee
  Future<void> deleteEmployee(String employeeId) async {
    try {
      await _firestore.collection("employees").doc(employeeId).delete();
      employees.removeWhere((e) => e.id == employeeId);

      Get.snackbar("Sukses", "Data karyawan berhasil dihapus!");
    } catch (e) {
      Get.snackbar("Error", "Gagal hapus data: $e");
    }
  }
}
