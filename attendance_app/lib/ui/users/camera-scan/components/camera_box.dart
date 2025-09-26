import 'dart:io';
import 'package:attendance_app/controllers/camera_controller.dart';
import 'package:attendance_app/ui/const.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:camera/camera.dart';
import 'dart:math' as math;

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
                Container(
                  width: 760.w,
                  height: 700.h,
                  color: Colors.black,
                  child: Transform(
                    alignment: Alignment.center,
                    transform: Matrix4.rotationY(math.pi), // mirror hasil foto
                    child: Image.file(
                      File(cameraC.lastCapturedImage.value!.path),
                      fit: BoxFit.cover,
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
    width: 760.w,
    height: 700.h,
    color: Colors.black,
    child: Transform(
      alignment: Alignment.center,
      transform: Matrix4.rotationY(math.pi), // mirror
      child: CameraPreview(
        cameraC.cameraController!,
        child: LayoutBuilder(
          builder: (context, constraints) {
            return FittedBox(
              fit: BoxFit.cover, // isi penuh, sisanya kepotong
              child: SizedBox(
                width: cameraC.cameraController!.value.previewSize!.height, 
                height: cameraC.cameraController!.value.previewSize!.width,
                child: CameraPreview(cameraC.cameraController!),
              ),
            );
          },
        ),
      ),
    ),
  ),
);

    });
  }
}
