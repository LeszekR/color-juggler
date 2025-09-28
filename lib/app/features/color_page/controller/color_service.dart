import 'dart:math';
import 'dart:ui';

import 'package:color_juggler/app/features/color_page/controller/color_controller.dart';

/// Utils for processing colors for [ColorController]
class ColorService {

  /// Creates [ColorService].
  const ColorService();

  /// Creates color from randomly picked red, green, blue int values
  Color randomColorRGBO() {
    final random = Random();
    final red = random.nextInt(256);
    final green = random.nextInt(256);
    final blue = random.nextInt(256);
    return Color.fromRGBO(red, green, blue, 1.0);
  }
}
