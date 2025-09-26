import 'package:attendance_app/controllers/employee_controller.dart';
import 'package:attendance_app/models/employee_model.dart';
import 'package:attendance_app/ui/admin/detail-face-register/detail_face_register.dart';
import 'package:attendance_app/ui/admin/face-register/components/face_register_field.dart';
import 'package:attendance_app/ui/components-general/custom_button.dart';
import 'package:attendance_app/ui/components-general/header.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class FaceRegisterScreen extends StatelessWidget {
  FaceRegisterScreen({super.key});
  final employeeC = Get.put(EmployeeController());
  final formKey = GlobalKey<FormState>();
  final nameController = TextEditingController();
  final positionController = TextEditingController();
  final String tempId = Get.arguments['tempId'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 32.w, vertical: 46.h),
          child: Column(
            children: [
              Header(
                title: "Isi Data Diri",
                onPressedIcon: () => Get.back(),
              ),
              SizedBox(height: 30.h),
              FaceRegisterField(
                formKey: formKey,
                nameController: nameController,
                positionController: positionController,
              ),
              const Spacer(), //biar si button nya kedorong ke paling bawah
              SizedBox(
                  width: double.infinity, //biar full ke samping
                  child: CustomButton(
                      text: "Daftarkan",
                      onPressed: () async {
                        if (formKey.currentState!.validate()) {
                          final employeeId = await employeeC.registerFace(
                            tempId: tempId,
                            name: nameController.text,
                            position: positionController.text,
                            division: employeeC.division.value,
                          );

                          if (employeeId != null) {
                            final employeeDoc = await FirebaseFirestore.instance
                                .collection('employees')
                                .doc(employeeId)
                                .get();
                            final employee = EmployeeModel.fromFirestore(employeeDoc);

                            Get.to(() => DetailFaceRegister(),
                                arguments: {'employee': employee});
                          } else {
                            Get.snackbar("Gagal", "Register face gagal bos");
                          }
                        }
                      })),
            ],
          ),
        ),
      ),
    );
  }
}
