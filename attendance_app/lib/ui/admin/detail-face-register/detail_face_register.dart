import 'package:attendance_app/ui/admin/camera-add/camera_add_screen.dart';
import 'package:attendance_app/ui/admin/dashboard-admin/dashboard_admin_screen.dart';
import 'package:attendance_app/ui/admin/detail-face-register/info_card.dart';
import 'package:attendance_app/ui/components-general/header.dart';
import 'package:attendance_app/ui/const.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class DetailFaceRegister extends StatelessWidget {
  DetailFaceRegister({super.key});

  @override
  Widget build(BuildContext context) {
    final employee = Get.arguments['employee'];

    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 32.w, vertical: 46.h),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Header(
                title: "Detail Data",
                onPressedIcon: () => Get.back(),
              ),
              SizedBox(height: 65.h),
              Text(
                "Karyawan baru berhasil ditambahkan!",
                style: TextStyle(fontSize: heading4.sp),
              ),
              SizedBox(height: 30.h),
              InfoCard(employee: employee),
              const Spacer(), //biar si button nya kedorong ke paling bawah
              Row(
                children: [
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () async {
                        Get.to(CameraAddScreen());
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: primary600,
                        foregroundColor: Colors.white,
                        padding: EdgeInsets.symmetric(
                            horizontal: 50.w, vertical: 15.h),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.r),
                        ),
                      ),
                      child: Text(
                        'Tambah Karyawan Lagi',
                        style: TextStyle(
                            fontSize: heading4.sp,
                            fontWeight: FontWeight.w500,
                            color: Colors.white),
                      ),
                    ),
                  ),
                  SizedBox(width: 15.w),
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () {
                        Get.offAll(DashboardAdminScreen());
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: text100,
                        foregroundColor: Colors.white,
                        padding: EdgeInsets.symmetric(
                            horizontal: 50.w, vertical: 15.h),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.r),
                        ),
                      ),
                      child: Text(
                        'Kembali Ke Dashboard',
                        style: TextStyle(
                            fontSize: heading4.sp,
                            fontWeight: FontWeight.w500,
                            color: text300),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
