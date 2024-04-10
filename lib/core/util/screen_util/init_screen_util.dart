import 'package:flutter/material.dart';


import 'screen_util.dart';
const double UI_DESIGN_WIDTH = 375.0;
const double UI_DESIGN_HEIGHT = 812.0;
const int TABLET_DEVICE_WIDTH = 768;
ScreenUtil getScreenUtilInstance(BuildContext context) {
  ScreenUtil.init(
    context,
    width: UI_DESIGN_WIDTH,
    height: UI_DESIGN_HEIGHT,
  );
  return ScreenUtil();
}
