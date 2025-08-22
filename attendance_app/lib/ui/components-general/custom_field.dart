import 'package:attendance_app/ui/const.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomField extends StatefulWidget {
  final String label;
  final TextEditingController controller;
  final bool isPassword;
  final String? Function(String?)? validator;

  const CustomField({
    super.key,
    required this.label,
    required this.controller,
    this.isPassword = false,
    this.validator,
  });

  @override
  State<CustomField> createState() => _CustomFieldState();
}

class _CustomFieldState extends State<CustomField> {
  bool _obscure = true;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          widget.label,
          style: TextStyle(fontSize: heading5.sp, fontWeight: FontWeight.w600),
        ),
        SizedBox(height: 16.h),
        TextFormField(
          style: TextStyle(
              fontSize: heading5.sp,
              fontWeight: FontWeight.w600,
              color: text400),
          controller: widget.controller,
          obscureText: widget.isPassword ? _obscure : false,
          validator: widget.validator,
          decoration: InputDecoration(
              hintText: 'Masukkan ${widget.label}',
              hintStyle: TextStyle(
                  fontSize: heading5.sp,
                  fontWeight: FontWeight.w600,
                  color: text300),
              suffixIcon: widget.isPassword
                  ? IconButton(
                      icon: Icon(
                        _obscure ? Icons.visibility_off : Icons.visibility,
                        color: primary600,
                        size: 30.w,
                      ),
                      onPressed: () {
                        setState(() {
                          _obscure = !_obscure;
                        });
                      },
                    )
                  : null,
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide(color: Colors.grey, width: 1.5.w),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide(color: primary600, width: 1.5.w),
              ),
              contentPadding:
                  EdgeInsets.symmetric(horizontal: 16.w, vertical: 28.h)),
        ),
      ],
    );
  }
}
