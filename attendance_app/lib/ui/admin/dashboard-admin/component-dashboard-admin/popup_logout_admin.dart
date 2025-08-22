import 'package:attendance_app/ui/const.dart';
import 'package:attendance_app/ui/users/home-page/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';


void popupLogoutAdmin(BuildContext context) {
  showGeneralDialog(
    context: context,
    barrierDismissible:
        false, //Kalau `true`, berarti bisa nutup popup dengan **klik di luar popup** (area gelap).
    barrierLabel: "Close",
    transitionDuration: Duration(milliseconds: 300),
    pageBuilder: (context, animation, secondaryAnimation) {
      return Align(
        alignment: Alignment.center,
        child: Material(
            color: const Color.fromARGB(0, 91, 209, 224),
            child: Container(
              width: 500,
              padding: EdgeInsets.symmetric(horizontal: 50, vertical: 50),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    "Yakin keluar dari mode admin?",
                    style: TextStyle(
                      color: text400,
                      fontSize: heading4,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 50),
                  Row(
                    children: [
                      Expanded(
                        child: ElevatedButton(
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                            child: Text("Batal",
                                style: TextStyle(
                                    fontSize: heading5, color: text300)),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: text100,
                              foregroundColor: Colors.white,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                              padding: EdgeInsets.symmetric(
                                horizontal: 40,
                                vertical: 10,
                              ),
                            )),
                      ),
                      SizedBox(width: 16),
                      Expanded(
                        child: ElevatedButton(
                            onPressed: () {
                              Get.to(HomeScreen());
                            },
                            child: Text("Keluar",
                                style: TextStyle(
                                    fontSize: heading5, color: Colors.white)),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: error300,
                              foregroundColor: Colors.white,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                              padding: EdgeInsets.symmetric(
                                horizontal: 40,
                                vertical: 10,
                              ),
                            )),
                      ),
                    ],
                  ),
                ],
              ),
            )),
      );
    },
    transitionBuilder: (context, animation, secondaryAnimation, child) {
      return SlideTransition(
        position: Tween<Offset>(
          begin: Offset(0, -1),
          end: Offset(0, 0),
        ).animate(CurvedAnimation(
          parent: animation,
          curve: Curves.easeOutBack,
        )),
        child: child,
      );
    },
  );
}





