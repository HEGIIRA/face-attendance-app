import 'package:attendance_app/controllers/admin_controller.dart';
import 'package:attendance_app/controllers/auth_controller.dart';
import 'package:attendance_app/ui/const.dart';
import 'package:attendance_app/ui/components-general/custom_button.dart';
import 'package:attendance_app/ui/components-general/header.dart';
import 'package:attendance_app/ui/users/login-page/components/login_field.dart';
import 'package:attendance_app/ui/users/register-page/register_screen.dart';
import 'package:attendance_app/ui/users/home-page/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class LoginScreen extends StatelessWidget {
  LoginScreen({super.key});
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
                title: "Login",
                onPressedIcon: () => Get.back(),
              ),
              SizedBox(height: 10.h),
              Image.asset(
                "assets/images/diskominfo_bogor.png",
                height: 103.08.h,
                width: 323.w,
              ),
              SizedBox(height: 30.h),
              LoginField(
                  formKey: formKey,
                  onChanged: (email, password) {
                    authC.email.value = email;
                    authC.password.value = password;
                  }),
              SizedBox(height: 16.h),
              Align(
                alignment: Alignment.centerRight,
                child: GestureDetector(
                  onTap: () {},
                  child: Text(
                    "Lupa Kata Sandi?",
                    style: TextStyle(
                      color: primary600,
                      fontSize: heading5.sp,
                      fontWeight: FontWeight.w600,
                      decoration: TextDecoration.none,
                    ),
                  ),
                ),
              ),
              Spacer(), //biar si button nya kedorong ke paling bawah
              SizedBox(
                  width: double.infinity, //biar full ke samping
                  child: CustomButton(
                      text: "Masuk",
                      onPressed: () async {
                        final isValid = formKey.currentState!.validate();

                        if (isValid) {
                          // Panggil login dari AuthController
                          await authC.login();

                          // Kalau login sukses, bisa navigate ke HomeScreen
                          if (authC.isLoggedIn.value) {
                            Get.to(() => HomeScreen());
                          }
                        }
                      })),
              SizedBox(height: 20.h),
              GestureDetector(
                onTap: () {
                  Get.to(RegisterScreen());
                },
                child: Text(
                  "Belum punya akun? Daftar",
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
