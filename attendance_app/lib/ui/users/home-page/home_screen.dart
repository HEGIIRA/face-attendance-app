import 'package:attendance_app/controllers/admin_controller.dart';
import 'package:attendance_app/controllers/attendance_controller.dart';
import 'package:attendance_app/controllers/auth_controller.dart';
import 'package:attendance_app/ui/admin/dashboard-admin/dashboard_admin_screen.dart';
import 'package:attendance_app/ui/components-general/main_header.dart';
import 'package:attendance_app/ui/users/admin-mode-page/admin_mode_screen.dart';
import 'package:attendance_app/ui/users/home-page/components/popup_logout.dart';
import 'package:attendance_app/ui/users/status-page/status_screen.dart';
import 'package:attendance_app/ui/users/home-page/components/date_and_time.dart';
import 'package:attendance_app/ui/users/home-page/components/location.dart';
import 'package:attendance_app/ui/users/home-page/components/scan_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';


class HomeScreen extends StatelessWidget {
  // final controller = Get.find<AttendanceController>();
  final authC = Get.find<AuthController>();

  HomeScreen ({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        body: Padding(
          padding: EdgeInsets.symmetric(vertical: 100.h, horizontal: 32.w),
          child: Column(
            children: [
              MainHeader(
                title: authC.currentUser.value?.bidang ?? 'Beranda', 
                icon1: Icons.history,
                icon2: Icons.admin_panel_settings_outlined,
                icon3: Icons.logout,
                onIcon1Pressed: () => Get.to(StatusScreen()),
                onIcon2Pressed: () => Get.to(AdminModeScreen()),
                onIcon3Pressed: () {popupLogout(context);}
              ),
              SizedBox(height: 138.h),
              DateAndTime(),
              SizedBox(height: 30.h),
              const ScanButton(),
              SizedBox(height: 30.h),
              const Location(),
              SizedBox(height: 20.h),

            ],
          )
        ),
      )
    );
  }
}