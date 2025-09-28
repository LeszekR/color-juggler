import 'package:color_juggler/app/features/color_page/domain/color_service.dart';
import 'package:color_juggler/app/features/color_page/view/color_view.dart';
import 'package:flutter/material.dart';

/// Home page of the Color Juggler app.
///
/// Displays the [ColorView] inside a [Scaffold].
class ColorJugglerHome extends StatelessWidget {
  /// Title displayed in the app bar.
  final String title;

  /// Creates [ColorJugglerHome] with the given [title].
  const ColorJugglerHome({required this.title, super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(backgroundColor: Theme.of(context).colorScheme.inversePrimary, title: Text(title)),
      body: const Center(child: ColorView(ColorService())),
    );
  }
}
