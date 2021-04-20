import 'package:intl/intl.dart';

extension DateTimeParsing on DateTime {
  static final dateFormatter = DateFormat('yyyy-MM-dd');
  static final dateTimeFormatter = DateFormat('yyyy-MM-dd HH:mm:ss');
  String toDateString() {
    return dateFormatter.format(this);
  }

  String toDateTimeString() {
    return dateTimeFormatter.format(this);
  }
}
