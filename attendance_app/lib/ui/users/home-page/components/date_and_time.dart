import 'package:attendance_app/controllers/date_controller.dart';
import 'package:attendance_app/ui/const.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class DateAndTime extends StatelessWidget {
  final dateC = Get.find<DateController>();
  // final dateC = Get.find<DateController>()..printInfo(info: "UI got this controller");


  @override
  Widget build(BuildContext context) {
    // final now = DateTime.now();

    // final String jam = DateFormat.Hm().format(now);
    // final String tanggal = DateFormat('EEEE, d MMM yyyy', 'id_ID').format(now); // Rabu, 23 Jul 2025

    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Obx( () {
             print("😎⬇️✅jam: ${dateC.jam.value}");
            return Text( 
              dateC.jam.value,
              style: TextStyle(
                fontSize: hero1.sp, 
                fontWeight: FontWeight.w500
              ),
            );
  }),
          Obx( () => Text(
              dateC.tanggal.value,
              style: TextStyle(
                fontSize: heading2.sp, 
                fontWeight: FontWeight.w500, 
                color: text200
              ),
            ),
          ),
        ],
      ),
    );
  }
}
