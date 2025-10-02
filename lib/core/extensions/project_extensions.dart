import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:tracking_app/core/l10n/app_localizations.dart';

extension BuildContextExtension on BuildContext {
  double get width => MediaQuery.sizeOf(this).width;

  double get height => MediaQuery.sizeOf(this).height;

  /// width usage -> context.width
  /// height usage -> context.height

  AppLocalizations get l10n => AppLocalizations.of(this)!;

  ThemeData get theme => Theme.of(this);

  TextTheme get textTheme => theme.textTheme;

  ColorScheme get colorScheme => theme.colorScheme;

  void closeKeyboard() => FocusScope.of(this).unfocus();

  bool get hasParentRoute =>
      ModalRoute.of(this)?.impliesAppBarDismissal ?? false;

  /// Usage -> context.<extension name>
}

extension WidgetSizedBoxFromNumExtension on num {
  Widget get heightBox => SizedBox(height: toDouble());

  Widget get widthBox => SizedBox(width: toDouble());

  /// height use -> 16.heightBox
  /// width usage -> 16.widthBox
}

extension HexToString on String {
  String hexToString() {
    // Remove trailing zeros
    String cleanHex = replaceAll(RegExp(r'0+$'), '');

    // Convert hex string to list of bytes
    List<int> bytes = [];
    for (int i = 0; i < cleanHex.length; i += 2) {
      bytes.add(int.parse(cleanHex.substring(i, i + 2), radix: 16));
    }

    // Convert bytes to UTF-8 string
    return utf8.decode(bytes);
  }
}
