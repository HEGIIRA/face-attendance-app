import 'package:attendance_app/ui/const.dart';
import 'package:attendance_app/ui/components-general/custom_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class RegisterField extends StatefulWidget {
  final GlobalKey<FormState> formKey;
  final Function(String email, String password) onChanged;

  const RegisterField(
      {super.key, required this.onChanged, required this.formKey});

  @override
  State<RegisterField> createState() => _RegisterFieldState();
}

class _RegisterFieldState extends State<RegisterField> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();

  @override
  void initState() {
    super.initState();
    emailController.addListener(() {
      widget.onChanged(emailController.text, passwordController.text);
    });
    passwordController.addListener(() {
      widget.onChanged(emailController.text, passwordController.text);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: widget.formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Selamat Datang",
            style: TextStyle(
              fontSize: heading3.sp,
              fontWeight: FontWeight.w600,
              decoration: TextDecoration.none,
              color: text400,
            ),
          ),
          SizedBox(height: 46.h),
          CustomField(
            label: "Email",
            controller: emailController,
            validator: (value) {
              print("validating email: $value");
              if (value == null || value.isEmpty)
                return 'email tidak boleh kosong';
              if (!value.contains('@')) return 'Email harus mengandung "@"';
              return null;
            },
          ),
          SizedBox(height: 16.h),
          CustomField(
            label: "Buat Kata Sandi",
            controller: passwordController,
            isPassword: true,
            validator: (value) {
              print("validating password: $value");
              if (value == null || value.isEmpty) {
                return 'Kata sandi tidak boleh kosong';
              }
              if (value.length < 8) {
                return 'Password minimal 8 karakter!';
              }
              return null;
            },
          ),
          SizedBox(height: 16.h),
          CustomField(
            label: "Konfirmasi kata sandi",
            controller: confirmPasswordController,
            isPassword: true,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Kata sandi tidak boleh kosong';
              }
              if (value != passwordController.text) {
                return 'Kata sandi tidak cocok!';
              }
              return null;
            },
          )
        ],
      ),
    );
  }
}
