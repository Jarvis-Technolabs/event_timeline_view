import 'package:flutter/material.dart';

import '../../../util/screen_util/screen_util.dart';
import '../colors/app_color.dart';

extension TextStyles on String {
  ///get color size fontWeight font-family

  Text getText14W400Text(
          {required ScreenUtil screenUtil,
          required AppColor appColors,
          int maxLine = 1,
          TextAlign textAlign = TextAlign.start,
          Color? textColor}) =>
      Text(
        this,
        style: TextStyle(
          fontSize: screenUtil.setSp(14.0),
          color: textColor ?? appColors.textColor,
          fontWeight: FontWeight.w400,
        ),
        textAlign: textAlign,
        maxLines: maxLine,
        overflow: TextOverflow.ellipsis,
      );

  Text getText12W400Text({
    required ScreenUtil screenUtil,
    required AppColor appColors,
    int maxLine = 1,
    TextAlign textAlign = TextAlign.start,
  }) =>
      Text(
        this,
        style: TextStyle(
          fontSize: screenUtil.setSp(12.0),
          color: appColors.textColor,
          fontWeight: FontWeight.w400,
        ),
        textAlign: textAlign,
        maxLines: maxLine,
        overflow: TextOverflow.ellipsis,
      );

  Text getText12W500Text(
          {required ScreenUtil screenUtil,
          required AppColor appColors,
          int maxLine = 1,
          TextAlign textAlign = TextAlign.start,
          Color? textColor}) =>
      Text(
        this,
        style: TextStyle(
          fontSize: screenUtil.setSp(12.0),
          color: textColor ?? appColors.textColor,
          fontWeight: FontWeight.w500,
        ),
        textAlign: textAlign,
        maxLines: maxLine,
        overflow: TextOverflow.ellipsis,
      );

  Text getText14W500Text(
          {required ScreenUtil screenUtil,
          required AppColor appColors,
          int maxLine = 1,
          TextAlign textAlign = TextAlign.start,
          Color? textColor}) =>
      Text(
        this,
        style: TextStyle(
          fontSize: screenUtil.setSp(14.0),
          color: textColor ?? appColors.textColor,
          fontWeight: FontWeight.w500,
        ),
        textAlign: textAlign,
        maxLines: maxLine,
        overflow: TextOverflow.ellipsis,
      );

  Text getText18W700Text({
    required ScreenUtil screenUtil,
    int maxLine = 1,
    TextAlign textAlign = TextAlign.start,
    required Color color,
  }) =>
      Text(
        this,
        style: TextStyle(
          fontSize: screenUtil.setSp(18.0),
          color: color,
          fontWeight: FontWeight.w700,
        ),
        textAlign: textAlign,
        maxLines: maxLine,
        overflow: TextOverflow.ellipsis,
      );

  Text getText20W600Text({
    required ScreenUtil screenUtil,
    required AppColor appColors,
    int maxLine = 1,
    TextAlign textAlign = TextAlign.start,
  }) =>
      Text(
        this,
        style: TextStyle(
          fontSize: screenUtil.setSp(20.0),
          color: appColors.textColor,
          fontWeight: FontWeight.w600,
        ),
        textAlign: textAlign,
        maxLines: maxLine,
        overflow: TextOverflow.ellipsis,
      );

  Text getSubtext14W400Text({
    required ScreenUtil screenUtil,
    required AppColor appColors,
    int? maxLine = 1,
    TextAlign textAlign = TextAlign.start,
    TextOverflow? overflow = TextOverflow.ellipsis,
  }) =>
      Text(
        this,
        style: TextStyle(
          fontSize: screenUtil.setSp(14.0),
          color: appColors.subtextColor,
          fontWeight: FontWeight.w400,
        ),
        textAlign: textAlign,
        maxLines: maxLine,
        overflow: overflow,
      );
}

TextStyle calendarMonthTitleTextStyle(
        ScreenUtil screenUtil, AppColor appColors) =>
    TextStyle(
      fontWeight: FontWeight.w500,
      color: appColors.textColor,
      fontSize: screenUtil.setSp(16),
    );
