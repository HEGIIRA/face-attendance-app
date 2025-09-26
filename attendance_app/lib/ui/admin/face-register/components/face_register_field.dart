import 'package:attendance_app/controllers/employee_controller.dart';
import 'package:attendance_app/ui/components-general/custom_dropdown.dart';
import 'package:attendance_app/ui/components-general/custom_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class FaceRegisterField extends StatelessWidget {
  final TextEditingController nameController;
  final TextEditingController positionController;
  final GlobalKey<FormState> formKey;

  FaceRegisterField({super.key, required this.formKey, required this.nameController, required this.positionController});

  final employeeC = Get.find<EmployeeController>();

  @override
  Widget build(BuildContext context) {
    return Form(
      key: formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Nama Lengkap
          CustomField(
            label: "Nama Lengkap",
            controller: nameController,
            validator: (value) {
              if (value == null || value.isEmpty) return 'Wajib diisi';
              return null;
            },
          ),
          SizedBox(height: 16.h),

          // Bidang (Dropdown)
          Obx(() => CustomDropdown(
                label: "Bidang",
                value: employeeC.division.value.isEmpty
                    ? null
                    : employeeC.division.value,
                items: [
                  "APTIKA",
                  "PIKP",
                  "Persandian & Statistik",
                  "IT",
                  "Sekretariat"
                ],
                onChanged: (val) {
                  employeeC.division.value = val ?? "";
                },
                validator: (val) {
                  if (val == null || val.isEmpty) {
                    return "Bidang wajib dipilih";
                  }
                  return null;
                },
              )),
          SizedBox(height: 16.h),

          // Posisi
          CustomField(
            label: "Posisi",
            controller: positionController,
            validator: (value) {
              if (value == null || value.isEmpty) return 'Wajib diisi';
              return null;
            },
          ),
        ],
      ),
    );
  }
}
