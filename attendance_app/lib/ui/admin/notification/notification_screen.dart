import 'package:attendance_app/controllers/attendance_controller.dart';
import 'package:attendance_app/ui/admin/notification/components/notificaion_section.dart';
import 'package:attendance_app/ui/components-general/data_not_found.dart';
import 'package:attendance_app/ui/components-general/header.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class NotificationScreen extends StatelessWidget {
  NotificationScreen({
    super.key,
  });

  final AttendanceController attendanceC = Get.find<AttendanceController>();

  @override
  Widget build(BuildContext context) {
    attendanceC.listenNotifications();
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 32.w, vertical: 42.h),
          child: Column(
            children: [
              Header(
                  title: "Aduan",
                  onPressedIcon: () {
                    Get.back();
                  }),
                  SizedBox(height: 52.h),
              Expanded(
                child: Obx(() {
                  if (attendanceC.groupedNotifications.isEmpty) {
                    return Center(
                      child: DataNotFound(imagePath: 'assets/images/notification_not_found.png', message: "Tidak ada notifikasi"),
                    );
                  }
                  return ListView(
                    children:
                        attendanceC.groupedNotifications.entries.map((entry) {
                      return NotificationSection(
                        title: entry.key,
                        items: entry.value,
                      );
                    }).toList(),
                  );
                }),
              )
            ],
          ),
        ),
      ),
    );
  }
}
