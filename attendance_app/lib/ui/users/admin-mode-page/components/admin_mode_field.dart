import 'package:attendance_app/ui/const.dart';
import 'package:attendance_app/ui/components-general/custom_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';


class AdminModeField extends StatefulWidget {
  final GlobalKey<FormState> formKey;
  final Function(String email) onChanged;


  const AdminModeField({super.key, required this.onChanged, required this.formKey});


  @override
  State<AdminModeField> createState() => _AdminModeFieldState();
}


class _AdminModeFieldState extends State<AdminModeField> {
  final kodeController = TextEditingController();


   @override
  void initState() {
    super.initState();
    kodeController.addListener(() {
      widget.onChanged(kodeController.text);
    });
  }


  @override
  Widget build(BuildContext context) {
    return Form(
      key: widget.formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
               Text(
                "Masukan Kode Admin",
                style: TextStyle(
                  fontSize: heading3.sp,
                  fontWeight: FontWeight.w600,
                  decoration: TextDecoration.none,
                  color: text400,
                ),
              ),
              SizedBox(height: 6),
               Text(
                "Hanya pengguna terotorisasi yang dapat melanjutkan.",
                style: TextStyle(
                  fontSize: heading4.sp,
                  fontWeight: FontWeight.w600,
                  decoration: TextDecoration.none,
                  color: text500,
                ),
              ),
            ],
          ),
           SizedBox(height: 46.h),
          CustomField(
            label: "Kode",
            controller: kodeController,
            validator: (value) {
              if (value == null || value.isEmpty) return 'Harap Masukan Kode Admin';
              return null;
            },
          ),
           SizedBox(height: 16.h),
        ],
      ),
    );
  }
}





