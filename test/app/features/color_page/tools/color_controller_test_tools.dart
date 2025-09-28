import 'dart:ui';

import 'package:color_juggler/app/features/color_page/controller/color_controller.dart';

const backgroundLight1 = Color.fromRGBO(200, 250, 250, 1);
const backgroundLight2 = Color.fromRGBO(250, 250, 200, 1);
const backgroundDark1 = Color.fromRGBO(50, 50, 50, 1);
const backgroundDark2 = Color.fromRGBO(90, 90, 90, 1);

const textLight = ColorController.textColorLight;
const textDark = ColorController.textColorDark;

const testCases = [
  ColorControllerTestCase('dark to light', backgroundDark1, backgroundLight1, textLight, textDark),
  ColorControllerTestCase('light to dark', backgroundLight1, backgroundDark1, textDark, textLight),
  ColorControllerTestCase('dark to dark', backgroundDark1, backgroundDark2, textLight, textLight),
  ColorControllerTestCase('light to light', backgroundLight1, backgroundLight2, textDark, textDark),
];

/// The argument order in _ColorControllerTestCase is chosen for readability:
/// first the core change (the background),
/// then - knowing how the background changes - we can reason about the expected text color.
class ColorControllerTestCase {
  final String title;
  final Color backgroundBefore;
  final Color textBefore;
  final Color backgroundAfter;
  final Color textAfter;

  const ColorControllerTestCase(
    this.title,
    this.backgroundBefore,
    this.backgroundAfter,
    this.textBefore,
    this.textAfter,
  );
}
