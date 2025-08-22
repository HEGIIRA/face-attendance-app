import 'package:flutter/material.dart';

Padding buildLocationSection(bool isLoading, String address) {
  return Padding(
    padding: const EdgeInsets.fromLTRB(10, 10, 10, 20),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          "Your Location",
          style: TextStyle(
            fontSize: 16, 
            fontWeight: FontWeight.bold,
            color: Colors.black
          ),
        ),
        isLoading
        ? const Center(
          child: CircularProgressIndicator(
            color: Colors.blueAccent
          ),
        )
        : Padding(
          padding: const EdgeInsets.all(10),
          child: SizedBox(
            //ngatur tinggi dari textfield (120 px)
            height: 5 * 24,
            child: TextField(
              enabled: false,
              maxLines: 5,
              decoration: InputDecoration(
                alignLabelWithHint: true,
                disabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: const BorderSide(color: Colors.blueAccent),
                ),
                hintText: address.isNotEmpty ? address : "Your location",
                hintStyle: const TextStyle(
                  fontSize: 14, 
                  color: Colors.grey
                ),
                fillColor: Colors.transparent,
                filled: true,
              ),
            )
          ),
        )
      ],
    )
  );
}