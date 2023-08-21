import 'dart:io';

import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:path_provider/path_provider.dart' as syspaths;
import 'package:path/path.dart' as path;
import 'package:sqflite/sqflite.dart' as sql;
import 'package:sqflite/sqlite_api.dart';

import 'package:favorite_places/models/place.dart';

Future<Database> _getDatabase() async {
  final dbPath = await sql.getDatabasesPath();
  return await sql.openDatabase(
    path.join(dbPath, 'places.db'),
    onCreate: (db, version) {
      return db.execute(
          'CREATE TABLE user_places(id TEXT PRIMARY KEY, title TEXT, image TEXT, lat REAL, lng REAL, address TEXT)');
    },
    version: 1,
  );
}

class UserPlacesNotifier extends StateNotifier<List<Place>> {
  UserPlacesNotifier() : super([]);

  Future<void> loadPlaces() async {
    final database = await _getDatabase();
    final data = await database.query('user_places');
    final places = data
        .map(
          (row) => Place(
            inputId: row['title'] as String,
            title: row['title'] as String,
            image: File(row['image'] as String),
            location: PlaceLocation(
              latitude: row['lat'] as double,
              longitude: row['lng'] as double,
              address: row['address'] as String,
            ),
          ),
        )
        .toList();

    state = places;
  }

  void addPlace(
    String newPlaceTitle,
    File newPlaceImage,
    PlaceLocation newPlaceLocation,
  ) async {
    final appDir = await syspaths.getApplicationDocumentsDirectory();
    final fileName = path.basename(newPlaceImage.path);
    final copiedImage = await newPlaceImage.copy('${appDir.path}/$fileName');

    final newPlace = Place(
        title: newPlaceTitle, image: copiedImage, location: newPlaceLocation);

    final database = await _getDatabase();

    database.insert(
      'user_places',
      {
        'id': newPlace.id,
        'title': newPlace.title,
        'image': newPlace.image.path,
        'lat': newPlace.location.latitude,
        'lng': newPlace.location.longitude,
        'address': newPlace.location.address,
      },
    );

    state = [
      newPlace,
      ...state,
    ];
  }
}

final userPlacesProvider =
    StateNotifierProvider<UserPlacesNotifier, List<Place>>(
  (ref) => UserPlacesNotifier(),
);
