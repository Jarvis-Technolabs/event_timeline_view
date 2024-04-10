import 'package:flutter/material.dart';
import 'package:event_timeline_view/core/base/screen/base_screen.dart';


class HeightBox extends BaseScreen {
  final double height;

  HeightBox({super.key, required this.height});

  @override
  State<HeightBox> createState() => _HeightBoxState();
}

class _HeightBoxState extends BaseScreenState<HeightBox> {
  @override
  Widget body(BuildContext context) {
    return SizedBox(
      height: screenUtil.setHeight(widget.height),
    );
  }
}

class WidthBox extends BaseScreen {
  final double width;

  WidthBox({ required this.width});

  @override
  State<WidthBox> createState() => _WidthBoxState();
}

class _WidthBoxState extends BaseScreenState<WidthBox> {
  @override
  Widget body(BuildContext context) {
    return SizedBox(
      width: screenUtil.setWidth(widget.width),
    );
  }
}
