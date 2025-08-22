import 'package:attendance_app/ui/const.dart';
import 'package:flutter/material.dart';

class HistoryHeader extends StatelessWidget implements PreferredSizeWidget {
  const HistoryHeader({super.key});

  @override
  Size get preferredSize => const Size.fromHeight(70);

  // final AuthController authController = Get.find<AuthController>();

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 70,
      child: Stack(
        alignment: Alignment.center,
        children: [
          Align(
            alignment: Alignment.centerLeft,
            child: IconButton(
              icon: const Icon(Icons.arrow_back, color: primary600, size: 34),
              onPressed: () {Navigator.pop(context);}
              )
          ),
          const Center(
            child: Text(
              "Riwayat",
              style: TextStyle(
                fontSize: heading3,
                fontWeight: FontWeight.w600,
                color: text400,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
