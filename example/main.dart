import 'package:event_timeline_view/features/timeline_view/data/event_model.dart';
import 'package:event_timeline_view/features/timeline_view/presentation/screen/timeline_view_screen.dart';
import 'package:flutter/material.dart';

class Example extends StatefulWidget {
  const Example({Key? key}) : super(key: key);

  @override
  State<Example> createState() => _ExampleState();
}

class _ExampleState extends State<Example> {
  List<EventModel> events = [
    EventModel(
        startTime: DateTime(2024, 3, 27, 3, 25, 56),
        endTime: DateTime(2024, 2, 27, 7, 55, 22),
        statusColor: 'FF6B00'),
  ];

  @override
  Widget build(BuildContext context) {
    return TimelineViewScreen(
      events: events,
      selectedDay: DateTime(
        2024,
        3,
        27,
      ),
    );
  }
}
