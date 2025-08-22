import 'package:attendance_app/ui/const.dart';
import 'package:attendance_app/ui/state-management/date_provider.dart';
import 'package:attendance_app/ui/users/status-page/components/custom_calendar.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class HistoryUser extends StatelessWidget {
  const HistoryUser({super.key});

  bool isSameDate(DateTime a, DateTime b) {
    return a.year == b.year && a.month == b.month && a.day == b.day;
  }

  @override
  Widget build(BuildContext context) {
    final dateProvider = Provider.of<DateProvider>(context);
    final selectedDate = dateProvider.selectedDate;
    final formattedDate =
        DateFormat('EEEE, d MMMM y', 'id_ID').format(selectedDate);

    return SizedBox(
      width: 374,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          IconButton(
              icon: const Icon(Icons.arrow_back_ios),
              onPressed: dateProvider.previousDate),
          Row(
            children: [
              InkWell(
                onTap: () {
                  showDialog(
                    context: context,
                    builder: (_) => CustomCalendar(),
                  );
                },
                child: Row(
                  children: [
                    const Icon(Icons.calendar_month_outlined),
                    const SizedBox(width: 8),
                    Text(
                      formattedDate,
                      style: TextStyle(
                          fontSize: heading5, fontWeight: FontWeight.w600),
                    ),
                  ],
                ),
              ),
            ],
          ),
          IconButton(
            icon: const Icon(Icons.arrow_forward_ios),
            onPressed: isSameDate(selectedDate, DateTime.now())
                ? null
                : dateProvider.nextDate,
          ),
        ],
      ),
    );
  }
}
