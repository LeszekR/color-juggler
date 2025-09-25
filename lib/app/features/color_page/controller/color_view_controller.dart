import 'dart:math';
import 'dart:ui';

import 'package:color_juggler/app/features/color_page/model/color_view_data.dart';

/// Controls the logic for [../view/ColorView].
///
/// Responsible for generating and updating the current color state.
class ColorViewController {
  /// Random number generator used for color components.
  final Random random = Random();

  /// Holds the current state of the color view.
  ColorViewData data;

  /// Creates a [ColorViewController] with the given [data].
  ColorViewController(this.data);

  /// Generates a new color and updates [data].
  void nextColor() {
    _nextColor();
  }

  void _nextColor() {
    const int maxIterations = 1000;
    var i = 0;
    int red, green, blue;
    Color? newColor;

    // maxIterations prevent the very unlikely, yet possible case of infinite loop
    while (data.color == newColor && i < maxIterations) {
      red = random.nextInt(256);
      green = random.nextInt(256);
      blue = random.nextInt(256);
      newColor = Color.fromRGBO(red, green, blue, 1);
      i++;
    }

    data = data.copyWith(color: newColor ?? data.color);
  }
}
