import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  final TextEditingController controller;
  final String label;
  final bool isPassword;
  final bool isEmail;
  final bool isPhone;

  const CustomTextField({
    super.key,
    required this.controller,
    required this.label,
    this.isPassword = false,
    this.isEmail = false,
    this.isPhone = false,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      obscureText: isPassword,
      keyboardType: isEmail
          ? TextInputType.emailAddress
          : (isPhone ? TextInputType.phone : TextInputType.text),
      decoration: InputDecoration(labelText: label),
      validator: (value) {
        if (value == null || value.isEmpty) return "$label is required";
        if (isEmail && !RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(value)) {
          return "Invalid email";
        }
        if (isPhone && !RegExp(r'^01[0-2,5]{1}[0-9]{8}$').hasMatch(value)) {
          return "Invalid phone number";
        }
        return null;
      },
    );
  }
}
