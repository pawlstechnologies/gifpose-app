import 'package:intl/intl.dart';

class ParallexFormatters {
  static String formatDate(DateTime? date) {
    if (date == null) {
      return "";
    }

    return DateFormat("yyyy-MM-dd").format(date);
  }
}
