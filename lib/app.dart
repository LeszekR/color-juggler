import 'package:color_juggler/app/home/color_juggler_app.dart';
import 'package:flutter/material.dart';

/// Entry point runner for the application.
///
/// Provides a place to bootstrap tools like logger, configuration, or DI.
/// For this small app, it only calls [ColorJugglerApp].
Future<void> run() async {
  WidgetsFlutterBinding.ensureInitialized();

  // here is room for bootstrapping other app elements
  //  - Logger
  //  - Config (.env, etc)
  //  - DI (GetIt, etc)

  runApp(const ColorJugglerApp());
}
