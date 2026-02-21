import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:products_api/core/manager/app_colors.dart';

class OnlyEngTextField extends StatelessWidget {
  const OnlyEngTextField({
    super.key,
    required this.controller,
    required this.hint,
    required this.icon,
  });
  final TextEditingController controller;
  final String hint;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      keyboardType: TextInputType.text,
      inputFormatters: [FilteringTextInputFormatter.allow(RegExp(r'[a-zA-Z]'))],
      controller: controller,
      cursorColor: Colors.black,
      decoration: InputDecoration(
        hintText: hint,
        hintStyle: TextStyle(color: Color.fromARGB(255, 73, 73, 73)),
        prefixIcon: Icon(icon, color: Colors.grey[700]),
        filled: true,
        fillColor: Color(0xffF2F2F2),
        contentPadding: EdgeInsets.symmetric(vertical: 18.0, horizontal: 16.0),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(5),
          borderSide: BorderSide(color: Colors.transparent),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.0),
          borderSide: BorderSide(color: Colors.transparent),
        ),
      ),
      style: TextStyle(color: AppColors.text),
    );
  }
}
