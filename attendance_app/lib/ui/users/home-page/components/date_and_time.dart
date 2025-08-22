import 'package:attendance_app/ui/const.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';

class DateAndTime extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final now = DateTime.now();

    final String jam = DateFormat.Hm().format(now);
    final String tanggal = DateFormat('EEEE, d MMM yyyy', 'id_ID').format(now); // Rabu, 23 Jul 2025

    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            jam,
            style: TextStyle(
              fontSize: hero1.sp, 
              fontWeight: FontWeight.w500
            ),
          ),
          Text(
            tanggal,
            style: TextStyle(
              fontSize: heading2.sp, 
              fontWeight: FontWeight.w500, 
              color: text200
            ),
          ),
        ],
      ),
    );
  }
}
