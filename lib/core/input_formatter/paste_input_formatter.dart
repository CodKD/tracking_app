import 'package:flutter/services.dart';

class PasteInputFormatter extends TextInputFormatter {
  final Function(String) onPaste;

  PasteInputFormatter({required this.onPaste});

  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue oldValue,
    TextEditingValue newValue,
  ) {
    // Detect if the change is due to a paste action
    if (newValue.text.length > oldValue.text.length + 1) {
      Clipboard.getData(Clipboard.kTextPlain).then((clipboardData) {
        if (clipboardData != null) {
          onPaste(clipboardData.text ?? '');
        }
      });
    }
    return newValue;
  }
}
