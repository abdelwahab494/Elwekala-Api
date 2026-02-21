import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:products_api/core/manager/app_colors.dart';

class OnlyNumTextField extends StatelessWidget {
  const OnlyNumTextField({
    super.key,
    required this.controller,
    required this.hint,
    required this.icon,
    this.minValue,
    this.maxValue,
  });

  final TextEditingController controller;
  final String hint;
  final IconData icon;
  final int? minValue;
  final int? maxValue;

  @override
  Widget build(BuildContext context) {

    return TextFormField(
      keyboardType: TextInputType.number,
      inputFormatters: [FilteringTextInputFormatter.digitsOnly],
      controller: controller,
      cursorColor: Colors.black,
      validator: (value) {
        if (value == null || value.isEmpty) {
          return "Please fill this field.";
        }
        if (value.contains(" ")) {
          return "Spaces are not allowed.";
        }
        int? number = int.tryParse(value);
        if (number == null) {
          return "Please enter a valid number.";
        }
        if (minValue != null && number < minValue!) {
          return "Value must be greater than or equal to $minValue.";
        }
        if (maxValue != null && number > maxValue!) {
          return "Value must be less than or equal to $maxValue.";
        }
        return null;
      },
      decoration: InputDecoration(
        hintText: hint,
        hintStyle: TextStyle(
          color: Color.fromARGB(255, 73, 73, 73) ,
        ),
        prefixIcon: Icon(icon, color: Colors.grey[700]),
        filled: true,
        fillColor:
            Color(0xffF2F2F2),
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