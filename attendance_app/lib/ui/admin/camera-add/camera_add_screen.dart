import 'package:attendance_app/controllers/camera_controller.dart';
import 'package:attendance_app/ui/admin/camera-add/components/camera_box.dart';
import 'package:attendance_app/ui/admin/face-register/face_register_screen.dart';
import 'package:attendance_app/ui/components-general/header.dart';
import 'package:attendance_app/ui/const.dart';
import 'package:attendance_app/ui/users/home-page/components/popup_report.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class CameraAddScreen extends StatelessWidget {
  final cameraC = Get.find<CameraControllerX>();
  CameraAddScreen({super.key});

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
              if (cameraC.statusMessage.value == 'Muka ketangkep! Lanjut isi form.') {
                // Munculin popup
                Future.microtask(() {
                  Get.dialog(
                    Theme(
                      data: Theme.of(context),
                      child: Center(
                        child: Container(
                          padding: EdgeInsets.all(20),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(20),
                          ),
                          width: 628.w,
                          height: 566.h,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Image.asset('assets/images/success.png', width: 402.w,),
                              SizedBox(height: 46.h),
                              Text(
                                "Selesai! Kamu sudah siap untuk melengkapi data berikutnya",
                                 textAlign: TextAlign.center,
                                style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                                  fontSize: heading3.sp,
                                  color: text400,
                                      decoration: TextDecoration.none, 
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    barrierDismissible: false,
                  );

                  // auto close + navigate
                  Future.delayed(Duration(seconds: 3), () {
                    Get.back();
                    Get.to(() => FaceRegisterScreen(), arguments: {'tempId': cameraC.tempFaceId.value});
                  });
                });
              }
              return SizedBox.shrink(); // fallback widget kosong
            }),


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
                                    horizontal: 50.w, vertical: 15.h),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10.r),
                                ),
                              ),
                              child: Text(
                                'Coba Lagi',
                                style: TextStyle(
                                    fontSize: heading3.sp,
                                    fontWeight: FontWeight.w600,
                                    color: Colors.white),
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
