import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class ImagePickerField extends StatelessWidget {
  final String label;
  final Function(File file) onImagePicked;

  const ImagePickerField({
    super.key,
    required this.label,
    required this.onImagePicked,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label),
        TextFormField(
          readOnly: true,
          onTap: () async {
            final picker = ImagePicker();
            final pickedFile = await picker.pickImage(
              source: ImageSource.gallery,
            );
            if (pickedFile != null) {
              onImagePicked(File(pickedFile.path));
            }
          },
          decoration: const InputDecoration(
            hintText: 'Tap to select an image',
            suffixIcon: Icon(Icons.image),
          ),
        ),
      ],
    );
  }
}
