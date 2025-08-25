import 'dart:io';
import 'package:camera/camera.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
// import 'dart:io';

class CameraControllerX extends GetxController {
  CameraController? _controller;
  var isCameraInitialized = false.obs;
  var statusMessage = ''.obs;
  RxBool isPreviewMode = false.obs;
  Rx<XFile?> lastCapturedImage = Rx<XFile?>(null);
  final baseUrl = 'https://01305d85b8e6.ngrok-free.app';
  RxString tempFaceId = ''.obs;

  CameraController? get cameraController => _controller;

  @override
  void onInit() {
    super.onInit();
    initCamera();
  }

  Future<void> initCamera() async {
    try {
      // kalau controller ada tapi udah disposed → reset
      if (_controller != null && _controller!.value.isInitialized) {
        return;
      }

      final cameras = await availableCameras();
      final frontCamera = cameras.firstWhere(
        (camera) => camera.lensDirection == CameraLensDirection.front,
      );

      _controller = CameraController(
        frontCamera,
        ResolutionPreset.medium,
        enableAudio: false,
      );

      await _controller!.initialize();
      isCameraInitialized.value = true;
      statusMessage.value =
          'Arahkan wajah ke kamera untuk mulai pendaftaran'; // reset pesan
    } catch (e) {
      statusMessage.value = 'Error init kamera: $e';
    }
  }

  Future<void> takePicture() async {
    if (!(cameraController?.value.isInitialized ?? false)) return;

    // Ambil foto
    final image = await cameraController!.takePicture();
    if (!File(image.path).existsSync()) {
      statusMessage.value = 'Gagal ambil foto, coba lagi.';
      return;
    }

    await cameraController?.pausePreview();

    // Masuk ke mode preview
    lastCapturedImage.value = image;
    isPreviewMode.value = true;
    statusMessage.value = 'Mendeteksi Wajah...';

    // kasih jeda dikit biar foto muncul
    await Future.delayed(const Duration(milliseconds: 300));

    // kirim ke Python -> dapet temp_id
    final res = await encodeFace(image.path);
    if (res != null && (res['face_detected'] == true)) {
      tempFaceId.value = res['temp_id'];
      statusMessage.value = 'Muka ketangkep! Lanjut isi form.';
      await Future.delayed(const Duration(milliseconds: 800));
      // bawa tempId ke form
      Get.toNamed('/form-register', arguments: {'tempId': tempFaceId.value});
      print('Respon Python: $res');

    } else {
      statusMessage.value = 'Gagal : Muka tidak terdeteksi, coba lagi.';
    }

    // Kirim ke Python buat face recognition
    // final result = await sendToPython(image.path);

    //   if (result['face_detected'] == true) {
    //   tempFaceId.value = result['temp_id']; // simpen ID sementara
    //   statusMessage.value = 'Muka ketangkep! Lanjut isi form.';
    //   await Future.delayed(const Duration(seconds: 1));
    //   Get.toNamed('/form-register');
    // } else {
    //   statusMessage.value = 'Gagal: Muka tidak terdeteksi, coba lagi.';
    // }
  }


  Future<Map<String, dynamic>?> encodeFace(String filePath) async {
  try {
    final url = Uri.parse('$baseUrl/encode_temp');
    var request = http.MultipartRequest('POST', url);
    request.files.add(await http.MultipartFile.fromPath('file', filePath));

    var streamed = await request.send();
    var body = await streamed.stream.bytesToString();
    if (streamed.statusCode == 200) {
      return jsonDecode(body) as Map<String, dynamic>;
    } else {
      statusMessage.value = 'Error Python: ${streamed.statusCode}';
      return null;
    }
  } catch (e) {
    statusMessage.value = 'Error kirim foto: $e';
    return null;
  }
}

Future<bool> registerFace({
  required String tempId,
  required String name,
  required String division,
  required String ownerUid,
}) async {
  try {
    final url = Uri.parse('$baseUrl/register');
    final res = await http.post(
      url,
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({
        'temp_id': tempId,
        'name': name,
        'division': division,
        'ownerUid': ownerUid,
      }),
    );

    if (res.statusCode == 200) {
      final data = jsonDecode(res.body);
      return data['success'] == true;
    } else {
      return false;
    }
  } catch (e) {
    statusMessage.value = 'Error register: $e';
    return false;
  }
}


  // Future<bool> sendToPython(String filePath) async {
  //   try {
  //     final url = Uri.parse('https://a45591d44a96.ngrok-free.app/upload');
  //     var request = http.MultipartRequest('POST', url);
  //     request.files.add(await http.MultipartFile.fromPath('file', filePath));

  //     var streamedResponse = await request.send();
  //     var responseBody = await streamedResponse.stream.bytesToString();

  //     if (streamedResponse.statusCode == 200) {
  //       final json = jsonDecode(responseBody);
  //       return json['face_detected'] == true;
  //     }
  //     return false;
  //   } catch (e) {
  //     statusMessage.value = 'Error kirim foto: $e';
  //     return false;
  //   }
  // }

  Future<void> restartCamera() async {
    try {
      await _controller?.dispose();
      _controller = null;
      isCameraInitialized.value = false;

      await initCamera(); // panggil init ulang
      isPreviewMode.value = false;
      statusMessage.value = 'Siap ambil foto';
    } catch (e) {
      print("Error restart kamera: $e");
    }
  }

  @override
  void onClose() {
    cameraController?.dispose();
    _controller = null;
    isCameraInitialized.value = false;
    super.onClose();
  }
}
