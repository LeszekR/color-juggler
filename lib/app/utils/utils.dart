import 'dart:ui';

/// Global app utils to be used both in release and in tests
class Utils {
  /// [Color] objects comparator - compares by r,g,b,o values. Two separate objects with the same RGBA values
  /// will be equal.
  static bool equalRgba(Color colorA, Color colorB) {
    if (identical(colorA, colorB)) return true;
    return colorA.a == colorB.a && colorA.r == colorB.r && colorA.g == colorB.g && colorA.b == colorB.b;
  }
}
