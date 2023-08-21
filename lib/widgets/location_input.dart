import 'dart:convert';

import 'package:favorite_places/models/place.dart';
import 'package:favorite_places/screens/map.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import 'package:http/http.dart' as http;

class LocationInput extends StatefulWidget {
  const LocationInput({
    super.key,
    required this.onPickLocation,
  });

  static const apiKey = 'YOUR KEY HERE';

  final void Function(PlaceLocation) onPickLocation;

  @override
  State<LocationInput> createState() => _LocationInputState();
}

class _LocationInputState extends State<LocationInput> {
  bool _isGettingLocation = false;
  PlaceLocation? _pickedLocation;

  String get locationImageUrl {
    return 'https://maps.googleapis.com/maps/api/staticmap?center=${_pickedLocation!.latitude},${_pickedLocation!.longitude}&zoom=16&size=600x300&maptype=roadmap&markers=color:red%7Clabel:A%7C${_pickedLocation!.latitude},${_pickedLocation!.longitude}&key=${LocationInput.apiKey}';
  }

  Future<void> _saveLocation(double latitude, double longitude) async {
    final url = Uri.parse(
      'https://maps.googleapis.com/maps/api/geocode/json?latlng=$latitude,$longitude&key=${LocationInput.apiKey}',
    );

    final response = await http.get(url);

    final resData = json.decode(response.body);
    final address = resData['results'][0]['formatted_address'];

    _pickedLocation = PlaceLocation(
      latitude: latitude,
      longitude: longitude,
      address: address,
    );

    widget.onPickLocation(_pickedLocation!);
  }

  void _getCurrentLocation() async {
    Location location = Location();

    bool serviceEnabled;
    PermissionStatus permissionGranted;
    LocationData locationData;

    serviceEnabled = await location.serviceEnabled();
    if (!serviceEnabled) {
      serviceEnabled = await location.requestService();
      if (!serviceEnabled) {
        return;
      }
    }

    permissionGranted = await location.hasPermission();
    if (permissionGranted == PermissionStatus.denied) {
      permissionGranted = await location.requestPermission();
      if (permissionGranted != PermissionStatus.granted) {
        return;
      }
    }

    setState(() {
      _isGettingLocation = true;
    });

    locationData = await location.getLocation();

    final lat = locationData.latitude;
    final lng = locationData.longitude;

    if (lat == null || lng == null) {
      // Should show a message error hear
    } else {
      await _saveLocation(lat, lng);
    }

    setState(() {
      _isGettingLocation = false;
    });
  }

  void _selectOnMap() async {
    final pickedLocation = await Navigator.of(context).push<LatLng>(
      MaterialPageRoute(
        builder: (ctx) => const MapScreen(),
      ),
    );

    if (pickedLocation != null) {
      await _saveLocation(pickedLocation.latitude, pickedLocation.longitude);

      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          height: 170,
          width: double.infinity,
          decoration: BoxDecoration(
            border: Border.all(
              width: 1,
              color:
                  Theme.of(context).colorScheme.onBackground.withOpacity(0.6),
            ),
            borderRadius: BorderRadius.circular(10),
          ),
          alignment: Alignment.center,
          child: _isGettingLocation
              ? const CircularProgressIndicator()
              : _pickedLocation == null
                  ? const Text(
                      'No location chosen',
                      textAlign: TextAlign.center,
                    )
                  : ClipRRect(
                      borderRadius: BorderRadius.circular(9),
                      clipBehavior: Clip.antiAlias,
                      child: Image.network(
                        locationImageUrl,
                        height: double.infinity,
                        width: double.infinity,
                        fit: BoxFit.cover,
                      ),
                    ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            TextButton.icon(
              onPressed: _getCurrentLocation,
              icon: const Icon(Icons.location_on),
              label: const Text('Get current location'),
            ),
            TextButton.icon(
              onPressed: _selectOnMap,
              icon: const Icon(Icons.map),
              label: const Text('Select on Map'),
            )
          ],
        ),
      ],
    );
  }
}
