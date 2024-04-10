
import 'package:event_timeline_view/features/timeline_view/presentation/screen/timeline_view_screen.dart';
import 'package:flutter/material.dart';

import 'features/timeline_view/data/event_model.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    List<EventModel> events = [
      EventModel(
        startTime: DateTime(2024, 3, 27, 3, 25, 56),
        endTime: DateTime(2024, 4, 27, 7, 55, 22),
        statusColor: 'FF6B00',
      ),
    ];
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowMaterialGrid: false,
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: TimelineViewScreen(
        events: events,
        selectedDay: DateTime(
          2024,
          3,
          27,
        ),
      ),
    );
  }
}
