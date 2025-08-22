// import 'dart:io';

// import 'package:attendance_app/ui/attend/camera_screen.dart';
// import 'package:camera/camera.dart';
// import 'package:dotted_border/dotted_border.dart';
// import 'package:flutter/material.dart';

// Padding buildCapturePhotoSection(BuildContext context, Size size, XFile? image) {
//   return Padding(
//     padding: const EdgeInsets.fromLTRB(10, 20, 0, 20),
//     child: Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         const Text(
//           "Capture Photo",
//           style: TextStyle(
//             fontSize: 16, 
//             fontWeight: FontWeight.bold,
//             color: Colors.black
//           ),
//         ),
//         GestureDetector(
//           onTap: () {
//             Navigator.push(
//               context, 
//               MaterialPageRoute(builder: (context) => const CameraScreen())
//             );
//           },
//           child: Container(
//             margin: const EdgeInsets.fromLTRB(10, 0, 10, 20),
//             width: size.width,
//             height: 150,
//             child: DottedBorder(
//               radius: const Radius.circular(10),
//               borderType: BorderType.RRect,
//               color: Colors.blueAccent,
//               strokeWidth: 1,
//               dashPattern: [5, 3],
//               child: SizedBox.expand( //expand punyanya si sibo
//                 child: FittedBox(
//                   child: image != null
//                   ? Image.file(File(image.path), fit: BoxFit.cover)
//                   : const Icon(
//                     Icons.camera_enhance_outlined,
//                     color: Colors.blueAccent,
//                   )
//                 )
//               ),
//             )
//           )
//         )
//       ],
//     ),
//   );
// }