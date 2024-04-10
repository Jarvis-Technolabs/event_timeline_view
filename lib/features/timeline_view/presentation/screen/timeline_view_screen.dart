import 'dart:async';

import 'package:event_timeline_view/core/base/screen/base_screen.dart';
import 'package:event_timeline_view/features/timeline_view/presentation/screen/widgets/timeline_view_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../data/event_model.dart';

class TimelineViewScreen extends BaseScreen {
  final List<EventModel> events;
  final DateTime? selectedDay;

  TimelineViewScreen(
      {Key? key, required this.events, required this.selectedDay})
      : super(key: key);

  @override
  _TimelineViewScreenState createState() => _TimelineViewScreenState();
}

class _TimelineViewScreenState extends BaseScreenState<TimelineViewScreen> {
  StreamController<bool> showButtonsStreamController =
      StreamController<bool>.broadcast();

  @override
  void initState() {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.dark);
    super.initState();
  }

  @override
  Widget body(BuildContext context) {
    return Scaffold(
      backgroundColor: appColors.screenBgColor,
      body: TimelineViewWidget(
        events: widget.events,
        selectedDay: widget.selectedDay,
      ),
    );
  }
}
