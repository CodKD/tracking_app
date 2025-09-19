import 'package:flutter/material.dart';
import 'package:tracking_app/core/theme/app_colors.dart';

class AppTextFormFeild extends StatelessWidget {
  final EdgeInsetsGeometry? contentPadding;
  final InputBorder? focusedBorder;
  final InputBorder? enabledBorder;
  final TextStyle? inputTextStyle;
  final TextStyle? hintStyle;
  final String hintText;
  final bool? isObscureText;
  final Widget? suffixIcon;
  final Color? backgroundColor;
  final TextEditingController? controller;
  final String? Function(String?)? validator;

  const AppTextFormFeild({
    super.key,
    this.contentPadding,
    this.focusedBorder,
    this.enabledBorder,
    this.inputTextStyle,
    this.hintStyle,
    required this.hintText,
    this.isObscureText,
    this.suffixIcon,
    this.backgroundColor,
    this.controller,
    this.validator,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      obscuringCharacter: "*",
      controller: controller,
      decoration: InputDecoration(
        isDense: true,
        contentPadding:
            contentPadding ??
            EdgeInsets.symmetric(
              horizontal: 20,
              vertical: 18,
            ),
        focusedBorder:
            focusedBorder ??
            OutlineInputBorder(
              borderSide: const BorderSide(
                // color: AppColors.mainBlue,
                width: 1.3,
              ),
              borderRadius: BorderRadius.circular(10.0),
            ),
        enabledBorder:
            enabledBorder ??
            OutlineInputBorder(
              borderSide: const BorderSide(
                color: AppColors.grey,
                width: 1.3,
              ),
              borderRadius: BorderRadius.circular(10.0),
            ),
        errorBorder: OutlineInputBorder(
          borderSide: const BorderSide(
            color: Colors.red,
            width: 1.3,
          ),
          borderRadius: BorderRadius.circular(10.0),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderSide: const BorderSide(
            color: Colors.red,
            width: 1.3,
          ),
          borderRadius: BorderRadius.circular(10.0),
        ),
        hintStyle:
            hintStyle ??
            const TextStyle(color: AppColors.grey),
        hintText: hintText,
        suffixIcon: suffixIcon,
        fillColor: backgroundColor,
        filled: true,
      ),
      obscureText: isObscureText ?? false,
      style: TextStyle(fontSize: 14),
      validator: validator,
    );
  }
}
