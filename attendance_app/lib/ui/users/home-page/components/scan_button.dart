import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ScanButton extends StatefulWidget {
  const ScanButton({super.key});

  @override
  State<ScanButton> createState() => _ScanButtonState();
}

class _ScanButtonState extends State<ScanButton> {
  bool _isFirst = true;

  void _toggleImage() {
    setState(() {
      _isFirst = !_isFirst;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: GestureDetector(
        onTap: _toggleImage,
        child: AnimatedSwitcher(
          duration: const Duration(milliseconds: 300),
          child: Image.asset(
            _isFirst ? 'assets/images/scan_button.png' : 'assets/images/onclick_scan_button.png',
            width: 400.w,
            height: 400.h,
          ),
          transitionBuilder: (child, animation) {
            return FadeTransition(
              opacity: animation,
              child: child,
            );
          },
        ),
      ),
    );
  }
}
