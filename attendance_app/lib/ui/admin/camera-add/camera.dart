import 'dart:io';
import 'package:attendance_app/controllers/camera_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:camera/camera.dart';

class Camera extends StatelessWidget {
  Camera({super.key});


  @override
  Widget build(BuildContext context) {
    final cameraC = Get.put(CameraControllerX());
    return Scaffold(
      body: Obx(() {
        //mode preview
        if (cameraC.isPreviewMode.value) {
          return Stack(
            children: [
              if (cameraC.lastCapturedImage.value != null)
                Image.file(
                  File(cameraC.lastCapturedImage.value!.path),
                  fit: BoxFit.cover,
                  width: double.infinity,
                ),
              Positioned(
                bottom: 30,
                left: 0,
                right: 0,
                child: Center(
                  child: Container(
                    padding: const EdgeInsets.all(8),
                    color: Colors.black54,
                    child: Text(
                      cameraC.statusMessage.value,
                      style: const TextStyle(color: Colors.white, fontSize: 18),
                    ),
                  ),
                ),
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
                      child: const Text('Coba Lagi'),
                    ),
                  ),
                ),
            ],
          );
        }
        if (!cameraC.isCameraInitialized.value ||
            cameraC.cameraController == null) {
          return const Center(child: CircularProgressIndicator());
        }
        return Stack(
          children: [
            CameraPreview(cameraC.cameraController!),
            Positioned(
              bottom: 32,
              left: 0,
              right: 0,
              child: Center(
                child: Row(
                  children: [
                    IconButton(
                      icon: const Icon(Icons.camera_alt, size: 40),
                      onPressed: () => cameraC.takePicture(),
                    ),
                    IconButton(
                        onPressed: () {
                          Get.delete<CameraControllerX>(force: true);
                          Get.back();
                        },
                        icon: Icon(Icons.backspace_rounded))
                  ],
                ),
              ),
            ),
            Positioned(
              top: 50,
              left: 0,
              right: 0,
              child: Center(
                child: Obx(() => Text(
                      cameraC.statusMessage.value,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        backgroundColor: Colors.black54,
                      ),
                    )),
              ),
            ),
          ],
        );
      }),
    );
  }
}





