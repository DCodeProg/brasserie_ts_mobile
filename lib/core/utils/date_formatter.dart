import 'package:intl/intl.dart';

class DateFormatter {
  static String dateTimeToDayMonthYear(DateTime dateTime) {
    final dateFormater = DateFormat("dd/MM/yyyy");
    return dateFormater.format(dateTime);
  }

  static String dateTimeToDayMonthYearHourMinSec(DateTime dateTime) {
    final dateFormater = DateFormat("dd/MM/yyyy hh:mm:ss");
    return dateFormater.format(dateTime);
  }
}
