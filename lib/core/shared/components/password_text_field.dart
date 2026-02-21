import 'package:flutter/material.dart';
import 'package:products_api/core/manager/app_colors.dart';

class PasswordTextField extends StatefulWidget {
  const PasswordTextField({
    super.key,
    required this.controller,
    required this.hint,
    required this.icon,
  });
  final TextEditingController controller;
  final String hint;
  final IconData icon;

  @override
  State<PasswordTextField> createState() => _PasswordTextFieldState();
}

class _PasswordTextFieldState extends State<PasswordTextField> {
  bool showPassword = false;
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      obscureText: !showPassword,
      controller: widget.controller,
      cursorColor: Colors.black,
      validator: (value) {
        if (value == null || value.isEmpty) {
          return "Please fill this field to proceed.";
        }
        if (value.contains(" ")) {
          return "Can't contain spaces.";
        }
        if (value.length < 8) {
          return "Short password.";
        }
        return null;
      },
      decoration: InputDecoration(
        hintText: widget.hint,
        hintStyle: TextStyle(color: Color.fromARGB(255, 73, 73, 73)),
        suffix: GestureDetector(
          onTap: () => setState(() {
            showPassword = !showPassword;
          }),
          child: Icon(
            showPassword ? Icons.visibility_off : Icons.visibility,
            size: 17,
            color: Colors.grey[600],
          ),
        ),
        prefixIcon: Icon(widget.icon, color: Colors.grey[700]),
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
