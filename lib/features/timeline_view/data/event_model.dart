import 'package:flutter/material.dart';

class EventModel {
  final DateTime startTime;
  final DateTime endTime;
  final Widget? childWidget;
  final String title, description;

  final String statusColor;

  EventModel(
      {required this.startTime,
      required this.endTime,
       this.childWidget,
      this.title = '',
      this.description = '',
      required this.statusColor});
}
