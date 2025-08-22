import 'package:attendance_app/ui/const.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class Location extends StatelessWidget {
  const Location({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(Icons.location_on_outlined, size: 24),
        SizedBox(width: 0.5.w),
        Text(
          "Lokasi : DISKOMINFO Bogor",
          style: TextStyle(
            fontSize: heading4.sp,
            fontWeight: FontWeight.w600
          ),
        ),
      ],
    );
  }
}