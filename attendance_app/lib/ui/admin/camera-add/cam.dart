import 'dart:io';
import 'package:attendance_app/controllers/camera_controller.dart';
import 'package:attendance_app/ui/const.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:camera/camera.dart';

class CameraBox extends StatelessWidget {
  const CameraBox({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final cameraC = Get.find<CameraControllerX>();

    return Obx(() {
      if (cameraC.isPreviewMode.value) {
        return ClipRRect(
          borderRadius: BorderRadius.circular(10.r),
          child: Stack(
            children: [
              if (cameraC.lastCapturedImage.value != null)
                Image.file(
                  File(cameraC.lastCapturedImage.value!.path),
                  fit: BoxFit.cover,
                  width: 767.w,
                  height: 710.h,
                ),
              if (cameraC.statusMessage.value.contains('Gagal'))
                Positioned(
                  bottom: 20,
                  left: 0,
                  right: 0,
                  child: Center(
                    child: ElevatedButton(
                      onPressed: () async {
                        await cameraC.restartCamera();
                      },
                      child: const Text(
                        'Coba Lagi',
                      ),
                    ),
                  ),
                ),
            ],
          ),
        );
      }

      if (!cameraC.isCameraInitialized.value ||
          cameraC.cameraController == null) {
        return const Center(child: CircularProgressIndicator());
      }

      return ClipRRect(
        borderRadius: BorderRadius.circular(10.r),
        child: Container(
          width: 767.w,
          height: 710.h,
          color: Colors.black,
          child: Stack(
            children: [
              CameraPreview(cameraC.cameraController!),
              Positioned(
                bottom: 20,
                left: 0,
                right: 0,
                child: Center(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      IconButton(
                        icon: const Icon(Icons.camera_alt,
                            size: 32, color: Colors.white),
                        onPressed: () => cameraC.takePicture(),
                      ),
                      // IconButton(
                      //   onPressed: () {
                      //     Get.delete<CameraControllerX>(force: true);
                      //     Get.back();
                      //   },
                      //   icon: const Icon(Icons.backspace_rounded,
                      //       color: Colors.white),
                      // ),
                    ],
                  ),
                ),
              ),

              // TEKS YG AWAL
              Positioned(
                  bottom: 20,
                  left: 0,
                  right: 0,
                  child: Center(
                    child: Container(
                      padding: EdgeInsets.symmetric(
                          horizontal: 10.w, vertical: 10.h),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10.r),
                        color: warningLight100,
                      ),
                      child: Obx(() => Text(
                          cameraC.statusMessage.value,
                          style: TextStyle(
                              color: warningLight600,
                              fontSize: heading5.sp,
                              fontWeight: FontWeight.w600),
                        ),
                      ),
                    ),
                  )
                ),
            ],
          ),
        ),
      );
    });
  }
}
