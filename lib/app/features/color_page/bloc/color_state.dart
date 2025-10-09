import 'package:color_juggler/app/common/config.dart';
import 'package:color_juggler/app/features/color_page/view/color_view.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

/// Immutable state object holding all dynamic values of [../view/ColorView].
class ColorState extends Equatable {
  /// [ColorView] background color
  final Color backgroundColor;

  /// [ColorView] central text color
  final Color textColor;

  /// Immutable state object for [ColorView].
  const ColorState({this.backgroundColor = Config.startBackgroundColor, this.textColor = Config.startTextColor});

  /// Creates [ColorState] copy with optional new params.
  ColorState copyWith({Color? backgroundColor, Color? textColor}) {
    final isBackgroundColorSame = backgroundColor == this.backgroundColor;
    final isTextColorSame = textColor == this.textColor;

    if (isBackgroundColorSame && isTextColorSame) {
      return this;
    }

    return ColorState(backgroundColor: backgroundColor ?? this.backgroundColor, textColor: textColor ?? this.textColor);
  }

  @override
  List<Object?> get props => [backgroundColor, textColor];

  /// In case of extending the state this helps to debug the tests.
  @override
  bool? get stringify => true;
}
