import 'package:flutter/material.dart';

import '../../util/screen_util/screen_util.dart';

extension ImageExtension on String {
  Image getIconImage({
    required ScreenUtil screenUtil,
    double height = 24.0,
    double width = 24.0,
    Color? imgColor,
    BoxFit? boxFit,
    double? scale,
  }) =>
      Image.asset(
        this,
        height: screenUtil.setHeight(height),
        width: screenUtil.setWidth(width),
        color: imgColor,
        fit: boxFit,
        scale: scale,
      );
}
