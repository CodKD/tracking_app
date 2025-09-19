import 'package:flutter/material.dart';

extension ResponsiveSizedBoxExtension on num {
  double heightPercent(BuildContext context) {
    final screenHeight = MediaQuery.of(
      context,
    ).size.height;
    return screenHeight * (toDouble() / 100);
  }

  double widthPercent(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    return screenWidth * (toDouble() / 100);
  }
}
