import 'package:attendance_app/controllers/camera_controller.dart';
import 'package:get/get.dart';

class CameraBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<CameraControllerX>(() => CameraControllerX(), fenix: true);
  }
}
