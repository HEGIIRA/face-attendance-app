import 'package:attendance_app/controllers/employee_controller.dart';
import 'package:attendance_app/ui/components-general/custom_dropdown.dart';
import 'package:attendance_app/ui/components-general/custom_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class FaceRegisterField extends StatelessWidget {
  final GlobalKey<FormState> formKey;

  FaceRegisterField({super.key, required this.formKey});

  final controller = Get.find<EmployeeController>();

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
            controller: TextEditingController(),
            validator: (value) {
              if (value == null || value.isEmpty) return 'Wajib diisi';
              return null;
            },
          ),
          SizedBox(height: 16.h),

          // Bidang (Dropdown)
          Obx(() => CustomDropdown(
                label: "Bidang",
                value: controller.field.value.isEmpty
                    ? null
                    : controller.field.value,
                items: [
                  "APTIKA",
                  "PIKP",
                  "Persandian & Statistik",
                  "IT",
                  "Sekretariat"
                ],
                onChanged: (val) {
                  controller.field.value = val ?? "";
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
            controller: TextEditingController(),
            isPassword: false,
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
