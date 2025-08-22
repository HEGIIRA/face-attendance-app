import 'package:attendance_app/ui/const.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomDropdown extends StatelessWidget {
  final String label;
  final String? value;
  final List<String> items;
  final void Function(String?) onChanged;
  final String? Function(String?)? validator;

  const CustomDropdown({
    super.key,
    required this.label,
    required this.value,
    required this.items,
    required this.onChanged,
    this.validator,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: TextStyle(fontSize: heading5.sp, fontWeight: FontWeight.w600),
        ),
        SizedBox(height: 16.h),
        DropdownButtonFormField<String>(
          value: value,
          validator: validator,
          style: TextStyle(
              fontSize: heading5.sp,
              fontWeight: FontWeight.w600,
              color: text400),
          decoration: InputDecoration(
            hintText: 'Pilih $label',
            hintStyle: TextStyle(
                fontSize: heading5.sp,
                fontWeight: FontWeight.w600,
                color: text300),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide(color: Colors.grey, width: 1.5.w),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide(color: primary600, width: 1.5.w),
            ),
            contentPadding:
                EdgeInsets.symmetric(horizontal: 16.w, vertical: 28.h),
          ),
          items: items
              .map((e) => DropdownMenuItem(
                    value: e,
                    child: Text(
                      e,
                      style: TextStyle(
                          fontSize: heading5.sp,
                          fontWeight: FontWeight.w600,
                          color: text400),
                    ),
                  ))
              .toList(),
          onChanged: onChanged,
        ),
      ],
    );
  }
}
