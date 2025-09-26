import 'package:attendance_app/controllers/auth_controller.dart';
import 'package:attendance_app/ui/components-general/custom_button.dart';
import 'package:attendance_app/ui/components-general/header.dart';
import 'package:attendance_app/ui/users/category-register-page/components/category_selector.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get/instance_manager.dart';

class CategoryRegisterScreen extends StatelessWidget {
  CategoryRegisterScreen({super.key});
  final authC = Get.find<AuthController>();

  static final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 32.h, vertical: 100.w),
        child: Column(
          children: [
            Header(
              title: "Daftar",
              onPressedIcon: () => Get.back(),
            ),
            SizedBox(height: 30.h),
            Image.asset(
              "assets/images/diskominfo_bogor.png",
              height: 103.08.h,
              width: 323.w,
            ),
            SizedBox(height: 70.h),
            CategorySelector(
              onCategorySelected: (selectedCategory) {
                authC.division.value = selectedCategory;
                //print("Yang dipilih: $selectedCategory");
              },
            ),

            Spacer(), //biar si button nya kedorong ke paling bawah
            SizedBox(
                width: double.infinity, //biar full ke samping
                child: CustomButton(
                  text: "Daftar",
                  onPressed: () async {
                    if (authC.division.value.isEmpty) {
                      Get.snackbar("Error", "Pilih bidang dulu bor");
                      return;
                    }

                    await authC
                        .register(); // <- ini nembak firebase + firestore
                  },
                )),
          ],
        ),
      ),
    );
  }
}
