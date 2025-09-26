import 'package:attendance_app/models/employee_model.dart';
import 'package:attendance_app/ui/const.dart';
import 'package:attendance_app/ui/admin/detail-karyawan/components/edit_form.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

void popupEdit(BuildContext context, EmployeeModel employee) {
  // final EmployeeModel employee;

  showGeneralDialog(
    context: context,
    barrierDismissible:
        true, //Kalau `true`, berarti bisa nutup popup dengan **klik di luar popup** (area gelap).
    barrierLabel: "Close",
    transitionDuration: Duration(milliseconds: 300),
    pageBuilder: (context, animation, secondaryAnimation) {
      return Align(
        alignment: Alignment.center,
        child: Material(
            color: const Color.fromARGB(0, 91, 209, 224),
            child: Container(
              width: 750.w,
              height: 600.h,
              padding: EdgeInsets.symmetric(horizontal: 56.w, vertical: 50.h),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10.r),
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    "Edit Karyawan",
                    style: TextStyle(
                      color: text400,
                      fontSize: heading1.sp,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  SizedBox(height: 20.h),
                  EditForm(employee: employee),
                ],
              ),
            )),
      );
    },
    transitionBuilder: (context, animation, secondaryAnimation, child) {
      return ScaleTransition(
        //kalo mau kyk meluncur dri atas, pake SlideTransition
        scale: CurvedAnimation(
          parent: animation,
          curve: Curves.easeOutBack, // biar ada efek mantul dikit
        ),
        child: child,
      );
    },
  );
}
