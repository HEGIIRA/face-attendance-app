import 'dart:async';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class DateController extends GetxController {
  var selectedDate = DateTime.now().obs;
  var isFiltered = false.obs;

  var selectedMonth = DateTime.now().obs;
  var focusedDay = DateTime.now().obs;
  var selectedYear = DateTime.now().year.obs;
  var tempYear = DateTime.now().year.obs; // tahun sementara

  var jam = 'blm ada jir'.obs;
  var tanggal = ''.obs;
  Timer? _timer;

  late FixedExtentScrollController yearScrollController;

  @override
  void onInit() {
    super.onInit();
    print("🔥 DateController onInit hash: $hashCode");
    _updateTime();
    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      _updateTime();
    });
    yearScrollController = FixedExtentScrollController(
      initialItem: selectedYear.value - DateTime.now().year,
    );
  }

  void setTempYear(int year) => tempYear.value = year;

  void saveYear() {
    selectedYear.value = tempYear.value;
    // update selectedDate juga supaya Obx DateYear nge-refresh
    final now = DateTime.now();
    selectedDate.value = DateTime(selectedYear.value, now.month);
  }

  void resetTempYear() => tempYear.value = selectedYear.value;

  //  void setYear(int year) {
  //   final current = selectedDate.value;
  //   selectedYear.value = year;
  //   selectedDate.value = DateTime(year, current.month, current.day);
  // }

  void setMonth(int month) {
    final current = selectedDate.value;
    selectedDate.value = DateTime(current.year, month, current.day);
  }

  void setDate(DateTime date) {
    selectedDate.value = date;
    focusedDay.value = date;
  }

  void setFocusedDay(DateTime date) {
    focusedDay.value = date;
  }

  bool isCurrentMonthAndYear() {
    final now = DateTime.now();
    return selectedDate.value.year == now.year &&
        selectedDate.value.month == now.month;
  }

  void previousDate() {
    selectedDate.value = selectedDate.value.subtract(const Duration(days: 1));
  }

  void nextDate() {
    selectedDate.value = selectedDate.value.add(const Duration(days: 1));
  }

  void nextMonth() {
    final current = selectedDate.value;
    selectedDate.value = DateTime(
      current.year,
      current.month + 1,
      current.day,
    );
  }

  void previousMonth() {
    final current = selectedDate.value;
    selectedDate.value = DateTime(
      current.year,
      current.month - 1,
      current.day,
    );
  }

  void _updateTime() {
    final now = DateTime.now();
    jam.value = DateFormat.Hm().format(now);
    tanggal.value = DateFormat('EEEE, d MMM yyyy', 'id_ID').format(now);
  }
  

  @override
  void onClose() {
    _timer?.cancel();
    super.onClose();
  }
}
