import 'package:color_juggler/app/common/config.dart';
import 'package:color_juggler/app/features/color_page/view/color_view.dart';
import 'package:flutter/material.dart';

/// Immutable state object holding all dynamic values of [../view/ColorView].
class ColorState {
  /// [ColorView] background color
  final Color backgroundColor;

  /// [ColorView] central text color
  final Color textColor;

  /// Immutable state object for ColorView.
  const ColorState({this.backgroundColor = Config.startBackgroundColor, this.textColor = Config.startTextColor});

  /// Creates a copy with optional new color.
  ColorState copyWith({Color? backgroundColor, Color? textColor}) {
    final isBackgroundColorSame = backgroundColor == this.backgroundColor;
    final isTextColorSame = textColor == this.textColor;
    if (isBackgroundColorSame && isTextColorSame) {
      return this;
    }

    return ColorState(backgroundColor: backgroundColor ?? this.backgroundColor, textColor: textColor ?? this.textColor);
  }
}
