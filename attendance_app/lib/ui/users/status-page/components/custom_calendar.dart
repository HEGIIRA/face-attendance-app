import 'package:attendance_app/ui/const.dart';
import 'package:attendance_app/ui/state-management/date_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:intl/intl.dart';

class CustomCalendar extends StatefulWidget {
  @override
  State<CustomCalendar> createState() => _CustomCalendarState();
}

class _CustomCalendarState extends State<CustomCalendar> {
  late DateTime focusedDay;

  @override
  void initState() {
    super.initState();
    focusedDay = Provider.of<DateProvider>(context, listen: false).selectedDate;
  }

  @override
  Widget build(BuildContext context) {
    final dateProvider = Provider.of<DateProvider>(context);
    final selectedDate = dateProvider.selectedDate;
    // Buat dapetin bulan & tahun sekarang
    final now = DateTime.now();
    final isLastMonthAllowed =
        focusedDay.month == now.month && focusedDay.year == now.year;

    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      child: Container(
        height: 600,
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.all(Radius.circular(10)),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 41, vertical: 57.53),
          child: Column(
            children: [
              // Style Header
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      IconButton(
                        icon: const Icon(Icons.close,
                            color: primary600, size: 34),
                        onPressed: () => Navigator.pop(context),
                        padding: EdgeInsets.zero,
                        constraints: const BoxConstraints(),
                      ),
                      const SizedBox(width: 30),
                      Text(
                        DateFormat.yMMMM('id_ID').format(focusedDay),
                        style: const TextStyle(
                          fontSize: heading3,
                          fontWeight: FontWeight.bold,
                          color: text400,
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      IconButton(
                        icon: const Icon(
                          Icons.chevron_left,
                          color: primary600,
                          size: 34,
                        ),
                        onPressed: () {
                          setState(() {
                            focusedDay =
                                DateTime(focusedDay.year, focusedDay.month - 1);
                          });
                        },
                        padding: EdgeInsets.zero,
                        constraints: const BoxConstraints(),
                      ),
                      const SizedBox(width: 40),
                      IconButton(
                        icon: Icon(
                          Icons.chevron_right,
                          color: isLastMonthAllowed ? Colors.grey : primary600,
                          size: 34,
                        ),
                        onPressed: isLastMonthAllowed
                            ? null
                            : () {
                                setState(() {
                                  focusedDay = DateTime(
                                      focusedDay.year, focusedDay.month + 1);
                                });
                              },
                        padding: EdgeInsets.zero,
                        constraints: const BoxConstraints(),
                      ),
                    ],
                  ),
                ],
              ),
              const SizedBox(height: 24),

              // TableCalendar
              TableCalendar(
                locale: 'id_ID',
                headerVisible: false,
                focusedDay: focusedDay,
                firstDay: DateTime(2025),
                lastDay: DateTime(2050),
                selectedDayPredicate: (day) => isSameDay(day, selectedDate),
                onDaySelected: (selectedDay, newFocusedDay) {
                  dateProvider.setDate(selectedDay);
                  Navigator.pop(context);
                },

                daysOfWeekHeight: 50,
                //UNTUK HARI
                daysOfWeekStyle: const DaysOfWeekStyle(
                  //HARI BIASA
                  weekdayStyle: TextStyle(
                      fontSize: heading5, fontWeight: FontWeight.w600),
                  //HARI WEEKEND
                  weekendStyle: TextStyle(
                    fontSize: heading5,
                    fontWeight: FontWeight.w600,
                  ),
                ),

                //UNTUK TANGGAL
                calendarStyle: const CalendarStyle(
                  //TANGGAL BULAN DEPAN/SEBELUMNYA
                  outsideTextStyle: TextStyle(
                    color: text300,
                    fontSize: heading5,
                  ),
                  //TANGGAL BIASA
                  defaultTextStyle: TextStyle(
                      fontSize: heading5, fontWeight: FontWeight.w600),
                  //TANGGAL WEEKEND
                  weekendTextStyle: TextStyle(
                    fontSize: heading5,
                    fontWeight: FontWeight.w600,
                    color: error500,
                  ),
                  //TANGGAL HARI INI
                  todayTextStyle: TextStyle(
                    fontSize: heading5,
                    fontWeight: FontWeight.w600,
                    color: Colors.white,
                  ),
                  //BG TANGGAL HARI INI
                  todayDecoration: BoxDecoration(
                    color: primary400,
                    shape: BoxShape.circle,
                  ),
                  //TANGGAL YG DIPILIH
                  selectedTextStyle: TextStyle(
                    fontSize: heading5,
                    fontWeight: FontWeight.w600,
                    color: Colors.white,
                  ),
                  //BG TANGGAL YG DIPILIH
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
  }
}
