import 'package:intl/intl.dart';

extension DateTimeEX on DateTime {
  String getFormatString(String format) {
    final formatter = DateFormat(format);
    return formatter.format(this);
  }

  String getJapaneseDateE() {
    return DateFormat('yyyy年MM月dd日(E)', "ja").format(this);
  }

  DateTime getBeforeYear(int beforeYear) {
    int year = this.year - beforeYear;
    int month = this.month;
    int day = this.day;
    return DateTime(year, month, day, 0, 0);
  }

  DateTime getAfterYear(int afterYear) {
    int year = this.year + afterYear;
    int month = this.month;
    int day = this.day;
    return DateTime(year, month, day, 0, 0);
  }
}
