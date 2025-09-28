import 'package:color_juggler/app/features/color_page/controller/color_service.dart';
import 'package:color_juggler/app/features/color_page/controller/color_controller.dart';
import 'package:color_juggler/app/features/color_page/model/color_view_data.dart';
import 'package:flutter/material.dart';

/// Main widget that displays the current color and handles interactions.
class ColorView extends StatefulWidget {
  /// Text showing in the center of home page
  static const centralText = 'Hello there';

  /// Creates [ColorService] instance.
  final ColorService colorService;

  /// Creates a [ColorView].
  const ColorView(this.colorService);

  @override
  _ColorViewState createState() => _ColorViewState();
}

/// State class for [ColorView].
class _ColorViewState extends State<ColorView> {
  /// Controller that manages the color state.
  late final ColorController controller;

  @override
  void initState() {
    super.initState();

    // This state should be preserved up in the tree - this is an absolutely minimal implementation which will loose
    // the state on every rebuild. Keeping the state in dedicated object makes it easy to refactor to preserve it.
    const data = ColorViewData();
    controller = ColorController(widget.colorService, data);
  }

  void _newColor() {
    controller.nextColor();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: _newColor,
      child: DecoratedBox(
        decoration: BoxDecoration(color: controller.data.backgroundColor),
        child: Center(
          child: Text(
            ColorView.centralText,
            style: TextStyle(
              color: controller.data.textColor,
              fontSize: (Theme.of(context).textTheme.titleLarge?.fontSize ?? 12) * 2,
            ),
          ),
        ),
      ),
    );
  }
}
