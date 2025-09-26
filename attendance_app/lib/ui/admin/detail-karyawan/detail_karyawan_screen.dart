import 'package:attendance_app/controllers/attendance_controller.dart';
import 'package:attendance_app/controllers/employee_controller.dart';
import 'package:attendance_app/models/employee_model.dart';
import 'package:attendance_app/ui/admin/detail-karyawan/components/employee_detail_table.dart';
import 'package:attendance_app/ui/admin/detail-karyawan/components/header_info.dart';
import 'package:attendance_app/ui/admin/detail-karyawan/components/date_year.dart';
import 'package:attendance_app/ui/components-general/custom_year_picker.dart';
import 'package:attendance_app/ui/components-general/header.dart';
import 'package:attendance_app/ui/components-general/data_not_found.dart';
import 'package:attendance_app/ui/const.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class DetailKaryawanScreen extends StatelessWidget {
  final EmployeeModel employee;

  DetailKaryawanScreen({super.key, required this.employee});

  final attendanceC = Get.find<AttendanceController>();
  final employeeC = Get.find<EmployeeController>();

  @override
  Widget build(BuildContext context) {
    // fetch data pertama kali pas screen dibuka
    Future.microtask(() {
      attendanceC.historyPerEmployee.clear();
      attendanceC.fetchHistoryByEmployee(employee.id);
    });

    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: RefreshIndicator(
          onRefresh: () async {
            // refresh manual, tinggal fetch lagi
            await employeeC.fetchEmployees();
            await attendanceC.fetchHistoryByEmployee(employee.id);
          },
          child: Obx(() {
            if (attendanceC.isLoading.value) {
              return const Center(child: CircularProgressIndicator());
            }

            if (attendanceC.historyPerEmployee.isEmpty) {
              // harus pakai ListView biar RefreshIndicator tetap bisa jalan
              return ListView(
                physics: const AlwaysScrollableScrollPhysics(),
                padding: EdgeInsets.symmetric(horizontal: 32.w, vertical: 46.h),
                children: [
                  Header(
                    title: "Detail Karyawan",
                    onPressedIcon: () {
                      Get.back();
                    },
                  ),
                  SizedBox(height: 32.h),
                  Obx(() {
                    final emp = employeeC.getEmployeeById(employee.id);
                    if (emp == null)
                      return SizedBox(); // atau tampilin placeholder

                    return HeaderInfo(employee: emp);
                  }),
                  SizedBox(height: 25.h),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Riwayat Kehadiran',
                        style: TextStyle(fontSize: heading4.sp),
                      ),
                      DateYear()
                    ],
                  ),
                  SizedBox(height: 25.h),
                  DataNotFound(
                    imagePath: 'assets/images/not_found.png',
                    message:
                        "Belum ada daftar kehadiran. Silakan absen terlebih dahulu",
                  ),
                ],
              );
            }

            return ListView(
              physics: const AlwaysScrollableScrollPhysics(),
              padding: EdgeInsets.symmetric(horizontal: 32.w, vertical: 46.h),
              children: [
                Header(
                  title: "Detail Karyawan",
                  onPressedIcon: () {
                    Get.back();
                  },
                ),
                SizedBox(height: 32.h),
                HeaderInfo(employee: employee),
                SizedBox(height: 25.h),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Riwayat Kehadiran',
                      style: TextStyle(fontSize: heading4.sp),
                    ),
                    DateYear()
                  ],
                ),
                SizedBox(height: 25.h),
                EmployeeDetailTable(),
              ],
            );
          }),
        ),
      ),
    );
  }
}
