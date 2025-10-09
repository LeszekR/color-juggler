import 'package:color_juggler/app/features/color_page/bloc/color_bloc.dart';
import 'package:color_juggler/app/features/color_page/bloc/color_state.dart';
import 'package:color_juggler/app/home/color_juggler_home.dart';
import 'package:color_juggler/bootstrap/get_it_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

/// Root widget for the Color Juggler application.
///
/// Sets up [MaterialApp] with theme and home page.
class ColorJugglerApp extends StatelessWidget {
  /// App title shown in [AppBar]
  static const appTitle = 'Color Juggler - recruitment task';

  /// Creates the [ColorJugglerApp] widget.
  const ColorJugglerApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => getIt<ColorBloc>(),
      child: BlocBuilder<ColorBloc, ColorState>(
        builder: (context, state) => MaterialApp(
          title: 'Color Juggler',
          theme: ThemeData(colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple)),
          debugShowCheckedModeBanner: false,
          home: const ColorJugglerHome(title: appTitle),
        ),
      ),
    );
  }
}
