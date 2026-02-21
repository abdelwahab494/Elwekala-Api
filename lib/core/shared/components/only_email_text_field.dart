import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:products_api/core/manager/app_colors.dart';

class OnlyEmailTextField extends StatelessWidget {
  const OnlyEmailTextField({
    super.key,
    required this.controller,
    required this.hint,
    required this.icon,
    this.readOnly = false,
    this.showCopyButton = false,
  });

  final TextEditingController controller;
  final String hint;
  final IconData icon;
  final bool readOnly;
  final bool showCopyButton;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      readOnly: readOnly,
      keyboardType: TextInputType.emailAddress,
      inputFormatters: [
        FilteringTextInputFormatter.allow(RegExp(r'[a-z0-9@._-]')),
      ],
      cursorColor: Colors.black,
      controller: controller,
      validator: (value) {
        if (!showCopyButton) {
          if (value == null || value.isEmpty) {
            return "Please fill this field to proceed.";
          }
          if (!value.endsWith("@gmail.com")) {
            return "Invalid Email format.";
          }
          if (value.contains(" ")) {
            return "Can't contain spaces.";
          }
        }
        return null;
      },
      decoration: InputDecoration(
        hintText: hint,
        hintStyle: TextStyle(color: Color.fromARGB(255, 73, 73, 73)),
        prefixIcon: Icon(icon, color: Colors.grey[700]),
        suffixIcon: showCopyButton
            ? IconButton(
                icon: Icon(Icons.copy, color: Colors.grey[700]),
                onPressed: () {
                  Clipboard.setData(ClipboardData(text: controller.text));
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('Email copied to clipboard!')),
                  );
                },
              )
            : SizedBox.shrink(),
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
