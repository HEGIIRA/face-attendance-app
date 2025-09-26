import 'package:attendance_app/ui/const.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class MainHeader extends StatelessWidget {
  // final List<UserModel>? bidang;
  final String title;
  final IconData icon1;
  final IconData icon2;
  final IconData? icon3;
  final VoidCallback? onIcon1Pressed;
  final VoidCallback? onIcon2Pressed;
  final VoidCallback? onIcon3Pressed;
  

  const MainHeader({
    super.key,
    required this.title,
    // this.bidang,
    required this.icon1,
    required this.icon2,
    this.icon3,
    this.onIcon1Pressed,
    this.onIcon2Pressed,
    this.onIcon3Pressed,
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
          child: Image.asset(
            "assets/images/diskominfo_bogor.png",
            height: 50.h,
            width: 150.w,
          ),
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
        // Kanan (row icon fleksibel)
        Align(
          alignment: Alignment.centerRight,
          child: Row(
            mainAxisSize: MainAxisSize.min, // biar lebarnya ngepas icon aja
            children: [
              GestureDetector(
                onTap: onIcon1Pressed,
                child: Icon(icon1, size: 40.h, color: primary600),
              ),
              SizedBox(width: 30.w),
              GestureDetector(
                onTap: onIcon2Pressed,
                child: Icon(icon2, size: 40.h, color: primary600),
              ),
              if (icon3 != null) ...[
                SizedBox(width: 30.w),
                GestureDetector(
                  onTap: onIcon3Pressed,
                  child: Icon(icon3, size: 40.h, color: error400),
                ),
              ],
            ],
          ),
        ),
      ],
    ),
  );
}

}
