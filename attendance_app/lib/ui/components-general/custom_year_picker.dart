import 'package:attendance_app/ui/const.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:attendance_app/controllers/date_controller.dart';

class CustomYearPicker extends StatelessWidget {
  final dateC = Get.find<DateController>();

  @override
  Widget build(BuildContext context) {
    final minYear = 2000;
    final maxYear = DateTime.now().year;
    final years = List.generate(maxYear - minYear + 1, (i) => minYear + i);

    // pastikan scroll ke selected year tiap kali dialog dibuka
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final initialIndex = years.indexOf(dateC.selectedYear.value);
      dateC.yearScrollController.jumpToItem(initialIndex);
      dateC.tempYear.value = dateC.selectedYear.value;
    });

    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      child: Container(
        height: 500,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.all(Radius.circular(10.r)),
        ),
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 35.w, vertical: 45.h),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "Tahun",
                style: TextStyle(fontSize: heading1.sp),
              ),
              SizedBox(height: 20.h),
              SizedBox(
                height: 250.h,
                child: ListWheelScrollView.useDelegate(
                  controller: dateC.yearScrollController,
                  itemExtent: 50,
                  physics: FixedExtentScrollPhysics(),
                  onSelectedItemChanged: (index) {
                    dateC.setTempYear(years[index]);
                  },
                  childDelegate: ListWheelChildBuilderDelegate(
                    builder: (context, index) {
                      if (index < 0 || index >= years.length) return null;
                      final year = years[index];
                      return Center(
                        child: Obx(() => Text(
                              year.toString(),
                              style: TextStyle(
                                fontSize: 24,
                                fontWeight: dateC.tempYear.value == year
                                    ? FontWeight.bold
                                    : FontWeight.normal,
                                color: dateC.tempYear.value == year
                                    ? primary600
                                    : text600,
                              ),
                            )),
                      );
                    },
                  ),
                ),
              ),
              SizedBox(height: 20),
              Row(
                children: [
                  Expanded(
                    child: TextButton(
                      onPressed: () {
                        dateC.resetTempYear();
                        Get.back();
                      },
                      child: Text("Batal"),
                      style: TextButton.styleFrom(
                        backgroundColor: text100,
                        foregroundColor: text600,
                        padding:
                            EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(14.r),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(width: 16.w),
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () {
                        dateC.saveYear();
                        Get.back();
                      },
                      child: Text("Simpan"),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: primary600,
                        foregroundColor: Colors.white,
                        padding:
                            EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(14.r),
                        ),
                      ),
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
