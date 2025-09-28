import 'dart:math';
import 'dart:ui';

import 'package:color_juggler/app/features/color_page/bloc/color_bloc.dart';

/// Utils for processing colors for [ColorBloc]
class ColorService {
  /// Creates [ColorService] containing domain logic for [ColorView] used in [ColorBloc].
  const ColorService();

  /// Creates [Color] randomly picking red, green, blue int values.
  Color randomColorRGBO() {
    final random = Random();
    final red = random.nextInt(256);
    final green = random.nextInt(256);
    final blue = random.nextInt(256);
    return Color.fromRGBO(red, green, blue, 1.0);
  }
}
