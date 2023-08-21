import 'package:favorite_places/screens/places.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';

void main() {
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Great Places',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          brightness: Brightness.dark,
          seedColor: const Color.fromARGB(255, 102, 6, 247),
          background: const Color.fromARGB(255, 56, 49, 66),
        ),
        textTheme: GoogleFonts.ubuntuCondensedTextTheme().copyWith(
          bodyMedium: GoogleFonts.ubuntuCondensed(color: Colors.white),
          bodyLarge: GoogleFonts.ubuntuCondensed(color: Colors.white),
          headlineSmall: GoogleFonts.ubuntuCondensed(color: Colors.white),
        ),
        useMaterial3: true,
      ),
      debugShowCheckedModeBanner: false,
      home: const PlacesScreen(),
    );
  }
}
