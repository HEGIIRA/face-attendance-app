import 'package:flutter/material.dart';

Padding buildNameInputField(TextEditingController controllerName) {
  return Padding(
    padding: const EdgeInsets.all(10),
    child: TextField(
      textInputAction: TextInputAction.done,
      keyboardType: TextInputType.text,
      controller: controllerName,
      decoration: InputDecoration(
        contentPadding: const EdgeInsets.symmetric(horizontal: 10),
        labelText: "Your Name",
        labelStyle: const TextStyle(
          fontSize: 14,
          color: Colors.blueAccent
        ),
        hintText: "Please enter your name",
        hintStyle: const TextStyle(
          fontSize: 14,
          color: Colors.grey,
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: const BorderSide(color: Colors.blueAccent),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: const BorderSide(color: Colors.blueAccent),
        )
      ),
    ),
  );
}