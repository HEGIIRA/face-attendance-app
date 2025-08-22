import 'package:attendance_app/ui/const.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class DataKaryawan extends StatelessWidget {
  const DataKaryawan({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: primary100,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        children: [
          // SEARCH BAR
          Container(
            padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 10.h),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10),
              border: Border.all(color: Colors.grey.shade300),
            ),
            child: TextField(
              style:
                  TextStyle(fontSize: heading5.sp, fontWeight: FontWeight.w600),
              decoration: InputDecoration(
                hintText: 'Cari Nama Karyawan',
                hintStyle: TextStyle(fontSize: heading5.sp),
                border: InputBorder.none,
                icon: Icon(
                  Icons.search,
                  size: 24.w,
                ),
              ),
            ),
          ),
          SizedBox(height: 12.h),

          // LIST SCROLLABLE
          Expanded(
            child: ListView.builder(
              itemCount: 5,
              itemBuilder: (context, index) {
                final names = [
                  'Aurelian Zahra',
                  'Bima Aditya',
                  'Celine Kartika'
                ];
                final subtitle = 'ASN | TIM PA';

                return Container(
                  margin: EdgeInsets.only(bottom: 12.h),
                  padding:
                      EdgeInsets.symmetric(horizontal: 31.w, vertical: 24.h),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Row(
                    children: [
                      Text(
                        '${index + 1}'.padLeft(2, '0'),
                        style: TextStyle(
                            fontWeight: FontWeight.w600, fontSize: heading4.sp),
                      ),
                      SizedBox(width: 30.w),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              names[index % names.length],
                              style: TextStyle(
                                fontSize: heading4.sp,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            Text(
                              subtitle,
                              style: TextStyle(
                                  fontSize: body2.sp,
                                  color: primary600,
                                  fontWeight: FontWeight.w600),
                            ),
                          ],
                        ),
                      ),
                      ElevatedButton(
                        onPressed: () {},
                        style: ElevatedButton.styleFrom(
                          backgroundColor: primary600,
                          padding: EdgeInsets.symmetric(
                              horizontal: 57.w, vertical: 10.h),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        child: Text(
                          'Detail',
                          style: TextStyle(
                              fontSize: heading5.sp,
                              color: Colors.white,
                              fontWeight: FontWeight.w600),
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
