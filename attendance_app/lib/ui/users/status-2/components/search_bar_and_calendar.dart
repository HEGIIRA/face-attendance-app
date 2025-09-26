import 'package:attendance_app/controllers/attendance_controller.dart';
import 'package:attendance_app/ui/users/status-2/components/calendar.dart';
import 'package:attendance_app/ui/const.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class SearchBarAndCalendar extends StatelessWidget {
  SearchBarAndCalendar({super.key});

  final attendanceC = Get.find<AttendanceController>();

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
          child: TextField(
            onChanged: (value) => attendanceC.setSearchQuery(value),
            style: TextStyle(
              fontSize: heading5.sp,
              fontWeight: FontWeight.w600,
            ),
            decoration: InputDecoration(
              hintText: 'Cari Nama Karyawan',
              hintStyle: TextStyle(fontSize: heading5.sp),
              filled: true,
              fillColor: Colors.white,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: BorderSide(color: primary600),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: BorderSide(color: text300, width: 1),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: BorderSide(color: primary600, width: 1),
              ),
              prefixIcon: const Icon(Icons.search),
            ),
          ),
        ),
        SizedBox(width: 30.w),
        SizedBox(
          width: 50.w, // contoh fix width
          child: Calendar(),
        ),
      ],
    );
  }
}
