import 'package:flutter/material.dart';

/// Immutable state object holding all dynamic values of [../view/ColorView].
class ColorViewData {
  final Color color;

  /// Immutable state object for ColorView.
  const ColorViewData({this.color = Colors.white});

  /// Creates a copy with optional new color.
  ColorViewData copyWith({Color? color}) {
    return ColorViewData(color: color ?? this.color);
  }
}
