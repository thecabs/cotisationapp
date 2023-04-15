import 'package:intl/intl.dart';

class CustomDate {
  static String now() => DateFormat("yyyy-MM-dd").format(DateTime.now());
  static String hour() => DateFormat("HH:mm").format(DateTime.now());
  static String minimize() => DateFormat("dd-MM-yyyy").format(DateTime.now());
  static String custom(DateTime date) => DateFormat("dd-MM-yy").format(date);
}
