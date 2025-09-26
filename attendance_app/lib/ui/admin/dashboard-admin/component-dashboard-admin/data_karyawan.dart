import 'package:attendance_app/controllers/attendance_controller.dart';
import 'package:attendance_app/controllers/employee_controller.dart';
import 'package:attendance_app/ui/admin/detail-karyawan/detail_karyawan_screen.dart';
import 'package:attendance_app/ui/const.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class DataKaryawan extends StatelessWidget {
  final attendnaceC = Get.find<AttendanceController>();
  final employeeC = Get.find<EmployeeController>();
  DataKaryawan({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 450.h, // kasih tinggi fix biar container jelas areanya
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: primary100,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        children: [
          // SEARCH BAR
          TextField(
            onChanged: (value) => employeeC.setSearchQuery(value),
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
              prefixIcon: Icon(Icons.search),
            ),
          ),
          SizedBox(height: 12.h),

          // LIST YANG BISA SCROLL
          Expanded(
            child: Obx(() {
              if (employeeC.isLoading.value) {
                return const Center(child: CircularProgressIndicator());
              } else if (employeeC.filteredEmployeeList.isEmpty) {
                return const Center(child: Text("Tidak ada data karyawan"));
              } else {
                return ListView.builder(
                  itemCount: employeeC.filteredEmployeeList.length,
                  itemBuilder: (context, index) {
                    final employee = employeeC.filteredEmployeeList[index];
                    return Container(
                      margin: EdgeInsets.only(bottom: 12.h),
                      padding: EdgeInsets.symmetric(
                        horizontal: 31.w,
                        vertical: 24.h,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Row(
                        children: [
                          Text(
                            '${index + 1}'.padLeft(2, '0'),
                            style: TextStyle(
                              fontWeight: FontWeight.w600,
                              fontSize: heading3.sp,
                            ),
                          ),
                          SizedBox(width: 30.w),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  employee.name,
                                  style: TextStyle(
                                    fontSize: heading4.sp,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                                SizedBox(height: 6.h),
                                Row(
                                  children: [
                                    Container(
                                      padding: EdgeInsets.symmetric(
                                        horizontal: 25.w,
                                        vertical: 2.h,
                                      ),
                                      decoration: BoxDecoration(
                                        color: primary100,
                                        borderRadius:
                                            BorderRadius.circular(50.r),
                                      ),
                                      child: Text(
                                        employee.division,
                                        style: TextStyle(
                                          fontSize: body1.sp,
                                          color: primary600,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                    ),
                                    SizedBox(width: 10.w),
                                    Text(
                                      employee.position,
                                      style: TextStyle(
                                        fontSize: body1.sp,
                                        color: primary600,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                          ElevatedButton(
                            onPressed: () {
                              attendnaceC.fetchHistoryByEmployee(employee.id);
                              Get.to(() =>
                                  DetailKaryawanScreen(employee: employee));
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: primary600,
                              padding: EdgeInsets.symmetric(
                                horizontal: 57.w,
                                vertical: 10.h,
                              ),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                            ),
                            child: Text(
                              'Detail',
                              style: TextStyle(
                                fontSize: heading5.sp,
                                color: Colors.white,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                );
              }
            }),
          ),
        ],
      ),
    );
  }
}
