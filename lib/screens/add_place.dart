import 'dart:io';

import 'package:favorite_places/models/place.dart';
import 'package:favorite_places/widgets/location_input.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:favorite_places/providers/user_places.dart';
import 'package:favorite_places/widgets/image_input.dart';

class AddPlaceScreen extends ConsumerStatefulWidget {
  const AddPlaceScreen({super.key});

  @override
  ConsumerState<AddPlaceScreen> createState() => _AddPlaceScreenState();
}

class _AddPlaceScreenState extends ConsumerState<AddPlaceScreen> {
  final _titleController = TextEditingController();
  File? _selectedImage;
  PlaceLocation? _selectedLocation;

  void _savePlace() {
    final enteredText = _titleController.text;

    if (enteredText.isEmpty ||
        _selectedImage == null ||
        _selectedLocation == null) {
      showDialog(
        context: context,
        builder: (ctx) => AlertDialog(
          title: const Text('Invalid input'),
          content: const Text('You have not complete input'),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(ctx).pop(),
              child: const Text('OK'),
            )
          ],
        ),
      );
      return;
    }

    ref
        .read(userPlacesProvider.notifier)
        .addPlace(enteredText, _selectedImage!, _selectedLocation!);

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('New Place added'),
        margin: EdgeInsets.all(10),
        behavior: SnackBarBehavior.floating,
      ),
    );

    Navigator.of(context).pop();
  }

  @override
  void dispose() {
    _titleController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add new Place'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            TextField(
              decoration: InputDecoration(
                labelText: 'Title',
                border:
                    OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
              ),
              controller: _titleController,
            ),
            const SizedBox(
              height: 16,
            ),
            ImageInput(
              onPickImage: (image) {
                _selectedImage = image;
              },
            ),
            const SizedBox(
              height: 16,
            ),
            LocationInput(
              onPickLocation: (placeLocation) {
                _selectedLocation = placeLocation;
              },
            ),
            const SizedBox(
              height: 50,
            ),
            ElevatedButton.icon(
              onPressed: _savePlace,
              icon: const Icon(Icons.add),
              label: const Text('Add Place'),
            ),
          ],
        ),
      ),
    );
  }
}
