import 'package:attendance_app/controllers/camera_controller.dart';
import 'package:attendance_app/ui/admin/camera-add/cam.dart';
import 'package:attendance_app/ui/components-general/header.dart';
import 'package:attendance_app/ui/const.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class CameraScreen extends StatelessWidget {
  final cameraC = Get.find<CameraControllerX>();
  CameraScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Padding(
        padding: EdgeInsets.symmetric(vertical: 80.h, horizontal: 32.w),
        child: Column(
          children: [
            Header(
                title: "Tambah Face ID Karyawan",
                onPressedIcon: () {
                  Get.delete<CameraControllerX>(force: true);
                  Get.back();
                }),
            SizedBox(height: 40.h),
            CameraBox(),
            SizedBox(height: 15.h),
            Obx(() {
              if (cameraC.isPreviewMode.value) {
                return Container(
                  decoration: BoxDecoration(
                    color: warningLight100,
                    borderRadius: BorderRadius.circular(10.r)
                  ),
                  padding: EdgeInsets.all(10),
                  child: Text(
                    cameraC.statusMessage.value,
                    style: TextStyle(
                        color: warningLight600,
                        fontSize: heading5.sp,
                        fontWeight: FontWeight.w600),
                  ),
                );
              } else {
                return SizedBox.shrink(); 
              }
            }),

            Obx(() {
              if (cameraC.statusMessage.value.contains('Gagal')) {
               return Column(
                 children: [
                   Container(
                      padding: EdgeInsets.all(10),
                      color: error100,
                      child: Text(
                        cameraC.statusMessage.value,
                        style: TextStyle(
                            color: error600,
                            fontSize: heading5.sp,
                            fontWeight: FontWeight.w600),
                      ),
                    ),
                    Row(
                      children: [ 
                        ElevatedButton(
                          onPressed: () async {
                            await cameraC.restartCamera();
                          },
                          child: const Text(
                            'Coba Lagi',
                          ),
                        ),
                      ]
                    )
                 ],
               );
               
          
              } else {
                return SizedBox.shrink(); 
              }
            }),

            Obx(() {
              if (!cameraC.isPreviewMode.value) {
                return IconButton(
                  icon: Icon(Icons.radio_button_checked_outlined,
                      size: 120.w, color: primary600),
                  onPressed: () => cameraC.takePicture(),
                );
              } else {
                return SizedBox.shrink();
              }
            }),
          ],
        ),
      )),
    );
  }
}
