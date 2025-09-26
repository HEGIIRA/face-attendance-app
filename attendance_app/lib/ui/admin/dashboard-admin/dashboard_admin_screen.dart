import 'package:attendance_app/controllers/attendance_controller.dart';
import 'package:attendance_app/controllers/employee_controller.dart';
import 'package:attendance_app/ui/admin/dashboard-admin/component-dashboard-admin/header_data_karyawan.dart';
import 'package:attendance_app/ui/admin/dashboard-admin/component-dashboard-admin/popup_logout_admin.dart';
import 'package:attendance_app/ui/admin/notification/notification_screen.dart';
import 'package:attendance_app/ui/components-general/main_header.dart';
import 'package:attendance_app/ui/admin/dashboard-admin/component-dashboard-admin/data_karyawan.dart';
import 'package:attendance_app/ui/admin/dashboard-admin/component-dashboard-admin/rekap_kehadiran.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class DashboardAdminScreen extends StatelessWidget {
  DashboardAdminScreen({super.key});

  final attendanceC = Get.find<AttendanceController>();
  final employeeC = Get.find<EmployeeController>();

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus(); // ini buat nge-release fokus
      },
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        body: SafeArea(
          child: RefreshIndicator(
            onRefresh: () async {
              await employeeC.fetchEmployees();
            },
            child: Obx(() {
              if (employeeC.isLoading.value) {
                return const Center(child: CircularProgressIndicator());
              }
              return ListView(
                padding:
                    EdgeInsets.symmetric(horizontal: 32.w), //vertical: 46.h
                children: [
                  SizedBox(height: 46.h),
                  MainHeader(
                    title: "Dashboard Admin",
                    icon1: Icons.notification_important_outlined,
                    icon2: Icons.logout,
                    onIcon1Pressed: () {
                      Get.to(() => NotificationScreen());
                    },
                    onIcon2Pressed: () {
                      popupLogoutAdmin(context);
                    },
                  ),
                  SizedBox(height: 32.h),
                  // ISI YANG FLEKSIBEL
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Rekap Kehadiran
                      RekapKehadiran(),
                      SizedBox(height: 30.h),
                      HeaderDataKaryawan(),
                      SizedBox(height: 16.h),
                      // LIST DATA KARYAWAN
                      Padding(
                        padding: EdgeInsets.only(bottom: 46.h),
                        child: DataKaryawan(),
                      ),
                    ],
                  ),
                ],
              );
            }),
          ),
        ),
      ),
    );
  }
}
