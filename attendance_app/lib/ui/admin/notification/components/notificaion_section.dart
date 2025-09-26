import 'package:attendance_app/ui/admin/notification/components/notification_card.dart';
import 'package:attendance_app/ui/const.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class NotificationSection extends StatelessWidget {
  final String title;
  final List<Map<String, dynamic>> items;

  const NotificationSection({super.key, required this.title, required this.items});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(title, style: TextStyle(fontSize: heading4.sp, fontWeight: FontWeight.w500)),
        SizedBox(height: 7.h),
        ...items.map((item) => NotificationCard(item: item)).toList(),
      ],
    );
  }
}
