import 'package:attendance_app/controllers/employee_controller.dart';
import 'package:attendance_app/ui/admin/dashboard-admin/dashboard_admin_screen.dart';
import 'package:attendance_app/ui/admin/face-register-page/components/face_register_field.dart';
import 'package:attendance_app/ui/components-general/custom_button.dart';
import 'package:attendance_app/ui/components-general/header.dart';
import 'package:attendance_app/ui/users/category-register-page/category_register_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class FaceRegisterScreen extends StatelessWidget {
  FaceRegisterScreen({super.key});
  final employeeC = Get.put(EmployeeController());
  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 32.w, vertical: 100.h),
          child: Column(
            children: [
              Header(
                title: "Isi Data Diri",
                onPressedIcon: () => Get.back(),
              ),
              SizedBox(height: 30.h),
              FaceRegisterField(formKey: formKey),
              const Spacer(), //biar si button nya kedorong ke paling bawah
              SizedBox(
                  width: double.infinity, //biar full ke samping
                  child: CustomButton(
                    text: "Daftarkan",
                    onPressed: () {
                      final isValid = formKey.currentState!.validate();
                      print("form valid? $isValid");
                      if (isValid) {
                        Get.to(() => DashboardAdminScreen());
                      }
                    },
                  )),
            ],
          ),
        ),
      ),
    );
  }
}
