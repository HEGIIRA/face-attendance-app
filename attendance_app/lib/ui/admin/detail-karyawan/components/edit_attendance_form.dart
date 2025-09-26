// import 'package:attendance_app/controllers/employee_controller.dart';
// import 'package:attendance_app/models/attendance_model.dart';
// import 'package:attendance_app/models/employee_model.dart';
// import 'package:attendance_app/ui/const.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:get/get.dart';

// class EditAttendanceForm extends StatefulWidget {
//   final AttendanceModel attendance;

//   const EditAttendanceForm({super.key, required this.attendance});

//   @override
//   State<EditAttendanceForm> createState() => _EditAttendanceFormState();
// }

// class _EditAttendanceFormState extends State<EditAttendanceForm> {
//   late TextEditingController descriptionController;

//   @override
//   void initState() {
//     super.initState();
//     descriptionController = TextEditingController(text: widget.attendance.description);
//   }

//   @override
//   void dispose() {
//     descriptionController.dispose();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       mainAxisSize: MainAxisSize.min,
//       children: [
//         ///ISINYA SEMACAM DROPDOWn
//         SizedBox(height: 16.h),
//         _buildTextField(controller: descriptionController, label: "Keterangan"),
//         SizedBox(height: 48.h),
//         Row(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             SizedBox(
//               width: 230.w,
//               height: 60.h,
//               child: ElevatedButton(
//                   onPressed: () {
//                     Get.back();
//                   },
//                   child: Text("Batal",
//                       style: TextStyle(fontSize: heading4.sp, color: text300)),
//                   style: ElevatedButton.styleFrom(
//                     backgroundColor: text100,
//                     foregroundColor: Colors.white,
//                     shape: RoundedRectangleBorder(
//                       borderRadius: BorderRadius.circular(10),
//                     ),
//                     padding: EdgeInsets.symmetric(
//                       horizontal: 40.w,
//                       vertical: 16.h,
//                     ),
//                   )),
//             ),
//             SizedBox(width: 16.w),
//             SizedBox(
//               width: 230.w,
//               height: 60.h,
//               child: ElevatedButton(
//                   onPressed: () async {
//                     final updatedEmployee = AttendanceModel(
//                       description: descriptionController.text,
//                       ownerUid: widget.employee.ownerUid,
//                     );
//                     await Get.find<EmployeeController>().updateEmployee(updatedEmployee);
//                      Navigator.of(context).pop();
//                   },
//                   child: Text("Simpan",
//                       style: TextStyle(
//                           fontSize: heading4.sp, color: Colors.white)),
//                   style: ElevatedButton.styleFrom(
//                     backgroundColor: primary600,
//                     foregroundColor: Colors.white,
//                     shape: RoundedRectangleBorder(
//                       borderRadius: BorderRadius.circular(10),
//                     ),
//                     padding: EdgeInsets.symmetric(
//                       horizontal: 40.w,
//                       vertical: 16.h,
//                     ),
//                   )),
//             ),
//           ],
//         ),
//       ],
//     );
//   }

//   Widget _buildTextField({
//     required TextEditingController controller,
//     required String label,
//   }) {
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         Text(
//           label,
//           style: TextStyle(
//             fontSize: body1.sp,
//             fontWeight: FontWeight.w500,
//             color: text400,
//           ),
//         ),
//         SizedBox(height: 6.h),
//         TextField(
//           controller: controller,
//           decoration: InputDecoration(
//             hintText: label, // jadiin label juga sebagai hint
//             hintStyle: TextStyle(
//               fontSize: heading5.sp,
//               fontWeight: FontWeight.w500,
//               color: text300,
//             ),
//             enabledBorder: OutlineInputBorder(
//               borderRadius: BorderRadius.circular(10),
//               borderSide: BorderSide(color: Colors.grey, width: 1.5.w),
//             ),
//             focusedBorder: OutlineInputBorder(
//               borderRadius: BorderRadius.circular(10),
//               borderSide: BorderSide(color: primary600, width: 1.5.w),
//             ),
//             contentPadding:
//                 EdgeInsets.symmetric(horizontal: 16.w, vertical: 15.h),
//           ),
//           style: TextStyle(
//             fontSize: heading5.sp,
//             fontWeight: FontWeight.w500,
//             color: text400,
//           ),
//         ),
//       ],
//     );
//   }
// }
