import 'package:attendance_app/ui/const.dart';
import 'package:attendance_app/ui/users/category-register-page/components/category_chip.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CategorySelector extends StatefulWidget {
  final Function(String) onCategorySelected;

  const CategorySelector({super.key, required this.onCategorySelected});

  @override
  State<CategorySelector> createState() => _CategorySelectorState();
}

class _CategorySelectorState extends State<CategorySelector> {
  String? selectedCategory;

  final List<String> categories = [
    "Aptika",
    "Persandian",
    "Statistik",
    "PIPK",
    "Perencanaan",
    "Keuangan dan Aset",
    "Infrastruktur TIK",
    "Diseminasi informasi"
  ];

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Bidang",
          style: TextStyle(fontSize: heading3.sp, fontWeight: FontWeight.w600),
        ),
        SizedBox(height: 12.h),
        Wrap(
          spacing: 12,
          runSpacing: 12,
          children: categories.map((category) {
            return CategoryChip(
              label: category,
              isSelected: selectedCategory == category,
              onTap: () {
                setState(() {
                  selectedCategory = category;
                });
                widget.onCategorySelected(category);
              },
            );
          }).toList(),
        ),
      ],
    );
  }
}
