import 'package:flutter/material.dart';
import 'package:event_timeline_view/core/base/screen/base_screen.dart';
import 'package:event_timeline_view/core/ui/theme/text_style_extension/text_style_extension.dart';
import 'package:event_timeline_view/core/ui/widget_extension/widget_extension.dart';
import 'package:event_timeline_view/core/ui/widgets/size_box.dart';
import 'package:event_timeline_view/core/util/date_util/date_utils.dart';

import '../../../data/event_model.dart';

class EventWidget extends BaseScreen {
  final EventModel eventModel;

  EventWidget({super.key, required this.eventModel});

  @override
  State<EventWidget> createState() => _EventWidgetState();
}

class _EventWidgetState extends BaseScreenState<EventWidget> {
  @override
  Widget body(BuildContext context) {
    return ConstrainedBox(
      constraints: BoxConstraints(
        minWidth: screenUtil.setWidth(130),
        maxWidth: screenUtil.setWidth(190),
      ),
      child: Card(
        elevation: 4,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(4),
        ),
        child: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              stops: [0.02, 0.02],
              colors: [
                convertHaxColorCodeToColorObject(
                    colorCode: widget.eventModel.statusColor),
                appColors.whiteColor
              ],
            ),
            borderRadius: BorderRadius.all(
              Radius.circular(4),
            ),
          ),
          child: SingleChildScrollView(
            padding: EdgeInsets.only(
              bottom: screenUtil.setHeight(10),
            ),
            child: (widget.eventModel.childWidget ??
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        widget.eventModel.title.getText14W500Text(
                            textAlign: TextAlign.start,
                            screenUtil: screenUtil,
                            appColors: appColors),
                        HeightBox(height: 5),
                        widget.eventModel.description.getText14W400Text(
                            textAlign: TextAlign.start,
                            screenUtil: screenUtil,
                            maxLine: 5,
                            appColors: appColors,
                            textColor: appColors.primaryColor),
                        HeightBox(height: 5),
                        Row(
                          children: [
                            Icon(
                              Icons.calendar_today,
                              size: 14,
                            ),
                            WidthBox(width: 3.3),
                            ((DateUtil.getMonthDay(
                                        date: widget.eventModel.startTime)) +
                                    " - " +
                                    (DateUtil.getMonthDay(
                                        date: widget.eventModel.startTime)))
                                .getSubtext14W400Text(
                                    screenUtil: screenUtil,
                                    appColors: appColors)
                          ],
                        ),
                        HeightBox(height: 5),
                        Row(
                          children: [
                            Icon(
                              Icons.watch_later_outlined,
                              size: 14,
                            ),
                            WidthBox(width: 3.3),
                            (DateUtil.get24ClockTimeFromDate(
                                        date: widget.eventModel.startTime) +
                                    " - " +
                                    DateUtil.get24ClockTimeFromDate(
                                        date: widget.eventModel.endTime))
                                .getSubtext14W400Text(
                                    screenUtil: screenUtil,
                                    appColors: appColors)
                          ],
                        ),
                        HeightBox(height: 10),
                      ],
                    ))
                .paddingSymmetric(
                    screenUtil: screenUtil,
                    horizontalPadding: 10,
                    verticalPadding: 10),
          ),
        ),
      ),
    );
  }

  static Color convertHaxColorCodeToColorObject({
    required String colorCode,
  }) =>
      Color(
        int.parse("0xff${colorCode.replaceAll("#", "")}"),
      );
}
