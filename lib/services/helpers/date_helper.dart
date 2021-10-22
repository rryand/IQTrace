import 'package:intl/intl.dart';

class DateHelper {
  static String getCurrentDate() {
    DateTime now = new DateTime.now();
    return DateFormat('yyyy-MM-dd').format(now);
  }

  static String formatDate(DateTime date) {
    return DateFormat('yyyy-MM-dd').format(date);
  }

  static DateTime fromString(String date) {
    return DateTime.parse(date);
  }

  static int calculateDifference(DateTime date) {
    DateTime now = DateTime.now();
    return DateTime(date.year, date.month, date.day)
      .difference(DateTime(now.year, now.month, now.day)).inDays;
  }
}