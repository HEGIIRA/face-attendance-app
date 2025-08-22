import 'package:attendance_app/ui/const.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class RekapCard extends StatelessWidget {
  final IconData icon;
  final String label;
  final String value;
  final String suffix;

  const RekapCard({
    super.key,
    required this.icon,
    required this.label,
    required this.value,
    required this.suffix,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 40.w, vertical: 40.h),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 13,
            offset: Offset(0, 4),
          )
        ],
      ),
      child: Row(
        children: [
          CircleAvatar(
            radius: 25,
            backgroundColor: primary100,
            child: Icon(icon, color: primary600, size: 30.w),
          ),
          SizedBox(width: 20.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  label,
                  style: TextStyle(
                      fontSize: body2.sp,
                      color: text500,
                      fontWeight: FontWeight.w700),
                ),
                SizedBox(height: 2.h),
                RichText(
                  text: TextSpan(
                    children: [
                      TextSpan(
                        text: value,
                        style: TextStyle(
                          fontSize: heading1.sp,
                          fontWeight: FontWeight.w600,
                          color: text400,
                        ),
                      ),
                      TextSpan(
                        text:
                            ' $suffix', //dolar untuk kasih spasi sebelum string
                        style: TextStyle(
                          fontSize: body1.sp,
                          fontWeight: FontWeight.w600,
                          color: text400,
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
