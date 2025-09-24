import 'package:flutter/material.dart';
import 'package:tracking_app/core/theme/app_colors.dart';

class AppTextFormField extends StatefulWidget {
  final EdgeInsetsGeometry? contentPadding;
  final InputBorder? focusedBorder;
  final InputBorder? enabledBorder;
  final TextStyle? inputTextStyle;
  final TextStyle? hintStyle;
  final TextStyle? labelStyle;
  final String hintText;
  final Widget? suffixIcon;
  final Color? backgroundColor;
  final String? labelText;
  final bool isPassword;
  final TextEditingController? controller;
  final String? Function(String?)? validator;
  final bool initialObscureText;

  const AppTextFormField({
    super.key,
    this.contentPadding,
    this.focusedBorder,
    this.enabledBorder,
    this.inputTextStyle,
    this.hintStyle,
    this.labelStyle,
    this.labelText,
    required this.isPassword,
    required this.hintText,
    this.initialObscureText = true,
    this.suffixIcon,
    this.backgroundColor,
    this.controller,
    this.validator,
  });

  @override
  State<AppTextFormField> createState() => _AppTextFormFieldState();
}

class _AppTextFormFieldState extends State<AppTextFormField> {
  late bool isObscureText;

  @override
  void initState() {
    super.initState();
    isObscureText = widget.initialObscureText;
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      obscuringCharacter: "★",
      controller: widget.controller,
      decoration: InputDecoration(
        labelText: widget.labelText,
        labelStyle:
            widget.labelStyle ?? const TextStyle(color: AppColors.black),
        hintText: widget.hintText,
        hintStyle: widget.hintStyle ?? const TextStyle(color: AppColors.grey),
        isDense: true,
        contentPadding:
            widget.contentPadding ??
            const EdgeInsets.symmetric(horizontal: 20, vertical: 18),
        focusedBorder:
            widget.focusedBorder ??
            OutlineInputBorder(
              borderSide: const BorderSide(width: 1),
              borderRadius: BorderRadius.circular(4.0),
            ),
        enabledBorder:
            widget.enabledBorder ??
            OutlineInputBorder(
              borderSide: const BorderSide(color: AppColors.grey, width: 1),
              borderRadius: BorderRadius.circular(4.0),
            ),
        errorBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: Colors.red, width: 1),
          borderRadius: BorderRadius.circular(4.0),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: Colors.red, width: 1),
          borderRadius: BorderRadius.circular(4.0),
        ),
        suffixIcon: widget.isPassword
            ? IconButton(
                onPressed: () {
                  setState(() {
                    isObscureText = !isObscureText;
                  });
                },
                icon: Icon(
                  isObscureText ? Icons.visibility_off : Icons.visibility,
                  color: AppColors.grey,
                ),
              )
            : widget.suffixIcon,
        fillColor: widget.backgroundColor,
        filled: true,
      ),
      obscureText: widget.isPassword ? isObscureText : false,
      style: const TextStyle(fontSize: 14),
      validator: widget.validator,
    );
  }
}
