import 'package:intl/intl.dart';

extension DatetimeExtension on DateTime {
  String get ymd => DateFormat('yyyy-MM-dd').format(this);
  String get t => DateFormat('hh:mm a').format(this);

  DateTime addIfAfterHour({required int beforeDays, required int afterDays}) {
    if (hour > 11) {
      return add(Duration(days: afterDays));
    } else {
      return add(Duration(days: beforeDays));
    }
  }

  bool isBeforeOrEqual(DateTime input) => isBefore(input) || day == input.day;
}
