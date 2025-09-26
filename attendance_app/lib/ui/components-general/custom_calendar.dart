import 'package:attendance_app/ui/const.dart';
import 'package:attendance_app/controllers/date_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:intl/intl.dart';

class CustomCalendar extends StatelessWidget {
  late DateTime focusedDay;
  final dateC = Get.find<DateController>();

  @override
  Widget build(BuildContext context) {
    // final selectedDate = dateC.selectedDate.value;
    final now = DateTime.now();
    // final isLastMonthAllowed = focusedDay.month == now.month && focusedDay.year == now.year;

    return Obx(() {
      final focusedDay = dateC.focusedDay.value;
      final selectedDate = dateC.selectedDate.value;
      final isLastMonthAllowed =
          focusedDay.year == now.year && focusedDay.month >= now.month;

      return Dialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        child: Container(
          height: 620.h,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.all(Radius.circular(10.r)),
          ),
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 35.w, vertical: 45.h),
            child: Column(
              children: [
                // HEADER
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        IconButton(
                          icon:
                              Icon(Icons.close, color: primary600, size: 34.w),
                          onPressed: () => Navigator.pop(context),
                          padding: EdgeInsets.zero,
                          constraints: const BoxConstraints(),
                        ),
                        SizedBox(width: 30.w),
                        Text(
                          DateFormat.yMMMM('id_ID').format(focusedDay),
                          style: TextStyle(
                            fontSize: heading3.sp,
                            fontWeight: FontWeight.w500,
                            color: text400,
                          ),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        IconButton(
                          icon: Icon(Icons.chevron_left,
                              color: primary600, size: 34.w),
                          onPressed: () {
                            dateC.setFocusedDay(DateTime(
                                focusedDay.year, focusedDay.month - 1));
                          },
                          padding: EdgeInsets.zero,
                          constraints: const BoxConstraints(),
                        ),
                        SizedBox(width: 40.w),
                        IconButton(
                          icon: Icon(
                            Icons.chevron_right,
                            color:
                                isLastMonthAllowed ? Colors.grey : primary600,
                            size: 34.w,
                          ),
                          onPressed: isLastMonthAllowed
                              ? null
                              : () {
                                  dateC.setFocusedDay(DateTime(
                                      focusedDay.year, focusedDay.month + 1));
                                },
                          padding: EdgeInsets.zero,
                          constraints: const BoxConstraints(),
                        ),
                      ],
                    ),
                  ],
                ),
                SizedBox(height: 10.h),
                Divider(),
                SizedBox(height: 10.h),

                // TABLE CALENDAR
                TableCalendar(
                  locale: 'id_ID',
                  headerVisible: false,
                  focusedDay: focusedDay,
                  // UNTUK BATAS TAHUN DI KALENDER 
                  firstDay: DateTime(2025),
                  lastDay: DateTime(2050),
                  selectedDayPredicate: (day) => isSameDay(day, selectedDate),
                  onDaySelected: (selectedDay, newFocusedDay) {
                    dateC.setDate(selectedDay);
                    Navigator.pop(context);
                  },
                  daysOfWeekHeight: 50,
                  daysOfWeekStyle: DaysOfWeekStyle(
                    weekdayStyle: TextStyle(
                        fontSize: heading5.sp, fontWeight: FontWeight.w500),
                    weekendStyle: TextStyle(
                      fontSize: heading5.sp,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  calendarStyle: CalendarStyle(
                    outsideTextStyle: TextStyle(
                      color: text300,
                      fontSize: heading5.sp,
                    ),
                    defaultTextStyle: TextStyle(
                        fontSize: heading5.sp, fontWeight: FontWeight.w500),
                    weekendTextStyle: TextStyle(
                      fontSize: heading5.sp,
                      fontWeight: FontWeight.w500,
                      color: error500,
                    ),
                    todayTextStyle: TextStyle(
                      fontSize: heading5.sp,
                      fontWeight: FontWeight.w500,
                      color: Colors.white,
                    ),
                    todayDecoration: BoxDecoration(
                      color: primary400,
                      shape: BoxShape.circle,
                    ),
                    selectedTextStyle: TextStyle(
                      fontSize: heading5.sp,
                      fontWeight: FontWeight.w500,
                      color: Colors.white,
                    ),
                    selectedDecoration: BoxDecoration(
                      color: primary600,
                      shape: BoxShape.circle,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      );
    });
  }
}
