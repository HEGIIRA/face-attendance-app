import 'package:attendance_app/controllers/attendance_controller.dart';
import 'package:attendance_app/controllers/date_controller.dart';
import 'package:attendance_app/ui/admin/detail-karyawan/components/popup_edit_attendance.dart';
import 'package:attendance_app/ui/components-general/data_not_found.dart';
import 'package:attendance_app/ui/const.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:intl/intl.dart';

class AttendanceTable extends StatelessWidget {
  // final List<AttendanceModel> data;
  final attendanceC = Get.find<AttendanceController>();
  final dateC = Get.find<DateController>();

  AttendanceTable({
    super.key,
    // required this.data,
  });

  final List<String> other = [
    'Jam Keluar',
  ];

  @override
  Widget build(BuildContext context) {

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 10.w),
      child: Obx(() {
        final filteredData = attendanceC.filteredAttendanceList;

        if (filteredData.isEmpty) {
          return DataNotFound(
              imagePath: 'assets/images/not_found.png',
              message: "Maaf, riwayat tidak tersedia di Tanggal ini.");
        }
        return Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10),
              boxShadow: [
                BoxShadow(
                  blurRadius: 10,
                  offset: Offset(0, 4),
                  color: Colors.black.withOpacity(0.1),
                ),
              ],
            ),
            child: Column(children: [
              // HEADER
              Container(
                decoration: BoxDecoration(
                  color: primary600,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(12),
                    topRight: Radius.circular(12),
                  ),
                ),
                padding: EdgeInsets.symmetric(vertical: 10.h, horizontal: 10.w),
                child: Row(
                  children: [
                    Expanded(
                        flex: 1,
                        child: Center(
                          child: Text('No.',
                              style: TextStyle(
                                  fontSize: body1.sp,
                                  fontWeight: FontWeight.w700,
                                  color: Colors.white)),
                        )),
                        Expanded(
                        flex: 3,
                        child: Center(
                          child: Text('Nama Karyawan',
                              style: TextStyle(
                                  fontSize: body1.sp,
                                  fontWeight: FontWeight.w700,
                                  color: Colors.white)),
                        )),
                        Expanded(
                        flex: 2,
                        child: Center(
                          child: Text('Bidang',
                              style: TextStyle(
                                  fontSize: body1.sp,
                                  fontWeight: FontWeight.w700,
                                  color: Colors.white)),
                        )),
                    Expanded(
                        flex: 2,
                        child: Obx(
                          () => FittedBox(
                            child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(attendanceC.selectedHour.value,
                                      style: TextStyle(
                                          fontSize: body1.sp,
                                          fontWeight: FontWeight.w700,
                                          color: Colors.white)),
                                  PopupMenuButton<String>(
                                    color: Colors.white,
                                    icon: Icon(Icons.arrow_drop_down_sharp,
                                        color: Colors.white),
                                    onSelected: (value) =>
                                        attendanceC.changeHour(value),
                                    itemBuilder: (context) => attendanceC
                                        .dropdownOptions
                                        .map((item) => PopupMenuItem<String>(
                                              value: item,
                                              child: Text(item),
                                            ))
                                        .toList(),
                                  ),
                                ]),
                          ),
                        )),
                    Expanded(
                        flex: 2,
                        child: Center(
                          child: Text('Status',
                              style: TextStyle(
                                  fontSize: body1.sp,
                                  fontWeight: FontWeight.w700,
                                  color: Colors.white)),
                        )),
                    
                    
                  ],
                ),
              ),

              // DATA ROWS
              ...filteredData.asMap().entries.map((entry) {
                // final index = entry.key;
                final index = entry.key;
                final item = entry.value;
                final status = item.status ?? '';
                final isTidakHadir = status == 'Tidak Hadir';

                return Padding(
                  padding:
                      EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
                  child: Row(
                    children: [
                      Expanded(
                        flex: 1,
                        child: Center(
                            child: Text(
                          "${index + 1}"
                        )), //isinya tanggal sesuai sama selected month yang dipilih di date tadi
                      ),
                      Expanded(
                          flex: 3,
                          child: Center(
                              child: Text(
                            (item.name).length > 10
                                ? (item.name.substring(0, 10) + '...')
                                : (item.name),
                            maxLines: 1, // batas baris
                            overflow: TextOverflow.ellipsis, //bakal ngasih dot
                          ))),
                      Expanded(
                          flex: 2,
                          child: Center(
                              child: Text(
                            (item.division).length > 10
                                ? (item.division.substring(0, 10) + '...')
                                : (item.division),
                            maxLines: 1, // batas baris
                            overflow: TextOverflow.ellipsis, //bakal ngasih dot
                          ))),
                      Expanded(
                          flex: 2,
                          child: Center(child: Obx(() {
                            return Text(
                              attendanceC.selectedHour.value == "Jam Hadir"
                                  ? (item.checkIn ?? "-")
                                  : (item.checkOut ?? "-"),
                            );
                          }))),
                      Expanded(
                        flex: 2,
                        child: Container(
                          padding: isTidakHadir
                              ? EdgeInsets.symmetric(
                                  horizontal: 7.w, vertical: 4.h)
                              : EdgeInsets.symmetric(
                                  horizontal: 12.w, vertical: 4.h),
                          decoration: BoxDecoration(
                            color: isTidakHadir ? error100 : success100,
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Text(
                            status,
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                color: isTidakHadir ? error500 : success500,
                                fontSize: body1.sp),
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              }).toList(),
            ]));
      }),
    );
  }
}
