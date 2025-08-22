import 'package:attendance_app/models/attendance_model.dart';
import 'package:attendance_app/ui/const.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class TableCard extends StatelessWidget {
  // final List<Map<String, dynamic>> data;
  final List<AttendanceModel> data;

  TableCard({
    super.key,
    required this.data,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 10.w),
      child: Container(
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
        child: Column(
          children: [
            // HEADER
            Container(
              decoration: BoxDecoration(
                color: primary600,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(12),
                  topRight: Radius.circular(12),
                ),
              ),
              padding: EdgeInsets.symmetric(vertical: 20.h, horizontal: 16.w),
              child: Row(
                children: [
                  Expanded(
                      flex: 1,
                      child: Text('No.',
                          style: TextStyle(
                              fontSize: heading5.sp, fontWeight: FontWeight.w700, color: Colors.white))),
                  Expanded(
                      flex: 3,
                      child: Text('Nama Karyawan',
                          style: TextStyle(
                              fontSize: heading5.sp, fontWeight: FontWeight.w700, color: Colors.white))),
                  Expanded(
                      flex: 2,
                      child: Center(
                        child: Text('Jam Masuk',
                            style: TextStyle(
                                fontSize: heading5.sp, fontWeight: FontWeight.w700, color: Colors.white)),
                      )),
                  Expanded(
                      flex: 2,
                      child: Center(
                        child: Text('Jam Keluar',
                            style: TextStyle(
                                fontSize: heading5.sp, fontWeight: FontWeight.w700, color: Colors.white)),
                      )),
                  Expanded(
                      flex: 2,
                      child: Center(
                        child: Text('Status',
                            style: TextStyle(
                                fontSize: heading5.sp, fontWeight: FontWeight.w700, color: Colors.white)),
                      )),
                ],
              ),
            ),

            // DATA ROWS
            ...data.asMap().entries.map((entry) {
              final index = entry.key;
              final item = entry.value;
              final status = item.status ?? '';
              final isTerlambat = status == 'Terlambat';

              return Padding(
                padding:
                    EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
                child: Row(
                  children: [
                    Expanded(
                      flex: 1,
                      child: Text('${(index + 1).toString().padLeft(2, '0')}'),
                    ),
                    Expanded(flex: 3, child: Text(item.name)),
                    Expanded(flex: 2, child: Center(child: Text(item.checkIn ?? '-'))),
                    Expanded(flex: 2, child: Center(child: Text(item.checkOut ?? '-'))),
                    Expanded(
                      flex: 2,
                      child: Container(
                        padding: EdgeInsets.symmetric(
                            horizontal: 12.w, vertical: 4.h),
                        decoration: BoxDecoration(
                          color: isTerlambat
                              ? Colors.orange[100]
                              : Colors.green[100],
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Text(
                          status,
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: isTerlambat ? Colors.orange : Colors.green,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              );
            }).toList(),
          ],
        ),
      ),
    );
  }
}
