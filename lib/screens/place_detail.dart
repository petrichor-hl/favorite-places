import 'package:favorite_places/models/place.dart';
import 'package:favorite_places/screens/map.dart';
import 'package:favorite_places/widgets/location_input.dart';
import 'package:flutter/material.dart';

class PlaceDetailScreen extends StatelessWidget {
  const PlaceDetailScreen({super.key, required this.place});

  final Place place;

  String get locationImageUrl {
    return 'https://maps.googleapis.com/maps/api/staticmap?center=${place.location.latitude},${place.location.longitude}&zoom=16&size=600x300&maptype=roadmap&markers=color:red%7Clabel:A%7C${place.location.latitude},${place.location.longitude}&key=${LocationInput.apiKey}';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(place.title),
      ),
      body: Stack(
        children: [
          Image.file(
            place.image,
            height: double.infinity,
            width: double.infinity,
            fit: BoxFit.cover,
          ),
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: Column(
              children: [
                InkWell(
                  onTap: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (ctx) => MapScreen(
                          location: place.location,
                          isSeleting: false,
                        ),
                      ),
                    );
                  },
                  child: CircleAvatar(
                    radius: 70,
                    backgroundImage: NetworkImage(locationImageUrl),
                  ),
                ),
                Container(
                  alignment: Alignment.center,
                  padding: const EdgeInsets.symmetric(
                    horizontal: 24,
                    vertical: 16,
                  ),
                  decoration: const BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
                        Colors.transparent,
                        Colors.black54,
                      ],
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                    ),
                  ),
                  child: Text(
                    place.location.address,
                    style: const TextStyle(fontSize: 18),
                    textAlign: TextAlign.center,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
