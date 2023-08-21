# favorite_places

<a href="https://docs-v2.riverpod.dev/">
    <img src="https://img.shields.io/badge/flutter-v3.13.0-blue" alt="Flutter SDK">
</a>

<a href="https://flutter.dev/">
  <p align="center">
    <picture>
      <source media="(prefers-color-scheme: dark)" srcset="https://storage.googleapis.com/cms-storage-bucket/6e19fee6b47b36ca613f.png">
      <img alt="Flutter" src="https://storage.googleapis.com/cms-storage-bucket/c823e53b3a1a7b0d36a9.png" width="50%">
    </picture>
  </p>
</a>

dependencies:
- google_fonts: ^5.1.0
- uuid: ^3.0.7
- flutter_riverpod: ^2.3.7
- image_picker: ^1.0.2
- location: ^5.0.3
- http: ^1.1.0
- google_maps_flutter: ^2.4.0
- path_provider: ^2.1.0
- path: ^1.8.3
- sqflite: ^2.3.0

api:
- [Geocoding API](https://developers.google.com/maps/documentation/geocoding)
- [Maps Static API](https://developers.google.com/maps/documentation/maps-static)

Note, repace "YOUR KEY HERE" by **your api key** in:
- android/app/src/main/AndroidManifest.xml  
  ```
  <manifest ...
    <application ...
      <meta-data android:name="com.google.android.geo.API_KEY"
                android:value="YOUR KEY HERE"/>
  ```

- ios/Runner/AppDelegate.swift
  ```
  override func application(
    _ application: UIApplication,
    didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
  ) -> Bool {
    GMSServices.provideAPIKey("YOUR KEY HERE")
    GeneratedPluginRegistrant.register(with: self)
    return super.application(application, didFinishLaunchingWithOptions: launchOptions)
  }
  ```

- lib/widgets/location_input.dart
  ```
  static const apiKey = 'YOUR KEY HERE';
  ```
