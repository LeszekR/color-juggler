import 'package:color_juggler/app/features/color_page/view/color_view.dart';
import 'package:flutter/material.dart';

/// Home page of the Color Juggler app.
///
/// Displays the [ColorView] inside a [Scaffold].
class ColorJugglerHome extends StatelessWidget {
  /// Title displayed in the app bar.
  final String title;

  /// Creates a [ColorJugglerHome] with the given [title].
  const ColorJugglerHome({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(title),
      ),
      body: Center(
        child: ColorView(),
      ),
    );
  }
}
