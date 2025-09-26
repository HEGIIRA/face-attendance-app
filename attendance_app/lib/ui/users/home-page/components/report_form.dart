import 'package:attendance_app/controllers/attendance_controller.dart';
import 'package:attendance_app/controllers/employee_controller.dart';
import 'package:attendance_app/ui/const.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class ReportForm extends StatelessWidget {
  final AttendanceController attendanceC = Get.find<AttendanceController>();
  final EmployeeController employeeC = Get.find<EmployeeController>();
  final TextEditingController nameController = TextEditingController();
  final FocusNode nameFocus = FocusNode();

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // TextField untuk nama karyawan
            TextField(
              controller: nameController,
              focusNode: nameFocus,
              decoration: InputDecoration(
              hintText: 'Nama Karyawan',
              hintStyle: TextStyle(
                  fontSize: heading5.sp,
                  fontWeight: FontWeight.w600,
                  color: text300),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: BorderSide(color: Colors.grey, width: 1.5.w),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: BorderSide(color: primary600, width: 1.5.w),
              ),
              contentPadding:
                  EdgeInsets.symmetric(horizontal: 16.w, vertical: 15.h)),
              style: TextStyle(
              fontSize: heading5.sp,
              fontWeight: FontWeight.w600,
              color: text400),
              onChanged: (value) {
                employeeC.setSearchQuery(value);
                attendanceC.name.value = value;
              },
            ),
            SizedBox(height: 20.h),

            // Dropdown masalah
            Obx(() => DropdownButtonFormField<String>(
                  value: attendanceC.issue.value.isEmpty ? null : attendanceC.issue.value,
                  style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.w600
                  ),
                  decoration: InputDecoration(
              hintText: 'Pilih kendala yang kamu alami',
              hintStyle: TextStyle(
                  fontSize: heading5.sp,
                  fontWeight: FontWeight.w600,
                  color: text300),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: BorderSide(color: Colors.grey, width: 1.5.w),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: BorderSide(color: primary600, width: 1.5.w),
              ),
              contentPadding:
                  EdgeInsets.symmetric(horizontal: 16.w, vertical: 15.h)),
                  items: attendanceC.issues.map((issue) {
                    return DropdownMenuItem(
                      value: issue,
                      child: Text(issue),
                    );
                  }).toList(),
                  onChanged: (val) {
                    attendanceC.issue.value = val ?? "";
                  },
                )),
          ],
        ),

        ///INI SUGESTION LIST
        Obx(() {
          final list = employeeC.filteredEmployeeList;
          final textEmpty = nameController.text.trim().isEmpty;
          final showDropdown = !textEmpty &&
              (employeeC.searchQuery.value.isNotEmpty || nameFocus.hasFocus);

          if (!showDropdown || list.isEmpty) return SizedBox.shrink();
          if (list.isEmpty || !nameFocus.hasFocus) return SizedBox.shrink();

          // kita posisikan suggestion langsung di bawah TextField
          return Positioned(
            top: 60.h, // jarak dari atas Stack (sesuaikan dg TextField)
            left: 0,
            right: 0,
            child: Material(
              elevation: 4,
              borderRadius: BorderRadius.circular(8),
              child: ConstrainedBox(
                constraints: BoxConstraints(maxHeight: 500.h),
                child: ListView.builder(
                  shrinkWrap: true,
                  itemCount: list.length,
                  itemBuilder: (_, index) {
                    final e = list[index];
                    return ListTile(
                      title: Text(e.name),
                      onTap: () {
                        attendanceC.name.value = e.name;
                        attendanceC.employeeId.value = e.id; // simpen docId employee
                        nameController.text = e.name;
                        employeeC.searchQuery.value = "";
                        nameFocus.unfocus();
                      },
                    );
                  },
                ),
              ),
            ),
          );
        }),
      ],
    );
  }
}
