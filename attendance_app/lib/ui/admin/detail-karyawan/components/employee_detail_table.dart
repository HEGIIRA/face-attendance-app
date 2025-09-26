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

class EmployeeDetailTable extends StatelessWidget {
  // final List<AttendanceModel> data;
  final attendanceC = Get.find<AttendanceController>();
  final dateC = Get.find<DateController>();

  EmployeeDetailTable({
    super.key,
    // required this.data,
  });

  final List<String> other = [
    'Jam Keluar',
  ];

  @override
  Widget build(BuildContext context) {
    // final selectedDate = dateC.selectedDate.value;
    // final data = attendanceC.historyPerEmployee;

    // filter data sesuai bulan & tahun selectedDate
    // final filteredData = data.where((item) {
    //   if (item.date == null) return false;
    //   return item.date!.month == selectedDate.month &&
    //       item.date!.year == selectedDate.year;
    // }).toList();

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 10.w),
      child: Obx(() {
        final allData = attendanceC.historyPerEmployee;
        final selectedDate = dateC.selectedDate.value;
        // filter sesuai bulan & tahun
        final filteredData = allData.where((item) {
          if (item.date == null) return false;
          return item.date!.month == selectedDate.month &&
              item.date!.year == selectedDate.year;
        }).toList();

        if (filteredData.isEmpty) {
          return DataNotFound(
              imagePath: 'assets/images/not_found.png',
              message: "Maaf, riwayat tidak tersedia di Bulan ini.");
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
                padding: EdgeInsets.symmetric(vertical: 10.h, horizontal: 16.w),
                child: Row(
                  children: [
                    Expanded(
                        flex: 2,
                        child: Center(
                          child: Text('Tanggal',
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
                                          fontSize: heading5.sp,
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
                    Expanded(
                        flex: 3,
                        child: Center(
                          child: Text('Keterangan',
                              style: TextStyle(
                                  fontSize: body1.sp,
                                  fontWeight: FontWeight.w700,
                                  color: Colors.white)),
                        )),
                    Expanded(
                        flex: 1,
                        child: Center(
                          child: Text('Aksi',
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
                final item = entry.value;
                final status = item.status ?? '';
                final isTidakHadir = status == 'Tidak Hadir';

                return Padding(
                  padding:
                      EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
                  child: Row(
                    children: [
                      Expanded(
                        flex: 2,
                        child: Center(
                            child: Text(
                          item.date != null
                              ? DateFormat('dd MMM').format(item.date!)
                              : '-',
                        )), //isinya tanggal sesuai sama selected month yang dipilih di date tadi
                      ),
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
                      Expanded(
                          flex: 3,
                          child: Center(
                              child: Text(
                            (item.description ?? '-').length > 10
                                ? (item.description!.substring(0, 10) + '...')
                                : (item.description ?? '-'),
                            maxLines: 1, // batas baris
                            overflow: TextOverflow.ellipsis, //bakal ngasih dot
                          ))),
                      Expanded(
                          flex: 1,
                          child: Center(
                              child: InkWell(
                            onTap: () {
                              // popupEditAttendance(context, attendanceData);
                            },
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Icon(Icons.edit, color: primary600, size: 25.w,),
                                Text(
                                  "Edit",
                                  style: TextStyle(color: primary600, fontSize: body1.sp),
                                ),
                              ],
                            ),
                          ))),
                    ],
                  ),
                );
              }).toList(),
            ]));
      }),
    );
  }
}
