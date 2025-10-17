import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
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
  final TextInputType? keyboardType;

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
    this.keyboardType,
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
      keyboardType: widget.keyboardType ?? TextInputType.text,
      decoration: InputDecoration(
        labelText: widget.labelText,
        hintText: widget.hintText,
        hintStyle: widget.hintStyle ??
            TextStyle(
              color: AppColors.grey.withOpacity(0.9),
              fontSize: 13.sp,
            ),
        isDense: true,
        labelStyle: TextStyle(
          color: AppColors.grey.withOpacity(0.9),
          fontSize: 14.sp,
          fontWeight: FontWeight.w500,
        ),
        contentPadding: widget.contentPadding ??
            const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
        filled: true,
        fillColor: widget.backgroundColor ?? Colors.grey.shade50,

        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.r),
          borderSide: BorderSide(
            color: Colors.grey.shade300,
            width: 1.2,
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.r),
          borderSide: const BorderSide(
            color: AppColors.pink,
            width: 1.8,
          ),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.r),
          borderSide: const BorderSide(
            color: Colors.redAccent,
            width: 1.4,
          ),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.r),
          borderSide: const BorderSide(
            color: Colors.redAccent,
            width: 1.4,
          ),
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
      ),
      obscureText: widget.isPassword ? isObscureText : false,
      style: const TextStyle(fontSize: 14),
      validator: widget.validator,
    );
  }
}
