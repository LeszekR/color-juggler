import 'package:color_juggler/app/features/color_page/bloc/color_bloc.dart';
import 'package:color_juggler/app/features/color_page/bloc/color_event.dart';
import 'package:color_juggler/app/features/color_page/bloc/color_state.dart';
import 'package:color_juggler/app/features/color_page/domain/color_service.dart';
import 'package:color_juggler/bootstrap/get_it_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

/// Main widget that displays the current color and handles interactions.
class ColorView extends StatefulWidget {
  /// Text showing in the center of home page
  static const centralText = 'Hello there';

  /// Creates [ColorService] instance.
  final ColorService colorService;

  /// Creates a [ColorView] - the app home page with its base functionality changing color on tap.
  const ColorView(this.colorService);

  @override
  _ColorViewState createState() => _ColorViewState();
}

/// State class for [ColorView].
class _ColorViewState extends State<ColorView> {
  @override
  Widget build(BuildContext context) {
    final ColorBloc bloc = context.read<ColorBloc>();
    return BlocBuilder<ColorBloc, ColorState>(
      builder: (context, state) {
        return GestureDetector(
          behavior: HitTestBehavior.opaque,
          onTap: () => bloc.add(JuggleColorEvent()),
          child: DecoratedBox(
            decoration: BoxDecoration(color: state.backgroundColor),
            child: Center(
              child: Text(
                ColorView.centralText,
                style: TextStyle(
                  color: state.textColor,
                  fontSize: (Theme.of(context).textTheme.titleLarge?.fontSize ?? 12) * 2,
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
