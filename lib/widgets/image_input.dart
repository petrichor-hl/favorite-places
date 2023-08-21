import 'dart:io';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';

class ImageInput extends StatefulWidget {
  const ImageInput({super.key, required this.onPickImage});

  final void Function(File) onPickImage;

  @override
  State<StatefulWidget> createState() => _ImageInputState();
}

class _ImageInputState extends State<ImageInput> {
  File? _selectedImage;

  void _takePicture() async {
    final imagePicker = ImagePicker();
    final pickedImage = await imagePicker.pickImage(
      source: ImageSource.camera,
      imageQuality: 100,
    );

    if (pickedImage != null) {
      setState(() {
        _selectedImage = File(pickedImage.path);
      });
      widget.onPickImage(_selectedImage!);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(
          width: 1,
          color: Theme.of(context).colorScheme.onBackground.withOpacity(0.6),
        ),
        borderRadius: BorderRadius.circular(10),
      ),
      height: 250,
      width: double.infinity,
      alignment: Alignment.center,
      child: _selectedImage == null
          ? TextButton.icon(
              onPressed: _takePicture,
              icon: const Icon(Icons.camera),
              label: const Text('Take Picture'),
              style: TextButton.styleFrom(
                textStyle: GoogleFonts.ubuntuCondensed().copyWith(fontSize: 16),
              ),
            )
          : GestureDetector(
              onTap: _takePicture,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(9),
                clipBehavior: Clip.antiAlias,
                child: Image.file(
                  _selectedImage!,
                  fit: BoxFit.cover,
                  height: double.infinity,
                  width: double.infinity,
                ),
              ),
            ),
    );
  }
}
