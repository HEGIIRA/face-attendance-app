import 'package:camera/camera.dart';
import 'package:flutter/material.dart';

class CameraControllerComponent {
  List<CameraDescription>? cameras; //kenapa nullable, karna kesiapan klo kamera nya unavailable, YA MASA HRSU SELALU SIAP KAMERA NYA? gmn klo ke out gtu apk nya? atau ngelag?
  CameraController? controller;
  bool isBusy = false;

  Future<void> loadCamera() async{
    cameras = await availableCameras();
    if (cameras != null && cameras!.isNotEmpty) { //klo kamera bekerja (available)
      //ini karna list nya nullable, jadi harus pake bang operator klo mau pake ini (apanya?)
      //klo kamera tidak berada di index 0 (kamera belakang)yg brarti di index 1 (kamera depan)
      controller = CameraController(cameras![0], ResolutionPreset.high); //resolution preset high ini klo misalnya pas foto, kejepret nya kegoyang (nge blur) nnti resolusi nya tetep hd
      await controller!.initialize(); //hrus ada isinya untuk inisialisasi
    }
  }

  Widget buildCameraPreview() {
    if (controller == null || !controller!.value.isInitialized) { //bang didepan(diawal method) itu NOT/NEGASI, klo bang di belakang itu TIDAK NULL/NULL SAFETY (BANG OPERATOR)                                                                                                                                                                                                                                            
      //aksi klo kondisi bernilai negatif
      return const Center(
        child: CircularProgressIndicator());
    }
    //aksi klo kondisi bernilai positif
    return CameraPreview(controller!);
  }
}