import 'package:attendance_app/controllers/auth_controller.dart';
import 'package:attendance_app/controllers/employee_controller.dart';
import 'package:attendance_app/models/employee_model.dart';
import 'package:attendance_app/ui/admin/dashboard-admin/dashboard_admin_screen.dart';
import 'package:attendance_app/ui/const.dart';
import 'package:attendance_app/ui/users/login-page/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

void popupDelete(BuildContext context, EmployeeModel employee) {
  showGeneralDialog(
    context: context,
    barrierDismissible:
        false, //Kalau `true`, berarti bisa nutup popup dengan **klik di luar popup** (area gelap).
    barrierLabel: "Close",
    transitionDuration: Duration(milliseconds: 300),
    pageBuilder: (context, animation, secondaryAnimation) {
      return Align(
        alignment: Alignment.center,
        child: Material(
            color: const Color.fromARGB(0, 91, 209, 224),
            child: Container(
              width: 655.w,
              padding: EdgeInsets.symmetric(horizontal: 58.w, vertical: 70.h),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    "Yakin ingin Hapus?",
                    style: TextStyle(
                      color: text400,
                      fontSize: heading1.sp,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  SizedBox(height: 35.h),
                  
                  Row(
                    children: [
                      Expanded(
                        child: ElevatedButton(
                            onPressed: Get.back,
                            child: Text("Batal",
                                style: TextStyle(
                                    fontSize: heading4.sp, color: text300)),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: text100,
                              foregroundColor: Colors.white,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                              padding: EdgeInsets.symmetric(
                                horizontal: 40.w,
                                vertical: 20.h,
                              ),
                            )),
                      ),
                      SizedBox(width: 16.w),
                      Expanded(
                        child: ElevatedButton(
                            onPressed: () async {
                              await Get.find<EmployeeController>().deleteEmployee(employee.id);
                              Get.offAll(() => DashboardAdminScreen());
                            },
                            child: Text("Hapus",
                                style: TextStyle(
                                    fontSize: heading4.sp,
                                    color: Colors.white)),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: error300,
                              foregroundColor: Colors.white,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                              padding: EdgeInsets.symmetric(
                                horizontal: 40.w,
                                vertical: 20.h,
                              ),
                            )),
                      ),
                    ],
                  ),
                ],
              ),
            )),
      );
    },
    transitionBuilder: (context, animation, secondaryAnimation, child) {
      return ScaleTransition( //kalo mau kyk meluncur dri atas, pake SlideTransition
        scale: CurvedAnimation(
          parent: animation,
          curve: Curves.easeOutBack, // biar ada efek mantul dikit
        ),
        child: child,
      );
    },
  );
}
