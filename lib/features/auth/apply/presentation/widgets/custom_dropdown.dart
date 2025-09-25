// import 'package:flutter/material.dart';

// class CustomDropdown extends StatelessWidget {
//   final String label;
//   final List<String> items;
//   final String? value;
//   final Function(String?) onChanged;

//   const CustomDropdown({
//     super.key,
//     required this.label,
//     required this.items,
//     required this.value,
//     required this.onChanged,
//   });

//   @override
//   Widget build(BuildContext context) {
//     return DropdownButtonFormField<String>(
//       decoration: InputDecoration(labelText: label),
//       items: items
//           .map((e) => DropdownMenuItem(value: e, child: Text(e)))
//           .toList(),
//       onChanged: onChanged,
//       validator: (val) => val == null ? "$label is required" : null,
//     );
//   }
// }
