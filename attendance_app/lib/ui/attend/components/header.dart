import 'package:flutter/material.dart';

Container buildHeader() {
  return Container(
    height: 50,
    decoration: const BoxDecoration(
      borderRadius: BorderRadius.only(
        topLeft: Radius.circular(10),
        topRight: Radius.circular(10),
      ),
      color: Colors.blueAccent
    ),
    child: const Row(
      children: [
        SizedBox(width: 12),
        Icon(
          Icons.face_retouching_natural_outlined,
          color: Colors.white
        ),
        SizedBox(width: 12),
        Text(
          "Please take a picture",
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Colors.white
          ),
        )
      ],
    ),
  ); 
}