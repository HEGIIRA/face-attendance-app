import 'package:attendance_app/controllers/attendance_controller.dart';
import 'package:attendance_app/controllers/employee_controller.dart';
import 'package:attendance_app/ui/admin/detail-karyawan/components/employee_detail_table.dart';
import 'package:attendance_app/ui/admin/detail-karyawan/components/date_year.dart';
import 'package:attendance_app/ui/components-general/header.dart';
import 'package:attendance_app/ui/users/status-2/components/attendance_table.dart';
import 'package:attendance_app/ui/users/status-2/components/calendar.dart';
import 'package:attendance_app/ui/users/status-2/components/search_bar_and_calendar.dart';
import 'package:attendance_app/ui/users/status-2/components/sub_header.dart';
import 'package:attendance_app/ui/const.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class Status2Screen extends StatelessWidget {
  Status2Screen({super.key});

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
              child: ListView(
            padding: EdgeInsets.symmetric(horizontal: 32.w, vertical: 46.h),
            children: [
              Header(
                title: "Status Kehadiran",
                onPressedIcon: () => Get.back(),
              ),
              SizedBox(height: 25.h),
              SearchBarAndCalendar(),
              SizedBox(height: 20.h),
              SubHeader(),
              SizedBox(height: 25.h),
              AttendanceTable(),
            ],
          ))),
    );
  }
}
