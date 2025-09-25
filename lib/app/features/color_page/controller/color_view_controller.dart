import 'dart:math';

import 'package:color_juggler/app/features/color_page/model/color_view_data.dart';
import 'package:color_juggler/app/utils/utils.dart';
import 'package:flutter/material.dart';

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
    // maxIterations prevent the very unlikely, yet possible case of infinite loop or jank if it takes too long
    const int maxIterations = 1000;

    var i = 0;
    int red;
    int green;
    int blue;
    Color backgroundColor;
    Color textColor;

    do {
      red = random.nextInt(256);
      green = random.nextInt(256);
      blue = random.nextInt(256);
      backgroundColor = Color.fromRGBO(red, green, blue, 1.0);
      i++;
    } while (Utils.equalRgba(data.backgroundColor, backgroundColor) && i < maxIterations);

    /// If luminance < 0.3 we use white text, otherwise black.
    /// 0.3 is a arbitrarily picked threshold based on trial and error.
    /// Tune if you want a darker/light preference.
    textColor = backgroundColor.computeLuminance() < 0.3 ? Colors.white : Colors.black;

    data = data.copyWith(
        backgroundColor: backgroundColor,
        textColor: textColor,
    );
  }
}
