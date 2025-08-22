import 'package:attendance_app/controllers/attendance_controller.dart';
import 'package:attendance_app/ui/components-general/header.dart';
import 'package:attendance_app/ui/const.dart';
import 'package:attendance_app/ui/users/status-page/components/table_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class StatusScreen extends StatelessWidget {
  final attendanceC = Get.find<AttendanceController>();
  StatusScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      body: Padding(
          padding: EdgeInsets.symmetric(vertical: 100.h, horizontal: 32.w),
            child: Column(
              children: [
                Header(
                  title: "Status",
                  onPressedIcon: () => Get.back(),
                ),
                SizedBox(height: 30.h),
                Expanded(
                  child: Obx((){
                    if (attendanceC.isLoading.value){
                      return const Center(child: CircularProgressIndicator());
                    }
                    if (attendanceC.attendanceList.isEmpty){
                      return Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Image.asset('assets/images/not_found.png', width: 500.w),
                            SizedBox(height: 50.h),
                            Text("Maaf, Status tidak tersedia di hari ini.",
                            style: TextStyle(
                              fontSize: heading3.sp,
                              fontWeight: FontWeight.w500
                            ),
                            )
                          ],
                      );
                    }
                    return TableCard(data: attendanceC.attendanceList);
                  })
                )
              ],
            ),
          )),
    );
  }
}
