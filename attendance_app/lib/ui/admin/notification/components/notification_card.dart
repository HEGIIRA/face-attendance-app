import 'package:attendance_app/controllers/attendance_controller.dart';
import 'package:attendance_app/controllers/employee_controller.dart';
import 'package:attendance_app/ui/admin/detail-karyawan/detail_karyawan_screen.dart';
import 'package:attendance_app/ui/const.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class NotificationCard extends StatelessWidget {
  final Map<String, dynamic> item;
  final attendanceC = Get.find<AttendanceController>();
  final employeeC = Get.find<EmployeeController>();

  NotificationCard({super.key, required this.item});

  @override
  Widget build(BuildContext context) {
    final nama = item["name"] ?? "-";
    final issue = item["description"] ?? "-";
    final status = item["issueStatus"] ?? "-";

    return Container(
      margin: EdgeInsets.symmetric(vertical: 16.h),
      padding: EdgeInsets.symmetric(vertical: 28.h, horizontal: 26.w),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(
          color: text300,
          width: 1,
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // info kiri
          Row(
            children: [
              Icon(Icons.circle,
                  size: 15.w,
                  color: status == "pending" ? primary600 : text100),
              SizedBox(width: 20.w),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    nama,
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: heading4.sp,
                      color: status == "pending" ? text400 : text600,
                    ),
                  ),
                  SizedBox(height: 4.h),
                  Text(
                    attendanceC.formatDateTime(item["issueDate"]),
                    style: TextStyle(
                      color: status == "pending" ? text400 : text600,
                      fontSize: heading5.sp,
                    ),
                  ),
                  SizedBox(
                    height: 5.h,
                  ),
                  Container(
                    padding:
                        EdgeInsets.symmetric(vertical: 5.h, horizontal: 20.w),
                    decoration: BoxDecoration(
                        color: status == "pending" ? error100 : text100,
                        borderRadius: BorderRadius.circular(20.r)),
                    child: Text(
                      issue,
                      style: TextStyle(
                          color: status == "pending" ? error500 : text600,
                          fontWeight: FontWeight.w500,
                          fontSize: heading5.sp),
                    ),
                  ),
                ],
              ),
            ],
          ),
          // waktu kanan

          ElevatedButton(
              onPressed: () {
                final employeeId = item["employeeId"];
                final employee = employeeC.getEmployeeById(employeeId);

                if (employee != null) {
                  attendanceC.fetchHistoryByEmployee(employee.id);
                  Get.to(() => DetailKaryawanScreen(employee: employee));
                } else {
                  Get.snackbar(
                      "Error", "Employee dengan ID $employeeId gak ditemukan");
                }
              },
              child: Text("Tindak Lanjut",
                  style: TextStyle(
                      color: status == "pending" ? Colors.white : text600,
                      fontSize: heading5.sp)),
              style: ElevatedButton.styleFrom(
                  backgroundColor: status == "pending" ? primary600 : text100,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10), // bikin rounded
                  ),
                  padding:
                      EdgeInsets.symmetric(vertical: 12.h, horizontal: 27.w)))
        ],
      ),
    );
  }
}
