import 'package:attendance_app/ui/components-general/custom_calendar.dart';
import 'package:attendance_app/ui/components-general/custom_year_picker.dart';
import 'package:attendance_app/ui/const.dart';
import 'package:attendance_app/controllers/date_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class Calendar extends StatelessWidget {
  const Calendar({super.key});

  // bool isSameDate(DateTime a, DateTime b) {
  //   return a.month == b.month;
  // }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        width: 210,
        child: Row(
          children: [
            InkWell(
                onTap: () {
                  showDialog(
                    context: context,
                    builder: (_) => CustomCalendar(),
                  );
                },
                child: Icon(
                  Icons.calendar_month_outlined,
                  size: 36.w,
                  color: primary600,
                )),
          ],
        ));
  }
}
