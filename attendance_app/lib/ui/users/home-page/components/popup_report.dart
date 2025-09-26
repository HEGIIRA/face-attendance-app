import 'package:attendance_app/controllers/attendance_controller.dart';
import 'package:attendance_app/ui/const.dart';
import 'package:attendance_app/ui/users/home-page/components/report_form.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

void popupReport(BuildContext context) {
  final attendanceC = Get.find<AttendanceController>();
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
              width: 766.w,
              // height: 550.h,
              padding: EdgeInsets.symmetric(horizontal: 58.w, vertical: 70.h),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10.r),
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    "Hubungi Admin",
                    style: TextStyle(
                      color: text400,
                      fontSize: heading1.sp,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  SizedBox(height: 20.h),
                  Text(
                      "Jika mengalami kendala saat melakukan absensi, silakan isi detail kendala yang kamu alami pada form berikut.",
                      style: TextStyle(
                        color: text600,
                        fontSize: heading4.sp,
                      ),
                      textAlign: TextAlign.center),
                  SizedBox(height: 46.h),
                  ReportForm(),
                  SizedBox(height: 65.h),
                  Row(
                    children: [
                      Expanded(
                        child: ElevatedButton(
                            onPressed: () {
                              attendanceC.issue.value = "";
                              attendanceC.name.value = "";
                              Get.back();
                            },
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
                              attendanceC.sendReport();
                              Get.back();
                            },
                            child: Text("Kirim Laporan",
                                style: TextStyle(
                                    fontSize: heading4.sp,
                                    color: Colors.white)),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: primary600,
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
