import 'package:attendance_app/ui/const.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class Header extends StatelessWidget {
  final String title;
  final VoidCallback onPressedIcon;

  const Header({
    super.key,
    required this.title,
    required this.onPressedIcon,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 60.h, // atur tinggi header
      child: Stack(
        alignment: Alignment.center,
        children: [
          // Kiri
          Align(
            alignment: Alignment.centerLeft,
            child: IconButton(
              icon: Icon(Icons.arrow_back, color: primary600, size: 30.h,),
                onPressed: onPressedIcon
            )
          ),
          Center(
            child: Text(
              title,
              style: TextStyle(
                fontSize: heading2.sp,
                color: text400,
                decoration: TextDecoration.none,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
