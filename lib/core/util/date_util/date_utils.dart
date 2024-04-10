import 'package:intl/intl.dart';

class DateUtil {
  static String getMonthDay({required DateTime date}) =>
      DateFormat('MMM d').format(date);

  static String get24ClockTimeFromDate({required DateTime date}) =>
      DateFormat("HH:mm").format(date);
}
