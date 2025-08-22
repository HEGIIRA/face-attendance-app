import 'package:attendance_app/ui/const.dart';
import 'package:attendance_app/ui/components-general/custom_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class LoginField extends StatefulWidget {
  final GlobalKey<FormState> formKey;
  final Function(String email, String password) onChanged;

  const LoginField({super.key, required this.onChanged, required this.formKey});

  @override
  State<LoginField> createState() => _LoginFieldState();
}

class _LoginFieldState extends State<LoginField> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

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
            "Selamat Datang Kembali!",
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
              if (value == null || value.isEmpty) return 'Wajib diisi';
              if (!value.contains('@')) return 'Email harus ada @';
              return null;
            },
          ),
          SizedBox(height: 16.h),
          CustomField(
            label: "Kata Sandi",
            controller: passwordController,
            isPassword: true,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Kata sandi tidak boleh kosong';
              }
              return null;
            }
          )
        ],
      ),
    );
  }
}
