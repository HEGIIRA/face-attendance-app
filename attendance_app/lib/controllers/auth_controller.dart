import 'package:attendance_app/models/user_model.dart';
import 'package:attendance_app/ui/users/home-page/home_screen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';


class AuthController extends GetxController {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  var uid = ''.obs;
  //UNTUK NAMPUNG SEMENTARA SEBELUM KLIK BUTTON DAFTAR
  var email = ''.obs;
  var password = ''.obs;
  var field = ''.obs;


  Rx<UserModel?> currentUser = Rx<UserModel?>(null);
  RxBool isLoggedIn = false.obs;

@override
  void onInit() {
    super.onInit();
    // auto sinkron UID tiap kali state auth berubah
    _auth.authStateChanges().listen((user) async {
      if (user != null) {
        uid.value = user.uid;
        isLoggedIn.value = true;

        // load data user dari Firestore biar currentUser gak null
        final userDoc = await _firestore.collection('users').doc(user.uid).get();
        if (userDoc.exists) {
          currentUser.value = UserModel.fromMap(userDoc.data()!);
        }
      } else {
        uid.value = '';
        currentUser.value = null;
        isLoggedIn.value = false;
      }
    });
  }



//ini buat nyimpen perubhana pas udah ngetik
  void onChangedEmail(String value) {
  email.value = value;
}


void onChangedPassword(String value) {
  password.value = value;
}


  //UNTUK REGISTER
  Future<void> register() async {
    //daftarin ke firebase auth
  try {
    UserCredential userCredential = await FirebaseAuth.instance
        .createUserWithEmailAndPassword(
      email: email.value.trim(),
      password: password.value.trim(),
    );


    //kalo udah berhasil, masukin ke firestore
    await FirebaseFirestore.instance
        .collection('users')
        .doc(userCredential.user!.uid)
        .set({
      'email': email.value.trim(), //trim untuk hapus spasi di depan dan belakang value
      'bidang': field.value,
    });


    // NAVIGASI KE HOME ATAU SCREEN SELANJUTNYA
    Get.snackbar("Sukses", "Akun berhasil dibuat");
    uid.value = userCredential.user!.uid;
    Get.offAll(() => HomeScreen());


  } catch (e) {
    Get.snackbar("Gagal", e.toString());
  }
}




  //UNTUK LOGIN
  Future<void> login() async {
    try {
      UserCredential userCredential = await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email.value.trim(),
        password: password.value.trim(),
      );


      final uidFromFirebase = userCredential.user!.uid;
      uid.value = uidFromFirebase;


      // final uid = userCredential.user!.uid;


      final userDoc = await _firestore.collection('users').doc(uidFromFirebase).get();


      if (!userDoc.exists) throw 'Data user tidak ditemukan di Firestore';


      currentUser.value = UserModel.fromMap(userDoc.data()!);
      isLoggedIn.value = true;
    } catch (e) {
      Get.snackbar('Error', e.toString());
    }
  }


  //UNTUK LOGOUT
  Future<void> logout() async {
    await FirebaseAuth.instance.signOut();
    currentUser.value = null;
    isLoggedIn.value = false;
  }
}





