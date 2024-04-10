import 'dart:async';

import 'package:event_timeline_view/core/base/screen/base_screen.dart';
import 'package:event_timeline_view/core/ui/theme/text_style_extension/text_style_extension.dart';
import 'package:event_timeline_view/core/ui/widget_extension/widget_extension.dart';
import 'package:event_timeline_view/core/ui/widgets/size_box.dart';
import 'package:event_timeline_view/features/timeline_view/presentation/screen/widgets/event_widget.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:table_calendar/table_calendar.dart';

import '../../../data/event_model.dart';

class TimelineViewWidget extends BaseScreen {
  final List<EventModel> events;
  final DateTime? selectedDay;

  TimelineViewWidget(
      {super.key, required this.events, required this.selectedDay});

  @override
  State<TimelineViewWidget> createState() => _MyRosterCalendarViewWidgetState();
}

class _MyRosterCalendarViewWidgetState
    extends BaseScreenState<TimelineViewWidget> {
  CalendarFormat _calendarFormat = CalendarFormat.week;
  DateTime _selectedDay = DateTime.now();
  final StreamController<bool> _streamController =
      StreamController<bool>.broadcast();
  DateTime _focusedDay = DateTime.now();

  ScrollController scrollController = ScrollController();
  List<EventModel> events = [];
  late List<List<EventModel>> groupedEvents;

  @override
  void initState() {
    super.initState();
    if (widget.selectedDay != null) {
      _selectedDay = widget.selectedDay!;
      _focusedDay = widget.selectedDay!;
    }

    WidgetsBinding.instance.addPostFrameCallback((_) {
      events = widget.events;
    });
  }

  @override
  Widget body(BuildContext context) {
    groupedEvents = groupEvents(events, _selectedDay);

    return SafeArea(
      child: Scaffold(
        backgroundColor: appColors.whiteColor,
        body: StreamBuilder<bool>(
            stream: _streamController.stream,
            builder: (context, snapshot) {
              return Column(
                children: [
                  TableCalendar(
                    daysOfWeekVisible: false,
                    headerVisible: true,
                    headerStyle: HeaderStyle(
                      formatButtonVisible: false,
                      headerMargin: EdgeInsets.zero,
                      titleTextStyle:
                          calendarMonthTitleTextStyle(screenUtil, appColors),
                      leftChevronMargin: EdgeInsets.zero,
                      leftChevronVisible: false,
                      rightChevronVisible: false,
                      rightChevronMargin: EdgeInsets.zero,
                      titleCentered: false,
                    ),
                    calendarBuilders: CalendarBuilders(
                      headerTitleBuilder: (context, DateTime day) {
                        return Container(
                          margin: EdgeInsets.only(
                              left: screenUtil.setWidth(21),
                              right: screenUtil.setWidth(21),
                              top: screenUtil.setHeight(16),
                              bottom: screenUtil.setHeight(8)),
                          child: Row(
                            children: [
                              GestureDetector(
                                onTap: () {
                                  _previousWeek();
                                },
                                child: Icon(Icons.chevron_left),
                              ),
                              DateFormat.yMMM().format(day).getText20W600Text(
                                  screenUtil: screenUtil, appColors: appColors),
                              GestureDetector(
                                child: Icon(Icons.chevron_right),
                                onTap: () {
                                  _nextWeek();
                                },
                              ),
                            ],
                          ),
                        );
                      },
                      selectedBuilder:
                          (context, DateTime day, DateTime focusedDay) {
                        return dayDesign(day, isSelected: true);
                      },
                      defaultBuilder:
                          (context, DateTime day, DateTime focusedDay) {
                        return dayDesign(day);
                      },
                      todayBuilder:
                          (context, DateTime day, DateTime focusedDay) {
                        return dayDesign(day, isSelected: true);
                      },
                    ),
                    onDaySelected: (selectedDay, focusedDay) {
                      _selectedDay = selectedDay;
                      _focusedDay = focusedDay;
                      groupedEvents = groupEvents(events, _selectedDay);
                      _streamController.add(true);
                    },
                    selectedDayPredicate: (day) {
                      return _selectedDay == day;
                    },
                    calendarFormat: _calendarFormat,
                    firstDay: DateTime.utc(2010, 10, 16),
                    lastDay: DateTime.utc(2030, 3, 14),
                    focusedDay: _focusedDay,
                    currentDay: _selectedDay,
                  ),
                  HeightBox(height: 24),
                  Row(
                    children: [
                      statusWidget(
                          statusColor: appColors.greenColor,
                          textValue: 'Accepted'),
                      WidthBox(width: 10),
                      statusWidget(
                          statusColor: appColors.redColor,
                          textValue: 'Declined')
                    ],
                  ).paddingSymmetric(
                      screenUtil: screenUtil, horizontalPadding: 12),
                  HeightBox(height: 20),
                  Expanded(
                    child: SingleChildScrollView(
                      padding: EdgeInsets.only(
                          left: screenUtil.setWidth(5),
                          right: screenUtil.setWidth(5),
                          bottom: screenUtil.setHeight(5)),
                      child: Stack(
                        fit: StackFit.loose,
                        children: [
                          ListView.builder(
                            itemCount: 24,
                            shrinkWrap: true,
                            padding: EdgeInsets.only(
                              bottom: screenUtil.setHeight(20),
                            ),
                            physics: NeverScrollableScrollPhysics(),
                            itemBuilder: (context, index) {
                              final hour = index.toString().padLeft(2, '0');
                              return SizedBox(
                                height: screenUtil.setHeight(77),
                                child: Row(
                                  children: [
                                    Container(
                                      alignment: Alignment.centerRight,
                                      padding: EdgeInsets.only(
                                        right: screenUtil.setWidth(8),
                                      ),
                                      child: '$hour:00'.getText14W400Text(
                                          screenUtil: screenUtil,
                                          appColors: appColors),
                                    ),
                                    Expanded(
                                      child: Container(
                                        height: screenUtil.setHeight(1),
                                        color: appColors.dividerColor,
                                      ),
                                    ),
                                  ],
                                ),
                              );
                            },
                          ),
                          for (List<EventModel> group in groupedEvents)
                            Positioned(
                              top: getItemPadding(group.first),
                              left: screenUtil.setWidth(63),
                              right: 0,
                              child: SingleChildScrollView(
                                scrollDirection: Axis.horizontal,
                                padding: EdgeInsets.zero,
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    for (int i = 0; i < group.length; i++)
                                      SizedBox(
                                        height: getTimeOffset(
                                                group[i].endTime) -
                                            getTimeOffset(group[i].startTime),
                                        child: EventWidget(
                                          eventModel: group[i],
                                        ),
                                      ).paddingOnly(
                                        screenUtil,
                                        paddingLeft:
                                            i * screenUtil.setWidth(6.5),
                                        paddingTop: getItemPadding(group[i]) -
                                            getItemPadding(
                                              group.first,
                                            ),
                                      ),
                                  ],
                                ),
                              ),
                            ),
                        ],
                      ),
                    ),
                  ),
                ],
              );
            }),
      ),
    );
  }

  double getTopPaddingForGroup(List<EventModel> group) {
    if (group.isEmpty) return 0.0;

    DateTime earliestStartTime = group.first.startTime;
    for (EventModel event in group) {
      if (event.startTime.isBefore(earliestStartTime)) {
        earliestStartTime = event.startTime;
      }
    }

    final startHour = earliestStartTime.hour;
    final startMinute = earliestStartTime.minute;
    final totalStartMinutes = (startHour * 60) + startMinute;
    return (totalStartMinutes / 60) * screenUtil.setHeight(77) +
        screenUtil.setHeight(38.5);
  }

  double getItemPadding(EventModel event) {
    final startHour = event.startTime.hour;
    final startMinute = event.startTime.minute;
    final totalStartMinutes = (startHour * 60) + startMinute;
    return ((totalStartMinutes / 60) * screenUtil.setHeight(77)) +
        screenUtil.setHeight(38.5);
  }

  List<List<EventModel>> groupEvents(
      List<EventModel> events, DateTime selectedDay) {
    events.sort((a, b) => a.startTime.compareTo(b.startTime));

    // Initialize a list to store grouped events
    List<List<EventModel>> groupedEvents = [];

    // Iterate through sorted events and group overlapping events
    for (int i = 0; i < events.length; i++) {
      List<EventModel> currentGroup = [events[i]];
      DateTime currentEndTime = events[i].endTime;

      for (int j = i + 1; j < events.length; j++) {
        // Check if the next event overlaps with the current group
        if (events[j].startTime.isBefore(currentEndTime)) {
          currentGroup.add(events[j]);
          currentEndTime = currentEndTime.isBefore(events[j].endTime)
              ? events[j].endTime
              : currentEndTime;
          i++;
        } else {
          break;
        }
      }

      groupedEvents.add(currentGroup);
    }

    // Filter groups to include only those on the selected day
    List<List<EventModel>> filteredGroups = groupedEvents.where((group) {
      return group.any((event) =>
          event.startTime.year == selectedDay.year &&
          event.startTime.month == selectedDay.month &&
          event.startTime.day == selectedDay.day);
    }).toList();

    return filteredGroups;
  }

  Widget statusWidget({required Color statusColor, required String textValue}) {
    return Row(
      children: [
        Container(
          width: screenUtil.setWidth(10),
          height: screenUtil.setHeight(10),
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: statusColor,
          ),
        ),
        WidthBox(width: 5),
        textValue.getText12W400Text(
            screenUtil: screenUtil, appColors: appColors)
      ],
    );
  }

  void _previousWeek() {
    _focusedDay = _focusedDay.subtract(Duration(days: 7));
    _streamController.add(true);
  }

  void _nextWeek() {
    _focusedDay = _focusedDay.add(Duration(days: 7));
    _streamController.add(true);
  }

  Widget dayDesign(DateTime day, {bool isSelected = false}) => Container(
        decoration: BoxDecoration(
          color: isSelected
              ? appColors.primaryColor
              : appColors.boxBackgroundColor,
          borderRadius: BorderRadius.circular(20),
        ),
        margin: EdgeInsets.symmetric(
          horizontal: screenUtil.setWidth(7),
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              DateFormat('E').format(day).getText12W500Text(
                  screenUtil: screenUtil,
                  appColors: appColors,
                  textColor:
                      isSelected ? appColors.whiteColor : appColors.textColor),
              '${day.day}'.getText18W700Text(
                  screenUtil: screenUtil,
                  color:
                      isSelected ? appColors.whiteColor : appColors.textColor),
            ],
          ),
        ),
      );

  double getTimeOffset(DateTime time) {
    final hour = time.hour;
    final minutes = time.minute;
    final hourHeight = screenUtil.setHeight(77); // Adjust hour height as needed
    return hourHeight * hour + (minutes / 60) * hourHeight;
  }
}
