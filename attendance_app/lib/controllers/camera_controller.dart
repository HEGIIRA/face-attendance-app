import 'dart:async';
import 'dart:io';
import 'package:attendance_app/controllers/attendance_controller.dart';
import 'package:attendance_app/ui/const.dart';
import 'package:attendance_app/ui/users/home-page/home_screen.dart';
import 'package:camera/camera.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
// import 'dart:io';

class CameraControllerX extends GetxController {
  CameraController? _controller;
  var isCameraInitialized = false.obs;
  var statusMessage = ''.obs;
  var lastAttendance = {}.obs;
  RxBool isPreviewMode = false.obs;
  Rx<XFile?> lastCapturedImage = Rx<XFile?>(null);
  // final baseUrl = 'https://01305d85b8e6.ngrok-free.app';
  final baseUrl = 'https://97b1308c14ab.ngrok-free.app';
  final attendanceC = Get.find<AttendanceController>();

  RxString tempFaceId = ''.obs;

  RxInt countdown = 10.obs;
  Timer? _timer;

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
        ResolutionPreset.high,
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
    print(lastCapturedImage.value != null
        ? "✅✅😱 Foto siap di path: ${lastCapturedImage.value!.path}"
        : "Foto null anjir");

    isPreviewMode.value = true;
    statusMessage.value = 'Mendeteksi Wajah...';

    // kasih jeda dikit biar foto muncul
    await Future.delayed(const Duration(milliseconds: 300));

    // kirim ke Python -> dapet hasil deteksi
    final res = await encodeFace(image.path);

    if (res != null && res['face_detected'] == true) {
      if (res['duplicate'] == true) {
        // 🚨 wajah sudah ada
        statusMessage.value =
            "Wajah sudah terdaftar atas nama ${res['name'] ?? 'orang lain'}!";
        return;
      } else {
        // ✅ wajah baru
        tempFaceId.value = res['temp_id'];
        statusMessage.value = 'Muka ketangkep! Lanjut isi form.';
        await Future.delayed(const Duration(milliseconds: 800));
        Get.toNamed('/form-register', arguments: {'tempId': tempFaceId.value});
      }

      print('Respon Python: $res');
    } else {
      statusMessage.value = 'Gagal : Muka tidak terdeteksi, coba lagi.';
    }
  }

  Future<Map<String, dynamic>?> encodeFace(String filePath) async {
    try {
      print("✅ File path: $filePath");
      print("✅ File size: ${await File(filePath).length()} bytes");

      final url = Uri.parse('$baseUrl/encode_face');
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

  Future<Map<String, dynamic>?> encodeFaceForAttendance(String filePath) async {
    try {
      final url = Uri.parse('$baseUrl/recognize_face');
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

// di CameraControllerX
  Future<Map<String, dynamic>?> recognizeFaceForAttendance(
      String imagePath) async {
    try {
      final url = Uri.parse('$baseUrl/recognize_face');
      var request = http.MultipartRequest('POST', url // sesuaikan IP/port
          );
      request.files.add(await http.MultipartFile.fromPath('file', imagePath));

      var response = await request.send();
      var respStr = await response.stream.bytesToString();

      print("🐍 Respon Python: $respStr");

      if (response.statusCode == 200) {
        return jsonDecode(respStr);
      } else {
        return null;
      }
    } catch (e) {
      print("❌ Error recognizeFaceForAttendance: $e");
      return null;
    }
  }

  Future<void> takePictureAttendance(String mode) async {
    if (!(cameraController?.value.isInitialized ?? false)) return;

    try {
      // ambil foto
      final image = await cameraController!.takePicture();
      print("📸 Foto diambil: ${image.path}");

      if (!File(image.path).existsSync()) {
        statusMessage.value = 'Gagal ambil foto, coba lagi.';
        print("❌ File foto tidak ditemukan!");
        return;
      }

      await cameraController?.pausePreview();
      lastCapturedImage.value = image;
      isPreviewMode.value = true;
      statusMessage.value = "Mendeteksi wajah...";

      // kasih jeda biar foto kebaca
      await Future.delayed(const Duration(milliseconds: 300));

      // kirim ke Python buat identifikasi wajah
      final res = await recognizeFaceForAttendance(image.path);

      print("🐍 Respon Python: $res");

      // validasi response
      if (res == null) {
        statusMessage.value = "Gagal: tidak ada respon dari Python.";
        print("❌ Respon Python null");
        return;
      }

      // kalau wajah kedeteksi tapi nggak cocok sama database
      if (res["match"] != true || res["duplicate"] != true) {
        statusMessage.value = "Wajah tidak terdaftar!";
        print("❌ Wajah tidak terdaftar!");
        return;
      }

      // --- kalau sampai sini berarti wajah valid ---
      final employeeName = res["name"];
      final employeePosition = res["position"];
      final employeeDivision = res["division"];
      final employeeId = res["employeeId"];

      statusMessage.value = "Wajah cocok: $employeeName";
      print("✅ Wajah cocok: $employeeName ($employeeId)");

      // save attendance
      final resultMsg = await attendanceC.saveAttendance(
        employeeId: employeeId,
        name: employeeName,
        position: employeePosition,
        division: employeeDivision,
        mode: mode,
      );
      print("📝 Save result: $resultMsg");
      statusMessage.value = resultMsg;

      // ambil data absensi terbaru
      final doc = await FirebaseFirestore.instance
          .collection("attendance")
          .where("employeeId", isEqualTo: employeeId)
          .orderBy("date", descending: true)
          .limit(1)
          .get();

      if (doc.docs.isNotEmpty) {
        final att = doc.docs.first.data();

        final alreadyCheckedIn = att['checkIn'] != null && att['checkIn'] != "";
        final alreadyCheckedOut =
            att['checkOut'] != null && att['checkOut'] != "";

        // munculin popup detail absensi
        Get.dialog(
            AlertDialog(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.r),
              ),
              content: SizedBox(
                width: 630.w,
                height: 450.h,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(height: 20.h),
                    Text(
                        alreadyCheckedOut
                            ? "⚠️ Hari ini sudah absen keluar!"
                            : alreadyCheckedIn
                                ? "⚠️ Hari ini sudah absen masuk!"
                                : (mode == "checkOut"
                                    ? "Absensi Keluar Berhasil!"
                                    : "Absensi Masuk Berhasil!"),
                        style: TextStyle(fontSize: heading1.sp)),
                    SizedBox(height: 40.h),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text("Nama", style: TextStyle(fontSize: heading4.sp)),
                        Text(att['name'],
                            style: TextStyle(fontSize: heading4.sp)),
                      ],
                    ),
                    SizedBox(height: 5.sp),
                    const Divider(),
                    SizedBox(height: 5.sp),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text("Jam Hadir",
                            style: TextStyle(fontSize: heading4.sp)),
                        Text(att['checkIn'] ?? '-',
                            style: TextStyle(fontSize: heading4.sp)),
                      ],
                    ),
                    SizedBox(height: 5.sp),
                    const Divider(),
                    SizedBox(height: 5.sp),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text("Jam Keluar",
                            style: TextStyle(fontSize: heading4.sp)),
                        Text(att['checkOut'] ?? '-',
                            style: TextStyle(fontSize: heading4.sp)),
                      ],
                    ),
                    SizedBox(height: 5.sp),
                    const Divider(),
                    SizedBox(height: 5.sp),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text("Status", style: TextStyle(fontSize: heading4.sp)),
                        Text(att['status'],
                            style: TextStyle(
                                fontSize: heading4.sp, color: success500)),
                      ],
                    ),
                    SizedBox(height: 5.sp),
                    const Divider(),
                    SizedBox(height: 5.sp),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text("Keterangan",
                            style: TextStyle(fontSize: heading4.sp)),
                        Text(att['description'],
                            style: TextStyle(fontSize: heading4.sp)),
                      ],
                    ),
                    SizedBox(height: 5.sp),
                    const Divider(),
                    SizedBox(height: 40.h),
                    Obx(() => RichText(
                          text: TextSpan(
                            style: TextStyle(
                              fontSize: heading5.sp,
                              fontWeight: FontWeight.w500,
                              color: Colors.black,
                            ),
                            children: [
                              const TextSpan(text: "Kembali ke beranda dalam "),
                              TextSpan(
                                text: "00:0${countdown.value}",
                                style: const TextStyle(
                                  color: Colors.red,
                                ),
                              ),
                            ],
                          ),
                        )),
                  ],
                ),
              ),
            ),
            barrierDismissible: false);

        startCountdown();
      } else {
        statusMessage.value = resultMsg;
      }
    } catch (e) {
      statusMessage.value = "Error scan: $e";
      print("💥 Error di takePictureAttendance: $e");
    }
  }

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

  void startCountdown() {
    countdown.value = 10;
    _timer?.cancel();

    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (countdown.value > 1) {
        countdown.value--;
      } else {
        timer.cancel();
        Get.back();
        Get.offAll(HomeScreen());
      }
    });
  }

  @override
  void onClose() {
    _timer?.cancel();
    cameraController?.dispose();
    _controller = null;
    isCameraInitialized.value = false;
    super.onClose();
  }
}
