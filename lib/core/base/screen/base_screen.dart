import 'package:event_timeline_view/core/ui/theme/colors/app_color.dart';
import 'package:event_timeline_view/core/util/screen_util/init_screen_util.dart';
import 'package:event_timeline_view/core/util/screen_util/screen_util.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

abstract class BaseScreen extends StatefulWidget {
  const BaseScreen({Key? key}) : super(key: key);
}

abstract class BaseScreenState<T extends BaseScreen> extends State<T>
    with WidgetsBindingObserver {
  late ScreenUtil screenUtil;
  late AppColor appColors;

  @override
  void initState() {
    appColors = AppColor();
    super.initState();
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.dark);
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void didChangeDependencies() {
    setScreenUtil();
    super.didChangeDependencies();
  }

  @override
  Widget build(_) => body(context);

  Widget body(BuildContext context);

  @override
  void setState(fn) {
    if (mounted) {
      super.setState(fn);
    }
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  void setScreenUtil() {
    screenUtil = getScreenUtilInstance(context);
  }
}
