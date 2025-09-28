import 'package:color_juggler/app/features/color_page/controller/color_service.dart';
import 'package:color_juggler/app/features/color_page/model/color_view_data.dart';
import 'package:color_juggler/app/features/color_page/view/color_view.dart';
import 'package:flutter/material.dart';

/// Controls the logic for [../view/ColorView].
///
/// Responsible for generating and updating the current color state.
class ColorController {

  /// [ColorView] central text color on light background
  static const textColorDark = Colors.black;

  /// [ColorView] central text color on dark background
  static const textColorLight = Colors.white;

  /// Random number generator used for color components.
  final ColorService colorService;

  /// Holds the current state of the color view.
  ColorViewData data;

  /// Creates a [ColorController] with the given [data].
  ColorController(this.colorService, this.data);

  /// Generates a new color and updates [data].
  void nextColor() {
    _nextColor();
  }

  void _nextColor() {
    // maxIterations prevent the very unlikely, yet possible case of infinite loop or jank if it takes too long
    const int maxIterations = 10;

    Color backgroundColor;
    Color textColor;

    var i = 0;
    do {
      backgroundColor = colorService.randomColorRGBO();
      i++;
    } while (data.backgroundColor == backgroundColor && i < maxIterations);

    /// If luminance < 0.3 we use white text, otherwise black.
    /// 0.3 is a arbitrarily picked threshold based on trial and error.
    /// Tune if you want a darker/light preference.
    textColor = backgroundColor.computeLuminance() < 0.3 ? textColorLight : textColorDark;

    data = data.copyWith(
      backgroundColor: backgroundColor,
      textColor: textColor,
    );
  }
}
