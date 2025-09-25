import 'package:color_juggler/app/features/color_page/view/color_view.dart';
import 'package:flutter/material.dart';

/// Immutable state object holding all dynamic values of [../view/ColorView].
class ColorViewData {
  /// [ColorView] background color
  final Color backgroundColor;
  /// [ColorView] central text color
  final Color textColor;

  /// Immutable state object for ColorView.
  const ColorViewData({this.backgroundColor = Colors.white, this.textColor = Colors.black});

  /// Creates a copy with optional new color.
  ColorViewData copyWith({Color? backgroundColor, Color? textColor}) {
    return ColorViewData(backgroundColor: backgroundColor ?? this.backgroundColor, textColor: textColor ?? this.textColor);
  }
}
