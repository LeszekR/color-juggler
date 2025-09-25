import 'package:color_juggler/app/features/color_page/controller/color_view_controller.dart';
import 'package:color_juggler/app/features/color_page/model/color_view_data.dart';
import 'package:flutter/cupertino.dart';

/// Main widget that displays the current color and handles interactions.
class ColorView extends StatefulWidget {
  /// Creates a [ColorView].
  const ColorView();

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
    // the state on every rebuild
    var data = ColorViewData();
    controller = ColorViewController(data);
  }

  void _newColor() {
    controller.nextColor();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(color: controller.data.color),
      child: Center(child: Text('Click anywhere and see what happens...')),
    );
  }
}
