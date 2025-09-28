import 'package:color_juggler/app/common/config.dart';
import 'package:color_juggler/app/features/color_page/bloc/color_bloc.dart';
import 'package:color_juggler/app/features/color_page/bloc/color_state.dart';
import 'package:color_juggler/app/features/color_page/domain/color_service.dart';
import 'package:color_juggler/app/features/color_page/view/color_view.dart';
import 'package:color_juggler/app/home/color_juggler_app.dart';
import 'package:color_juggler/bootstrap/get_it_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../../../test_tools/test_mocks.mocks.dart';
import '../../../../test_tools/test_utils.dart';
import '../tools/color_test_data.dart';

final appTitleFinder = find.text(ColorJugglerApp.appTitle);
final appBarFinder = find.ancestor(of: appTitleFinder, matching: find.byType(AppBar));

final centralTextFinder = find.text(ColorView.centralText);
final homeBoxFinder = find.ancestor(of: centralTextFinder, matching: find.byType(DecoratedBox));

void main() {
  late MockColorService mockColorService;

  setUp(() {
    mockColorService = MockColorService();
    initGetIt();
    getItReplaceSingleton<ColorService>(mockColorService);
  });

  tearDown(() {
    getIt.reset();
  });

  testWidgets('home page', (tester) async {
    // with
    await tester.pumpWidget(const ColorJugglerApp());

    // when
    expect(appBarFinder, findsOneWidget);
    expect(centralTextFinder, findsOneWidget);
    expect(homeBoxFinder, findsOneWidget);

    // then
    final homeDecoratedBox = tester.widget<DecoratedBox>(homeBoxFinder);
    final centralText = tester.widget<Text>(centralTextFinder);
    expect((homeDecoratedBox.decoration as BoxDecoration).color, Config.startBackgroundColor);
    expect(centralText.style!.color, Config.startTextColor);
  });

  group('tap changes background and text color', () {
    for (final testCase in testCases) {
      testWidgets(testCase.title, (tester) async {
        await testWidgetColorsChange(tester, mockColorService, testCase);
      });
    }
  });
}

Future<void> testWidgetColorsChange(
  WidgetTester tester,
  MockColorService mockColorService,
  ColorBlocTestCase testCase,
) async {
  DecoratedBox homeDecoratedBox;
  Text centralText;
  Color? backgroundColor;
  Color? textColor;

  // with
  when(mockColorService.randomColorRGBO()).thenReturn(testCase.backgroundAfter);
  getItReplaceSingleton<ColorBloc>(
    ColorBloc(ColorState(backgroundColor: testCase.backgroundBefore, textColor: testCase.textBefore)),
  );

  // DO NOT REMOVE this line
  // Important: ensures a fresh widget tree between iterations.
  // Without this, Flutter may reuse the old tree, invalidating the test.
  await tester.pumpWidget(Container());

  await tester.pumpWidget(const ColorJugglerApp());

  homeDecoratedBox = tester.widget<DecoratedBox>(homeBoxFinder);
  backgroundColor = (homeDecoratedBox.decoration as BoxDecoration).color;
  expect(backgroundColor, testCase.backgroundBefore);

  centralText = tester.widget<Text>(centralTextFinder);
  textColor = centralText.style!.color;
  expect(textColor, testCase.textBefore);

  // when
  await tester.tap(homeBoxFinder);
  await tester.pump();

  // then
  homeDecoratedBox = tester.widget<DecoratedBox>(homeBoxFinder);
  backgroundColor = (homeDecoratedBox.decoration as BoxDecoration).color;
  expect(backgroundColor, testCase.backgroundAfter);

  centralText = tester.widget<Text>(centralTextFinder);
  textColor = centralText.style!.color;
  expect(textColor, testCase.textAfter);
}
