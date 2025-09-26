import 'package:attendance_app/controllers/admin_controller.dart';
import 'package:attendance_app/controllers/attendance_controller.dart';
import 'package:attendance_app/controllers/auth_controller.dart';
import 'package:attendance_app/controllers/camera_binding.dart';
import 'package:attendance_app/controllers/date_controller.dart';
import 'package:attendance_app/controllers/employee_controller.dart';
import 'package:attendance_app/ui/users/register-page/register_screen.dart';
import 'package:attendance_app/ui/state-management/date_provider.dart';
import 'package:attendance_app/ui/users/home-page/home_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:intl/date_symbol_data_local.dart';//biar format bulan dll itu bisa diatur, kyk pake b indo biar juli, - July
import 'package:provider/provider.dart'; 

Future<void> main() async {
  //yg di compile ini dlu.
  WidgetsFlutterBinding.ensureInitialized();
  await initializeDateFormatting('id_ID', null);
  await Firebase.initializeApp(
      //klo mw pke firebase,initializeapp dulu buat pke layanann firbase yg lain, langkah pertama setelah atur pubspec
      options: const FirebaseOptions(
          //data diambil dari file google-services.json
          apiKey:
              'AIzaSyCsItJtZWhEsREskCkJrddFS6ftdLIm00I', //ambil dri current_key || ini sifatnya rahasia, nnti ini bisa ter enskripsi(bintang2 atau pagar2 kyk pw).
          appId:
              '1:474983179997:android:4407bdb2a0420c61e99d34', //ambil dri mobilesdk-app_id
          messagingSenderId: '474983179997', //ambil dri project_number
          projectId: 'attendance-app-686b2' //ambil dri project_id
          ));

  //DAFTARIN CONTROLLER PAKE GETX
  Get.put(AuthController());
  Get.put(DateController());
  Get.put(AdminController());
  Get.put(AttendanceController());
  Get.put(EmployeeController());
  
  // Get.put(NotificationController());


  initializeDateFormatting('id_ID', null).then((_) {
    runApp(MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => DateProvider()),
      ],
      child: const AttendanceApp(),
    ));
  });
  // runApp(const AttendanceApp());
}

class AttendanceApp extends StatelessWidget {
  const AttendanceApp({super.key});

  @override
  Widget build(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser;
    
    return ScreenUtilInit(
      designSize: const Size(834, 1194), //ukuran aslinya seperti di desain
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) {
       return GetMaterialApp(
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
              fontFamily: 'PlusJakartaSans',
              textTheme: Theme.of(context).textTheme.apply(
                decoration: TextDecoration.none
              ),
              scaffoldBackgroundColor: Colors.white,
              cardTheme: const CardTheme(surfaceTintColor: Colors.white),
              dialogTheme: const DialogTheme(
                  surfaceTintColor: Colors.white, backgroundColor: Colors.white),
              colorScheme: ColorScheme.fromSeed(seedColor: Colors.blueAccent),
              useMaterial3: true),
          home: user != null ? HomeScreen() : RegisterScreen(),
          initialBinding: CameraBinding(),
        // home: const HomeScreen1();
        );
      }
    );
        
  }
}
