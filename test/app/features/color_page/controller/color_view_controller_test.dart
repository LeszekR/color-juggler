import 'package:color_juggler/app/features/color_page/controller/color_service.dart';
import 'package:color_juggler/app/features/color_page/controller/color_view_controller.dart';
import 'package:color_juggler/app/features/color_page/model/color_view_data.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../../../test_tools/test_mocks.mocks.dart';
import '../tools/color_controller_test_tools.dart';

void main() {
  late ColorService realUtils;
  late MockColorService mockUtils;

  setUpAll(() {
    realUtils = const ColorService();
    mockUtils = MockColorService();
  });

  group('nextColor returns color different from the previous one', () {
    for (final testCase in testCases) {
      test(testCase.title, () {
        testColorsChange(
          ColorService: realUtils,
          MockColorService: mockUtils,
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
  required ColorService ColorService,
  required MockColorService MockColorService,
  required Color backgroundBefore,
  required Color backgroundAfter,
  required Color textBefore,
  required Color textAfter,
}) {
  final ColorViewData data = ColorViewData(backgroundColor: backgroundBefore, textColor: textBefore);
  final ColorViewController controller = ColorViewController(MockColorService, data);

  // with
  when(MockColorService.randomColorRGBO()).thenReturn(backgroundAfter);

  // when
  controller.nextColor();

  // then
  expect(controller.data.backgroundColor, backgroundAfter);
  expect(controller.data.textColor, textAfter);
}
