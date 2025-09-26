import 'package:attendance_app/controllers/camera_binding.dart';
import 'package:attendance_app/ui/admin/camera-add/camera_add_screen.dart';
import 'package:attendance_app/ui/admin/dashboard-admin/component-dashboard-admin/popup_logout_admin.dart';
import 'package:attendance_app/ui/components-general/header.dart';
import 'package:attendance_app/ui/components-general/main_header.dart';
import 'package:attendance_app/ui/const.dart';
import 'package:attendance_app/ui/admin/dashboard-admin/component-dashboard-admin/data_karyawan.dart';
import 'package:attendance_app/ui/admin/dashboard-admin/component-dashboard-admin/rekap_kehadiran.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';


class RekapDetailScreen extends StatelessWidget {
  const RekapDetailScreen({super.key});


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 32.w),
          child: Column(
            children: [
              SizedBox(height: 46.h),
              Header(
                title: "Rekap Kehadiran",
                onPressedIcon: () {Get.back();}
              ),
              SizedBox(height: 32.h),
              // ISI YANG FLEKSIBEL
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    //Rekap Karyawan
                    RekapKehadiran(),
                    SizedBox(height: 30.h),


                    // Data Karyawan
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            Text(
                              'Data Karyawan',
                              style: TextStyle(
                                  fontSize: heading4.sp,
                                  fontWeight: FontWeight.w600),
                            ),
                            SizedBox(width: 10,),
                            Row(
                              children: [
                                Container(
                                  padding: EdgeInsets.symmetric(horizontal: 15, vertical: 5),
                                  decoration: BoxDecoration(
                                    color: primary100,
                                    borderRadius: BorderRadius.circular(50)
                                  ),
                                  child: Text(
                                    "Semua",
                                    style: TextStyle(
                                      color: primary600,
                                      fontWeight: FontWeight.w600
                                    ),
                                  ),
                                ),
                                IconButton(
                                  onPressed: () {}, 
                                  icon: Icon(Icons.arrow_drop_down, color: primary600)
                                )
                              ],
                            )


                          ],
                        ),
                        TextButton(
                          child: Row(
                            children: [
                              Icon(Icons.person_add_alt_outlined,
                                  size: 24.w, color: primary600),
                              Text(
                                'Tambah Karyawan',
                                style: TextStyle(
                                    fontSize: body1.sp,
                                    fontWeight: FontWeight.w700,
                                    color: primary600),
                              ),
                            ],
                          ),
                          onPressed: () {
                            Get.to(CameraAddScreen(), binding: CameraBinding());
                          },
                        ),
                      ],
                    ),
                    SizedBox(height: 16.h),
                    Expanded(
                      child: Padding(
                        padding: EdgeInsets.only(
                            bottom: 100.h), // padding bawah layar
                        child: DataKaryawan(),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}





