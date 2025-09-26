import 'package:color_juggler/app/features/color_page/controller/color_utils.dart';
import 'package:color_juggler/app/features/color_page/controller/color_view_controller.dart';
import 'package:color_juggler/app/features/color_page/model/color_view_data.dart';
import 'package:flutter/material.dart';

/// Main widget that displays the current color and handles interactions.
class ColorView extends StatefulWidget {
  final ColorUtils colorUtils;

  /// Creates a [ColorView].
  const ColorView(this.colorUtils);

  @override
  _ColorViewState createState() => _ColorViewState();
}

/// State class for [ColorView].
class _ColorViewState extends State<ColorView> {
  /// Controller that manages the color state.
  late final ColorViewController controller;

  @override
  void initState() {
    super.initState();

    // This state should be preserved up in the tree - this is an absolutely minimal implementation which will loose
    // the state on every rebuild. Keeping the state in dedicated object makes it easy to refactor to preserve it.
    const data = ColorViewData();
    controller = ColorViewController(widget.colorUtils, data);
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
          child: Text('Hello there', style: TextStyle(color: controller.data.textColor, fontSize: 24)),
        ),
      ),
    );
  }
}
