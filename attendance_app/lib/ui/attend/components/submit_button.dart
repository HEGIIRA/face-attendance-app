// import 'package:attendance_app/services/attendance_service.dart';
// import 'package:camera/camera.dart';
// import 'package:flutter/material.dart';

// Container buildSubmitButton(BuildContext context, Size size, XFile? image, TextEditingController controllerName, String address, String status, String timeStamp) {
//   return Container(
//     alignment: Alignment.center,
//     margin: const EdgeInsets.all(10),
//     child: Material(
//       elevation: 3,borderRadius: BorderRadius.circular(20),
//       child: Container(
//         width: size.width,
//         height: 50,
//         decoration: BoxDecoration(
//           borderRadius: BorderRadius.circular(20),
//           color: Colors.white,
//         ),
//         child: Material(
//           borderRadius: BorderRadius.circular(20),
//           color: Colors.blueAccent,
//           child: InkWell(  //bisa ngasih aksi klo di tap, bisa ngasih efek ripple
//             splashColor: Colors.blue,
//             borderRadius: BorderRadius.circular(20),
//             onTap: () {
//               if (image == null || controllerName.text.isEmpty) { 
//                 showSnackBar(context, "Please fill all the forms!");
//               } else {
//                 submitAttendanceReport(context, address, controllerName.text.toString(), status, timeStamp); 
//               }
//             },
//             child: const Text(
//               "Submit now",
//               style: TextStyle(
//                 color: Colors.white,
//                 fontWeight: FontWeight.bold
//               ),
//             ),
//           ),
//         ),
//       ),
//     ),
//   );
// }

// void showSnackBar(BuildContext context, String message,) {
//   ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
//     content: Row(
//       children: [
//         Icon(Icons.info_outline,
//         color: Colors.white
//       ),
//       SizedBox(width: 10),
//       Text(
//         "mesage",
//         style: TextStyle(
//           color: Colors.white,
//           fontSize: 16
//         ),
//       )
//       ],
//     ),
//     backgroundColor: Colors.blueGrey,
//     shape: StadiumBorder(),
//     behavior: SnackBarBehavior.floating,
//   ));

// }