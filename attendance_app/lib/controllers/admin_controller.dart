import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';


class AdminController extends GetxController {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  var isAdminMode = false.obs;
  var adminCode = ''.obs;




  Future<bool> validateAdminCode() async {
    try {
      final doc = await FirebaseFirestore.instance
          .collection('admin_codes')
          .doc('main_admin') // nama dokumen admin
          .get();


      if (doc.exists && doc['code'] == adminCode.value) {
        return true;
      }
    } catch (e) {
      print("Error: $e");
    }
    return false;
  }
}