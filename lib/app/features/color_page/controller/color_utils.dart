import 'dart:math';
import 'dart:ui';

import 'package:color_juggler/app/features/color_page/controller/color_view_controller.dart';

/// Utils for processing colors for [ColorViewController]
class ColorUtils {

  /// Creates [ColorUtils].
  const ColorUtils();

  /// Compares two [Color] objects by value - objects are equal when r, g, b values are the equal in both.
  // TODO remove - replace with Color == operator
  bool equalRGB(Color colorA, Color colorB) {
    if (identical(colorA, colorB)) return true;
    return colorA.r == colorB.r && colorA.g == colorB.g && colorA.b == colorB.b;
  }

  /// Creates color from randomly picked red, green, blue int values
  Color randomColorRGBO() {
    final random = Random();
    final red = random.nextInt(256);
    final green = random.nextInt(256);
    final blue = random.nextInt(256);
    return Color.fromRGBO(red, green, blue, 1.0);
  }
}
