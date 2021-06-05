import 'package:intl/intl.dart';

class DateHelper {
  static String getCurrentDate() {
    DateTime now = new DateTime.now();
    return DateFormat('yyyy-MM-dd').format(now);
  }
}