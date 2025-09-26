import 'package:attendance_app/ui/components-general/custom_year_picker.dart';
import 'package:attendance_app/ui/const.dart';
import 'package:attendance_app/controllers/date_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class DateYear extends StatelessWidget {
  const DateYear({super.key});

  // bool isSameDate(DateTime a, DateTime b) {
  //   return a.month == b.month;
  // }

  @override
  Widget build(BuildContext context) {
    final dateC = Get.find<DateController>();

    return SizedBox(
      width: 210,
      child: Obx(() {
        final selectedDate = dateC.selectedDate.value;
        final formattedDate =
            DateFormat('MMMM yyyy', 'id_ID').format(selectedDate);

        return Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            IconButton(
              icon: Icon(Icons.arrow_back_ios, size: 30.w, color: primary600,),
              onPressed: dateC.previousMonth,
            ),
            Row(
              children: [
                InkWell(
                  onTap: () {
                    showDialog(
                      context: context,
                      builder: (_) => CustomYearPicker(),
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
              icon: Icon(Icons.arrow_forward_ios, size: 30.w,
              color: dateC.isCurrentMonthAndYear() ? text500 : primary600,
              ),
              onPressed: dateC.isCurrentMonthAndYear() ? null : dateC.nextMonth,
              
            ),
          ],
        );
      }),
    );
  }
}
