import 'package:color_juggler/app/features/color_page/view/color_view.dart';
import 'package:flutter/material.dart';

/// Immutable state object holding all dynamic values of [../view/ColorView].
class ColorViewData {
  /// Initial home page background color.
  static const startBackgroundColor = Colors.white;

  /// Initial home page test color.
  static const startTextColor = Colors.black;

  /// [ColorView] background color
  final Color backgroundColor;

  /// [ColorView] central text color
  final Color textColor;

  /// Immutable state object for ColorView.
  const ColorViewData({
    this.backgroundColor = ColorViewData.startBackgroundColor,
    this.textColor = ColorViewData.startTextColor,
  });

  /// Creates a copy with optional new color.
  ColorViewData copyWith({Color? backgroundColor, Color? textColor}) {
    final isBackgroundColorSame = backgroundColor == this.backgroundColor;
    final isTextColorSame = textColor == this.textColor;
    if (isBackgroundColorSame && isTextColorSame) {
      return this;
    }

    return ColorViewData(
      backgroundColor: backgroundColor ?? this.backgroundColor,
      textColor: textColor ?? this.textColor,
    );
  }
}
