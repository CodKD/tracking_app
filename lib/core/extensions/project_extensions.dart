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
      ModalRoute.of(this)?.impliesAppBarDismissal ??
      false;

  /// Usage -> context.<extension name>
}

extension WidgetSizedBoxFromNumExtension on num {
  Widget get heightBox => SizedBox(height: toDouble());

  Widget get widthBox => SizedBox(width: toDouble());

  /// height use -> 16.heightBox
  /// width usage -> 16.widthBox
}

extension StringHexConverter on String {
  /// Converts a string to a 24-character hexadecimal string
  /// Pads with zeros if needed, truncates if too long
  String toHex() {
    String hex = codeUnits
        .map((e) => e.toRadixString(16).padLeft(2, '0'))
        .join();

    // Ensure exactly 24 characters
    if (hex.length < 24) {
      // Pad with zeros on the right
      return hex.padRight(24, '0');
    } else if (hex.length > 24) {
      // Truncate to 24 characters
      return hex.substring(0, 24);
    }
    return hex;
  }

  /// Converts a hexadecimal string back to the original string
  /// Removes trailing zeros that were added for padding
  String hexToString() {
    try {
      if (isEmpty) {
        return '';
      }

      // Remove trailing zeros (padding)
      String hex = replaceAll(RegExp(r'0+$'), '');

      if (hex.isEmpty) {
        return '';
      }

      // If length is not even, pad with 0
      hex = hex.length.isOdd ? '0$hex' : hex;

      // Convert hex pairs to bytes
      List<int> bytes = [];
      for (int i = 0; i < hex.length; i += 2) {
        if (i + 1 < hex.length) {
          String hexPair = hex.substring(i, i + 2);
          int? byte = int.tryParse(hexPair, radix: 16);
          if (byte != null) {
            bytes.add(byte);
          }
        }
      }

      if (bytes.isEmpty) {
        return '';
      }

      // Decode as UTF-8 with error handling
      return utf8.decode(bytes, allowMalformed: true);
    } catch (e) {
      return '';
    }
  }
}
