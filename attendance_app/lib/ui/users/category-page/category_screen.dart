import 'package:attendance_app/controllers/camera_binding.dart';
import 'package:attendance_app/controllers/employee_controller.dart';
import 'package:attendance_app/models/employee_model.dart';
import 'package:attendance_app/ui/admin/detail-face-register/detail_face_register.dart';
import 'package:attendance_app/ui/admin/face-register/components/face_register_field.dart';
import 'package:attendance_app/ui/components-general/custom_button.dart';
import 'package:attendance_app/ui/components-general/header.dart';
import 'package:attendance_app/ui/const.dart';
import 'package:attendance_app/ui/users/camera-scan/camera_scan_screen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class CategoryScreen extends StatelessWidget {
  CategoryScreen({super.key});

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
                title: "Pilih Waktu Kehadiran",
                onPressedIcon: () => Get.back(),
              ),
              SizedBox(
                height: 66.h,
              ),
              Column(
                children: [
                  GestureDetector(
                    onTap: () {
                      Get.to(
                        () => CameraScanScreen(),
                        binding: CameraBinding(),
                        arguments: {"mode": "checkIn"},
                      );
                    },
                    child: Column(
                      children: [
                        Image.asset(
                          'assets/images/check_in.png',
                          width: 398.w,
                        ),
                        SizedBox(height: 32.h),
                        Text(
                          "Jam Masuk",
                          style: TextStyle(fontSize: heading3.sp),
                        )
                      ],
                    ),
                  ),
                  SizedBox(height: 76.h),
                  Row(
                    children: [
                      Expanded(
                        child: Divider(
                          thickness: 1,
                          color: text100,
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 8.0.w),
                        child: Text("Atau",
                            style: TextStyle(
                                fontSize: heading4.sp, color: text200)),
                      ),
                      Expanded(
                        child: Divider(
                          thickness: 1,
                          color: text100,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 76.h),
                  GestureDetector(
                    onTap: () {
                      Get.to(
                        () => CameraScanScreen(),
                        binding: CameraBinding(),
                        arguments: {"mode": "checkOut"},
                      );
                    },
                    child: Column(
                      children: [
                        Image.asset(
                          'assets/images/check_out.png',
                          width: 398.w,
                        ),
                        SizedBox(height: 32.h),
                        Text(
                          "Jam Keluar",
                          style: TextStyle(fontSize: heading3.sp),
                        )
                      ],
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
