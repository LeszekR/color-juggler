import 'package:bloc/bloc.dart';
import 'package:color_juggler/app/common/config.dart';
import 'package:color_juggler/app/features/color_page/bloc/color_event.dart';
import 'package:color_juggler/app/features/color_page/bloc/color_state.dart';
import 'package:color_juggler/app/features/color_page/domain/color_service.dart';
import 'package:color_juggler/app/features/color_page/view/color_view.dart';
import 'package:color_juggler/bootstrap/get_it_model.dart';
import 'package:flutter/material.dart';

/// Controls the logic for [../view/ColorView].
///
/// Responsible for generating and updating the current color state.
class ColorBloc extends Bloc<ColorEvent, ColorState> {
  /// [ColorView] central text color on light background
  static const textColorDark = Colors.black;

  /// [ColorView] central text color on dark background
  static const textColorLight = Colors.white;

  /// Random number generator used for color components.
  final ColorService colorService;

  /// Creates a [ColorBloc] with the given [state].
  ColorBloc() : colorService = getIt<ColorService>(), super(getIt<ColorState>()) {
    on<JuggleColorEvent>(_nextColor);
  }

  void _nextColor(ColorEvent event, Emitter<ColorState> emit) {
    // maxIterations prevent the very unlikely, yet possible case of infinite loop or jank if it takes too long
    const int maxIterations = 10;

    Color backgroundColor;
    Color textColor;

    var i = 0;

    do {
      backgroundColor = colorService.randomColorRGBO();
      i++;
    } while (state.backgroundColor == backgroundColor && i < maxIterations);

    textColor = backgroundColor.computeLuminance() < Config.luminanceThreshold ? textColorLight : textColorDark;

    emit(state.copyWith(backgroundColor: backgroundColor, textColor: textColor));
  }
}
