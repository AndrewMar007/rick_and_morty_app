import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  final double height;
  final double width;
  final String hintText;

  final TextEditingController controller;
  final Function(String)? onSubmitted;
  const CustomTextField(
      {required this.height,
      required this.width,
      required this.controller,
      required this.hintText,
      required this.onSubmitted,
      super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(30.0),
          border: Border.all(color: Colors.white)),
      height: height,
      width: width,
      child: Center(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: width * 0.04),
          child: TextField(
            style: const TextStyle(color: Colors.white, fontSize: 14),
            cursorColor: const Color.fromARGB(255, 66, 239, 252),
            decoration: InputDecoration(
                border: InputBorder.none,
                hintText: hintText,
                hintStyle: const TextStyle(color: Colors.white, fontSize: 12)),
            onSubmitted: onSubmitted,
          ),
        ),
      ),
    );
  }
}
