import 'package:attendance_app/ui/const.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class DataNotFound extends StatelessWidget {
  final String imagePath;
  final String message;
  const DataNotFound({super.key, required this.imagePath, required this.message});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(imagePath, width: 400.w),
          SizedBox(
            height: 20.h,
          ),
          Text(
            message,
            style:
                TextStyle(fontSize: heading4.sp, fontWeight: FontWeight.w500),
          ),
        ],
      ),
    );
  }
}
