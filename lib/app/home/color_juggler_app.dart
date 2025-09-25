import 'package:color_juggler/app/home/color_juggler_home.dart';
import 'package:flutter/material.dart';

/// Root widget for the Color Juggler application.
///
/// Sets up [MaterialApp] with theme and home page.
class ColorJugglerApp extends StatelessWidget {
  /// Creates a [ColorJugglerApp].
  const ColorJugglerApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Color Juggler',
      theme: ThemeData(colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple)),
      debugShowCheckedModeBanner: false,
      home: const ColorJugglerHome(title: 'Color Juggler - recruitment task'),
    );
  }
}
