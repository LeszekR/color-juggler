import 'package:bloc_test/bloc_test.dart';
import 'package:color_juggler/app/features/color_page/bloc/color_bloc.dart';
import 'package:color_juggler/app/features/color_page/bloc/color_event.dart';
import 'package:color_juggler/app/features/color_page/bloc/color_state.dart';
import 'package:color_juggler/app/features/color_page/domain/color_service.dart';
import 'package:color_juggler/bootstrap/get_it_model.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../../../test_tools/test_mocks.mocks.dart';
import '../tools/color_test_data.dart';

void main() {
  late MockColorService mockColorService;

  setUp(() {
    mockColorService = MockColorService();
    getIt.registerSingleton<ColorService>(mockColorService);
  });

  tearDown(() {
    getIt.reset();
  });

  group('nextColor returns color different from the previous one', () {
    for (final testCase in testCases) {
      blocTest(
        testCase.title,
        setUp: () => when(mockColorService.randomColorRGBO()).thenReturn(testCase.backgroundAfter),
        build: () => ColorBloc(const ColorState()),
        seed: () => ColorState(backgroundColor: testCase.backgroundBefore, textColor: testCase.textBefore),
        act: (bloc) => bloc.add(JuggleColorEvent()),
        expect: () => [ColorState(backgroundColor: testCase.backgroundAfter, textColor: testCase.textAfter)],
      );
    }
  });
}
