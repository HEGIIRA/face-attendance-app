import 'package:camera/camera.dart';
import 'package:flutter/material.dart';

class AddModelCameraController {
  List<CameraDescription>? cameras;
  CameraController? controller;
  // bool isBusy = false;
  int selectedCameraIndex = 0;

  // bool get isInitialized => controller?.value.isInitialized ?? false;

  bool isFrontCamera() {
    return controller?.description.lensDirection == CameraLensDirection.front;
  }

  // Load kamera pas initState
  Future<void> loadCamera() async {
    cameras = await availableCameras();
    if (cameras != null && cameras!.isNotEmpty) {
      controller = CameraController(cameras![0], ResolutionPreset.high);
      await controller!.initialize();
    }
  }

  // Switch kamera depan/belakang
  Future<void> switchCamera() async {
    if (cameras == null || cameras!.length < 2) return;

    selectedCameraIndex = (selectedCameraIndex + 1) % cameras!.length;
    await controller?.dispose();
    controller =
        CameraController(cameras![selectedCameraIndex], ResolutionPreset.high);
    await controller!.initialize();
  }

  // Cekrek foto
  Future<XFile?> takePicture() async {
    if (controller == null ||
        !controller!.value.isInitialized ||
        controller!.value.isTakingPicture) return null;

        return await controller!.takePicture();

    // final XFile file = await controller!.takePicture();
    // print("📸 Foto diambil: ${file.path}");

    // return file;
  }

  // Widget buildCameraPreview() {
  //   if (controller == null || !controller!.value.isInitialized) {
  //     return const Center(child: CircularProgressIndicator());
  //   }
  //   return CameraPreview(controller!);
  // }

  // Tampilkan preview
  Widget buildCameraPreview() {
    if (controller == null || !controller!.value.isInitialized) {
      return const Center(child: CircularProgressIndicator());
    }

    if (isFrontCamera()) {
      return Transform(
        alignment: Alignment.center,
        transform: Matrix4.rotationY(3.1416),
        child: CameraPreview(controller!),
      );
    } else {
      return AspectRatio(
        aspectRatio: controller!.value.aspectRatio,
        child: FittedBox(
          fit: BoxFit.cover,
          child: SizedBox(
            width: controller!.value.previewSize!.height,
            height: controller!.value.previewSize!.width,
            child: CameraPreview(controller!),
          ),
        ),
      );
    }
  }

  //DISPOSE
  void dispose() {
    controller?.dispose();
  }
}
