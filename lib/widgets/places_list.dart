import 'package:favorite_places/models/place.dart';
import 'package:favorite_places/screens/place_detail.dart';
import 'package:flutter/material.dart';

class PlacesList extends StatelessWidget {
  const PlacesList({super.key, required this.places});

  final List<Place> places;

  @override
  Widget build(BuildContext context) {
    return places.isEmpty
        ? const Center(
            child: Text(
              'No places added yet.',
            ),
          )
        : ListView.builder(
            itemBuilder: (ctx, index) => ListTile(
              contentPadding:
                  const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              leading: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                ),
                clipBehavior: Clip.antiAlias,
                child: Image.file(
                  places[index].image,
                  height: 60,
                  width: 60,
                  fit: BoxFit.cover,
                ),
              ),
              title: Text(places[index].title),
              subtitle: Text(places[index].location.address),
              onTap: () => Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (ctx) => PlaceDetailScreen(place: places[index]),
                ),
              ),
            ),
            itemCount: places.length,
          );
  }
}
