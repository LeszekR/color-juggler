import 'package:color_juggler/app/common/config.dart';
import 'package:color_juggler/app/features/color_page/bloc/color_state.dart';
import 'package:color_juggler/app/features/color_page/view/color_view.dart';
import 'package:color_juggler/app/home/color_juggler_app.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

final appTitleFinder = find.text(ColorJugglerApp.appTitle);
final appBarFinder = find.ancestor(of: appTitleFinder, matching: find.byType(AppBar));

final centralTextFinder = find.text(ColorView.centralText);
final homeBoxFinder = find.ancestor(of: centralTextFinder, matching: find.byType(DecoratedBox));

void main() {

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

  // Because color change is random, there is a tiny probability that ColorService
  // generates the same color again. With 5 iterations the chance of this happening
  // in each is ~10^-36, so for practical purposes we can treat it as deterministic.
  testWidgets('tap changes background color', (tester) async {
    bool didChangeColor = false;

    for (var i = 0; i < 5; i++) {
      didChangeColor = await testWidgetColorsChange(tester);
      if (didChangeColor) break;
    }
    expect(didChangeColor, isTrue);
  });
}

Future<bool> testWidgetColorsChange(WidgetTester tester) async {
  DecoratedBox homeDecoratedBox;
  const initialColor = Config.startBackgroundColor;
  Color? currentColor;

  // DO NOT REMOVE this line
  // Important: ensures a fresh widget tree between iterations.
  // Without this, Flutter may reuse the old tree, invalidating the test.
  await tester.pumpWidget(Container());

  // with
  await tester.pumpWidget(const ColorJugglerApp());
  homeDecoratedBox = tester.widget<DecoratedBox>(homeBoxFinder);
  currentColor = (homeDecoratedBox.decoration as BoxDecoration).color;
  expect(currentColor, initialColor);

  // when
  await tester.tap(homeBoxFinder);
  await tester.pump();

  // then
  homeDecoratedBox = tester.widget<DecoratedBox>(homeBoxFinder);
  currentColor = (homeDecoratedBox.decoration as BoxDecoration).color;
  return currentColor != initialColor;
}
