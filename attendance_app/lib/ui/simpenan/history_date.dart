import 'package:attendance_app/ui/const.dart';
import 'package:attendance_app/controllers/date_controller.dart';
import 'package:attendance_app/ui/components-general/custom_calendar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class HistoryDate extends StatelessWidget {
  const HistoryDate({super.key});

  bool isSameDate(DateTime a, DateTime b) {
    return a.year == b.year && a.month == b.month && a.day == b.day;
  }

  @override
  Widget build(BuildContext context) {
    final dateC = Get.find<DateController>();

    return SizedBox(
      width: 180,
      child: Obx(() {
        final selectedDate = dateC.selectedDate.value;
        final formattedDate =
            DateFormat('MMMM', 'id_ID').format(selectedDate);

        return Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            IconButton(
              icon: Icon(Icons.arrow_back_ios, size: 30.w,),
              onPressed: dateC.previousDate,
            ),
            Row(
              children: [
                InkWell(
                  onTap: () {
                    showDialog(
                      context: context,
                      builder: (_) => CustomCalendar(),
                    );
                  },
                  child:
                      Text(
                        formattedDate,
                        style: TextStyle(
                          fontSize: heading5.sp,
                          fontWeight: FontWeight.w600,
                        ),
                  ),
                ),
              ],
            ),
            IconButton(
              icon: Icon(Icons.arrow_forward_ios, size: 30.w,),
              onPressed: isSameDate(selectedDate, DateTime.now())
                  ? null
                  : dateC.nextDate,
            ),
          ],
        );
      }),
    );
  }
}
