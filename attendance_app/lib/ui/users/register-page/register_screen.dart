import 'package:attendance_app/controllers/admin_controller.dart';
import 'package:attendance_app/controllers/auth_controller.dart';
import 'package:attendance_app/ui/const.dart';
import 'package:attendance_app/ui/components-general/custom_button.dart';
import 'package:attendance_app/ui/components-general/header.dart';
import 'package:attendance_app/ui/users/category-register-page/category_register_screen.dart';
import 'package:attendance_app/ui/users/login-page/login_screen.dart';
import 'package:attendance_app/ui/users/register-page/components/register_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class RegisterScreen extends StatelessWidget {
  RegisterScreen({super.key});
  final authC = Get.find<AuthController>();
  final adminC = Get.find<AdminController>();
  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 32.w, vertical: 46.h),
          child: Column(
            children: [
              Header(
                title: "Daftar",
                onPressedIcon: () => Get.back(),
              ),
              SizedBox(height: 10.h),
              Image.asset(
                "assets/images/diskominfo_bogor.png",
                height: 103.08.h,
                width: 323.w,
              ),
              SizedBox(height: 30.h),
              RegisterField(
                  formKey: formKey,
                  onChanged: (email, password) {
                    authC.email.value = email;
                    authC.password.value = password;
                  }),
              const Spacer(), //biar si button nya kedorong ke paling bawah

              SizedBox(
                  width: double.infinity, //biar full ke samping
                  child: CustomButton(
                    text: "Selanjutnya",
                    onPressed: () {
                      final isValid = formKey.currentState!.validate();
                      print("form valid? $isValid");
                      if (isValid) {
                        print("navigating to category screen...");
                        Get.to(() => CategoryRegisterScreen());
                      }
                    },
                  )),

              SizedBox(height: 20.h),
              GestureDetector(
                onTap: () {
                  Get.to(LoginScreen());
                },
                child: Text(
                  "Sudah punya akun? Login",
                  style: TextStyle(
                    color: primary600,
                    fontSize: heading5.sp,
                    fontWeight: FontWeight.w600,
                    decoration: TextDecoration.none,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
