import 'package:attendance_app/ui/const.dart';
import 'package:attendance_app/ui/admin/dashboard-admin/component-dashboard-admin/rekap_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class RekapKehadiran extends StatelessWidget {
  const RekapKehadiran({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Title + Lihat Semua
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Rekap Kehadiran Hari Ini',
              style:
                  TextStyle(fontSize: heading4.sp, fontWeight: FontWeight.w600),
            ),
            Text(
              'Lihat Semua',
              style: TextStyle(
                  fontSize: body1.sp,
                  fontWeight: FontWeight.w700,
                  color: primary600),
            ),
          ],
        ),
        SizedBox(height: 28.h),

        GridView.count(
          //gridview untuk nampilin kotak2 ke bawah, mirip listview yg vertikal satu2 ke bawah
          shrinkWrap:
              true, //biar dia tuh ga ambil semua ruang, jadi cuma sesuai contennya aja
          physics: NeverScrollableScrollPhysics(), //biar gabisa di scroll
          crossAxisCount: 2,
          mainAxisSpacing: 16,
          crossAxisSpacing: 16,
          childAspectRatio: 2.3,
          children: [
            RekapCard(
              icon: Icons.verified_user_outlined,
              label: 'Total Kehadiran hari ini',
              value: '4',
              suffix: '/7',
            ),
            RekapCard(
              icon: Icons.person_off_outlined,
              label: 'Jumlah Absen Tidak Hadir',
              value: '3',
              suffix: 'orang',
            ),
            RekapCard(
              icon: Icons.groups_2_outlined,
              label: 'Jumlah Karyawan',
              value: '7',
              suffix: 'orang',
            ),
            RekapCard(
              icon: Icons.face_retouching_off,
              label: 'Face ID Error',
              value: '1',
              suffix: 'kasus',
            ),
          ],
        ),
      ],
    );
  }
}
