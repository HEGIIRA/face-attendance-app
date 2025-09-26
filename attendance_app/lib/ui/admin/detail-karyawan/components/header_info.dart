import 'package:attendance_app/models/employee_model.dart';
import 'package:attendance_app/ui/admin/detail-karyawan/components/popup_delete.dart';
import 'package:attendance_app/ui/admin/detail-karyawan/components/popup_edit.dart';
import 'package:attendance_app/ui/const.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class HeaderInfo extends StatelessWidget {
  final EmployeeModel employee;
  HeaderInfo({super.key, required this.employee});

  @override
  Widget build(BuildContext context) {
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
                employee.name,
                style: TextStyle(
                    fontSize: heading3.sp, fontWeight: FontWeight.w600,),
              ),
              SizedBox(width: 10.w),
              Row(
                children: [
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 3.h),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(50.r),
                      color: primary100
                    ),
                    child: Text(
                     employee.division,
                      style: TextStyle(fontSize: body1.sp, color: primary600, fontWeight: FontWeight.w500),
                    ),
                  ),
                  SizedBox(width: 10.w),
                  Text(
                employee.position,
                style: TextStyle(fontSize: body1.sp, color: primary600, fontWeight: FontWeight.w500),
              ),
                ],
              ),
              
            ],
          ),
          Row(
            children: [
              IconButton(
                icon: Icon(Icons.edit, color: primary600),
                onPressed: () {
                  popupEdit(context, employee);
                }
              ),
              IconButton(
              icon: Icon(Icons.delete, color: error400),
              onPressed: () {
                popupDelete(context, employee);
              }
              )
            ],
          )
        ],
      ),
    );
  }
}
