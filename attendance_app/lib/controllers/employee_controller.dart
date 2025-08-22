import 'package:flutter/material.dart';
import 'package:get/get.dart';

class EmployeeController extends GetxController {
  var name = "".obs;
  var field = "".obs;
  var position = "".obs;
  var tempId = "".obs; // dari Python pas udah encode wajah

  void setName(String value) => name.value = value;
  void setDivision(String value) => field.value = value;
  void setPosition(String value) => position.value = value;
  void setTempId(String value) => tempId.value = value;

  Future<void> saveEmployee(String ownerUid) async {
    // di sini nanti logic simpan ke Firestore
    // name, division, tempId + ownerUid
  }
}
