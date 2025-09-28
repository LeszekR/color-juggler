import 'package:flutter/material.dart';

/// Params controlling the app's behaviour.
///
/// If needed - any params can be moved to external config [.env] file and accessed by the rest of the app via API
/// here.
class Config {
  /// If luminance < 0.3 we use white text, otherwise black.
  /// 0.3 is a arbitrarily picked threshold based on trial and error.
  /// Tune if you want a darker/light preference.
  static const luminanceThreshold = 0.3;

  /// Initial home page background color.
  static const startBackgroundColor = Colors.white;

  /// Initial home page test color.
  static const startTextColor = Colors.black;
}
