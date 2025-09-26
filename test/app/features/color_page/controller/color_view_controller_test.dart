import 'package:color_juggler/app/features/color_page/controller/color_utils.dart';
import 'package:color_juggler/app/features/color_page/controller/color_view_controller.dart';
import 'package:color_juggler/app/features/color_page/model/color_view_data.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../../../test_tools/test_mocks.mocks.dart';

void main() {
  late ColorUtils realUtils;
  late MockColorUtils mockUtils;

  setUpAll(() {
    realUtils = const ColorUtils();
    mockUtils = MockColorUtils();
    when(mockUtils.equalRGB(argThat(isA<Color>()), argThat(isA<Color>()))).thenAnswer((inv) {
      final colorA = inv.positionalArguments[0] as Color;
      final colorB = inv.positionalArguments[1] as Color;
      return realUtils.equalRGB(colorA, colorB);
    });
  });

  group('nextColor returns color different from the previous one', () {
    const backgroundLight1 = Color.fromRGBO(200, 250, 250, 1);
    const backgroundLight2 = Color.fromRGBO(250, 250, 200, 1);
    const backgroundDark1 = Color.fromRGBO(50, 50, 50, 1);
    const backgroundDark2 = Color.fromRGBO(90, 90, 90, 1);

    const textLight = ColorViewController.textColorLight;
    const textDark = ColorViewController.textColorDark;

    // The argument order in _ColorControllerTestCase is chosen for readability:
    // first the core change (the background),
    // then - knowing how the background changes - we can reason about the expected text color.
    const testCases = [
      _ColorControllerTestCase('dark to light', backgroundDark1, backgroundLight1, textLight, textDark),
      _ColorControllerTestCase('light to dark', backgroundLight1, backgroundDark1, textDark, textLight),
      _ColorControllerTestCase('dark to dark', backgroundDark1, backgroundDark2, textLight, textLight),
      _ColorControllerTestCase('light to light', backgroundLight1, backgroundLight2, textDark, textDark),
    ];

    for (final testCase in testCases) {
      test(testCase.title, () {
        testColorsChange(
          colorUtils: realUtils,
          mockColorUtils: mockUtils,
          backgroundBefore: testCase.backgroundBefore,
          backgroundAfter: testCase.backgroundAfter,
          textBefore: testCase.textBefore,
          textAfter: testCase.textAfter,
        );
      });
    }
  });
}

void testColorsChange({
  required ColorUtils colorUtils,
  required MockColorUtils mockColorUtils,
  required Color backgroundBefore,
  required Color backgroundAfter,
  required Color textBefore,
  required Color textAfter,
}) {
  final ColorViewData data = ColorViewData(backgroundColor: backgroundBefore, textColor: textBefore);
  final ColorViewController controller = ColorViewController(mockColorUtils, data);

  // with
  when(mockColorUtils.randomColorRGBO()).thenReturn(backgroundAfter);

  // when
  controller.nextColor();

  // then
  expect(controller.data.backgroundColor, backgroundAfter);
  expect(controller.data.textColor, textAfter);
  // expect(colorUtils.equalRGB(controller.data.backgroundColor, backgroundAfter), isTrue);
  // expect(colorUtils.equalRGB(controller.data.textColor, textAfter), isTrue);
}

class _ColorControllerTestCase {
  final String title;
  final Color backgroundBefore;
  final Color textBefore;
  final Color backgroundAfter;
  final Color textAfter;

  const _ColorControllerTestCase(
    this.title,
    this.backgroundBefore,
    this.backgroundAfter,
    this.textBefore,
    this.textAfter,
  );
}
