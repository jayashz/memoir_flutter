import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class PhotoInput extends StatefulWidget {
  const PhotoInput({super.key});

  @override
  State<PhotoInput> createState() => _PhotoInputState();
}

class _PhotoInputState extends State<PhotoInput> {
  File? _pickedPhoto;
  void _takePicture() async {
    final photoPicker = ImagePicker();
    final pickedPhoto = await photoPicker.pickImage(source: ImageSource.camera);
    if (pickedPhoto == null) return;
    setState(() {
      _pickedPhoto = File(pickedPhoto.path);
    });
  }

  @override
  Widget build(BuildContext context) {
    Widget content = TextButton.icon(
      onPressed: _takePicture,
      icon: Icon(Icons.camera_alt),
      label: Text("Take a picture"),
    );

    if (_pickedPhoto != null) {
      content = Image.file(
        _pickedPhoto!,
        fit: BoxFit.cover,
        width: double.infinity,
        height: double.infinity,
      );
    }
    return GestureDetector(
      onTap: _takePicture,
      child: Container(
          height: 250,
          width: double.infinity,
          alignment: Alignment.center,
          decoration: BoxDecoration(
              border: Border.all(width: 1),
              color: Theme.of(context).colorScheme.primary.withAlpha(20),
              borderRadius: BorderRadius.circular(12)),
          child: content),
    );
  }
}
