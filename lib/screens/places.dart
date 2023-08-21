import 'package:favorite_places/providers/user_places.dart';
import 'package:favorite_places/screens/add_place.dart';
import 'package:flutter/material.dart';

import 'package:favorite_places/widgets/places_list.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class PlacesScreen extends ConsumerStatefulWidget {
  const PlacesScreen({super.key});

  @override
  ConsumerState<PlacesScreen> createState() => _PlaceScreenState();
}

class _PlaceScreenState extends ConsumerState<PlacesScreen> {
  late final Future<void> _placesFuture =
      ref.read(userPlacesProvider.notifier).loadPlaces();

  @override
  Widget build(BuildContext context) {
    final userPlaces = ref.watch(userPlacesProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Your Places'),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (ctx) => const AddPlaceScreen(),
                ),
              );
            },
            icon: const Icon(Icons.add),
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 10),
        child: FutureBuilder(
          future: _placesFuture,
          builder: (ctx, snapshot) =>
              snapshot.connectionState == ConnectionState.waiting
                  ? const CircularProgressIndicator()
                  : PlacesList(places: userPlaces),
        ),
      ),
    );
  }
}
