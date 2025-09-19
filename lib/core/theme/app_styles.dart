import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tracking_app/core/theme/app_colors.dart';

abstract class AppStyles {
  static TextStyle font15BlackW500 = TextStyle(
    fontSize: 15,
    fontWeight: FontWeight.w500,
    color: AppColors.grey,
  );
  static TextStyle font20BlackW500 = TextStyle(
    fontSize: 20,
    fontWeight: FontWeight.w500,
    color: AppColors.black,
  );
  static TextStyle font14BlackW500 = TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.w500,
    color: AppColors.black,
  );
  static TextStyle font13WhiteW500 = TextStyle(
    fontSize: 13,
    fontWeight: FontWeight.w500,
    color: AppColors.white,
  );
  static TextStyle font12grayW500LineThrough = TextStyle(
    fontSize: 12,
    fontWeight: FontWeight.w500,
    color: AppColors.grey,
    decoration: TextDecoration.lineThrough,
  );
  static TextStyle font12greenW500 = TextStyle(
    fontSize: 12,
    fontWeight: FontWeight.w500,
    color: AppColors.green,
  );
  static TextStyle font12blackW400 = TextStyle(
    fontSize: 12,
    fontWeight: FontWeight.w400,
    color: AppColors.black,
  );

  static TextStyle appBarTitleStyle = GoogleFonts.inter(
    fontSize: 20,
    fontWeight: FontWeight.w500,
    color: AppColors.black,
  );
  static TextStyle medium18black = GoogleFonts.inter(
    fontSize: 18,
    fontWeight: FontWeight.w500,
    color: AppColors.black,
  );
  static TextStyle medium16white = GoogleFonts.inter(
    fontSize: 16,
    fontWeight: FontWeight.w500,
    color: AppColors.white,
  );
  static TextStyle regular14grey = GoogleFonts.inter(
    fontSize: 14,
    fontWeight: FontWeight.w400,
    color: AppColors.grey,
  );
  static TextStyle regular14black = GoogleFonts.inter(
    fontSize: 14,
    fontWeight: FontWeight.w400,
    color: AppColors.black,
  );
  static TextStyle regular16black = GoogleFonts.inter(
    fontSize: 16,
    fontWeight: FontWeight.w400,
    color: AppColors.black,
  );

  static TextStyle bold20black = GoogleFonts.inter(
    fontSize: 20,
    fontWeight: FontWeight.w700,
    color: AppColors.black,
  );
  static TextStyle medium16black = GoogleFonts.inter(
    fontSize: 16,
    fontWeight: FontWeight.w500,
    color: AppColors.black,
  );
  static TextStyle regular13grey = GoogleFonts.inter(
    fontSize: 13,
    fontWeight: FontWeight.w400,
    color: AppColors.grey,
  );
}
