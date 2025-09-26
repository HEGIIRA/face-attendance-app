import 'package:attendance_app/controllers/camera_binding.dart';
import 'package:attendance_app/controllers/employee_controller.dart';
import 'package:attendance_app/ui/admin/camera-add/camera_add_screen.dart';
import 'package:attendance_app/ui/const.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class HeaderDataKaryawan extends StatelessWidget {
  HeaderDataKaryawan({super.key});

  final List<String> bidangList = [
    'Semua',
    'IT',
    'PIPK',
    'Aptika',
    'Persandian dan Statistik',
    'Sekretariat',
  ];

  @override
  Widget build(BuildContext context) {
    final employeeC = Get.find<EmployeeController>();
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            Text(
              'Data Karyawan',
              style: TextStyle(
                fontSize: heading4.sp,
              ),
            ),
            SizedBox(width: 5.w),
            Row(
              children: [
                Obx(() =>
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 15.w, vertical: 5.h),
                    decoration: BoxDecoration(
                      color: primary100,
                      borderRadius: BorderRadius.circular(50.r),
                    ),
                    child: Text(
                      employeeC.selectedDivision.value,
                      style: TextStyle(
                        color: primary600,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
                  PopupMenuButton<String>(
                    color: Colors.white,
                    icon: Icon(Icons.arrow_drop_down_circle_outlined,
                        color: primary600),
                    onSelected: (value) {
                      employeeC.selectedDivision.value = value;
                    },
                    itemBuilder: (context) {
                      return bidangList.map((item) {
                        return PopupMenuItem<String>(
                          value: item,
                          child: Text(item),
                        );
                      }).toList();
                    },
                  ),
              ],
            ),
          ],
        ),
        TextButton(
          onPressed: () {
            Get.to(() => CameraAddScreen(), binding: CameraBinding());
          },
          child: Row(
            children: [
              Icon(Icons.person_add_alt, color: primary600),
              SizedBox(width: 5),
              Text(
                "Tambah Karyawan",
                style: TextStyle(
                  color: primary600,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}