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
        padding: EdgeInsets.symmetric(vertical: 60.h, horizontal: 32.w),
        child: Column(
          children: [
            Header(
                title: "Tambah Face ID",
                onPressedIcon: () {
                  Get.delete<CameraControllerX>(force: true);
                  Get.back();
                }),
            SizedBox(height: 40.h),
            CameraBox(),
            SizedBox(height: 24.h),
            Obx(() {
              if (cameraC.statusMessage.value.isEmpty) return SizedBox.shrink();

              bool isError = cameraC.statusMessage.value.contains('Gagal');
              Color textColor = isError ? error600 : primary600;

              return Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  // Container buat status message
                  Text(
                      cameraC.statusMessage.value,
                      style: TextStyle(
                          color: textColor,
                          fontSize: heading5.sp,
                          fontWeight: FontWeight.w600),
                    ),
                  // Button cuma muncul kalo error
                  if (isError)
                    Padding(
                      padding: EdgeInsets.only(top: 24.h),
                      child: Row(
                        children: [
                          Expanded(
                            child: ElevatedButton(
                              onPressed: () async {
                                await cameraC.restartCamera();
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor: primary600,
                                foregroundColor: Colors.white,
                                padding: EdgeInsets.symmetric(
                                    horizontal: 50.w,
                                    vertical: 15.h),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10.r),
                                ),
                              ),
                              child: 
                              Text(
                                'Coba Lagi',
                                style: TextStyle(
                                  fontSize: heading3.sp,
                                  fontWeight: FontWeight.w600,
                                  color: Colors.white
                                ),
                              ),
                            ),
                          ),

                          SizedBox(width: 15.w),
                          Expanded(
                            child: ElevatedButton(
                              onPressed: () async {
                                await cameraC.restartCamera();
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor: text100,
                                foregroundColor: Colors.white,
                                padding: EdgeInsets.symmetric(
                                    horizontal: 50.w,
                                    vertical: 15.h),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10.r),
                                ),
                              ),
                              child: Text(
                                'Hubungi Admin',
                                style: TextStyle(
                                  fontSize: heading4.sp,
                                  fontWeight: FontWeight.w600,
                                  color: text300
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                ],
              );
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
