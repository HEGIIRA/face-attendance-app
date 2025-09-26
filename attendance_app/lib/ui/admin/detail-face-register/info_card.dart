import 'package:attendance_app/models/employee_model.dart';
import 'package:attendance_app/ui/const.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class InfoCard extends StatelessWidget {
  final EmployeeModel employee;

  InfoCard({super.key, required this.employee});

  @override
  Widget build(BuildContext context) {
    // final createdAtTimestamp = employee.createdAt as Timestamp?;
    final createdAtDate = employee.createdAt?.toDate(); // jadi DateTime
    final formatted = createdAtDate != null
        ? "${createdAtDate.day} ${createdAtDate.month} ${createdAtDate.year}"
        : "-";
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 40.w, vertical: 31.h),
      decoration: BoxDecoration(
        border: Border.all(
          color: text600,
          width: 0.5,
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Nama: ${employee.name}",
                style: TextStyle(
                    fontSize: heading4.sp, fontWeight: FontWeight.w500),
              ),
              SizedBox(height: 6.h),
              Text(
                "Bidang: ${employee.division}",
                style: TextStyle(
                    fontSize: heading4.sp, fontWeight: FontWeight.w500),
              ),
              SizedBox(height: 6.h),
              Text(
                "Posisi: ${employee.position}",
                style: TextStyle(
                    fontSize: heading4.sp, fontWeight: FontWeight.w500),
              ),
            ],
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                formatted,
                style: TextStyle(
                    fontSize: heading4.sp, fontWeight: FontWeight.w500),
              ),
              SizedBox(height: 6.h),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 5.h),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(50.r),
                    color: success100),
                child: Text(
                  "Wajah terdaftar dengan baik",
                  style: TextStyle(
                      fontSize: body1.sp,
                      color: success500,
                      fontWeight: FontWeight.w500),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
