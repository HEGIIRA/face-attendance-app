import 'package:attendance_app/controllers/admin_controller.dart';
import 'package:attendance_app/ui/const.dart';
import 'package:attendance_app/ui/components-general/custom_button.dart';
import 'package:attendance_app/ui/components-general/header.dart';
import 'package:attendance_app/ui/admin/dashboard-admin/dashboard_admin_screen.dart';
import 'package:attendance_app/ui/users/admin-mode-page/components/admin_mode_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';


class AdminModeScreen extends StatelessWidget {
  AdminModeScreen({super.key});
  final adminC = Get.find<AdminController>();
  final formKey = GlobalKey<FormState>();


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Padding(
        padding:  EdgeInsets.symmetric(horizontal: 32.w, vertical: 100.h),
        child: Column(
          children: [
            Header(
              title: "Mode Admin",
              onPressedIcon: () => Get.back(),
            ),
            SizedBox(height: 30.h),
            Image.asset(
              "assets/images/diskominfo_bogor.png",
              height: 103.08.h,
              width: 323.w,
            ),
            SizedBox(height: 70.h),
            AdminModeField(
                formKey: formKey,
                onChanged: (kode) {
                  adminC.adminCode.value = kode;
                }),
            SizedBox(height: 16.h),
           
            Spacer(), //biar si button nya kedorong ke paling bawah
            SizedBox(
                width: double.infinity, //biar full ke samping
                child: CustomButton(
                  text: "Kirim",
                  onPressed: () async {
                    bool isValid =
                        await Get.find<AdminController>().validateAdminCode();
                    if (isValid) {
                      // Arahkan ke dashboard admin
                      Get.to(() => DashboardAdminScreen());
                    } else {
                      // Tampilkan error
                      Get.snackbar('Gagal', 'Kode salah, coba lagi!');
                    }
                  },
                ))
          ],
        ),
      ),
    );
  }
}





