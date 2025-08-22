import 'package:attendance_app/ui/const.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;
  final bool isActive;

  const CustomButton({
    super.key,
    required this.text,
    required this.onPressed,
    this.isActive = true,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: isActive ? onPressed : null,
      style: ElevatedButton.styleFrom(
        padding: EdgeInsets.symmetric(vertical: 15.h),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        backgroundColor: isActive ? primary600 : Colors.grey,
      ),
      child: Text(
        text,
        style: TextStyle(
            color: isActive ? Colors.white : text300, fontSize: heading3.sp),
      ),
    );
  }
}
