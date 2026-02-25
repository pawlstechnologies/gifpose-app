import 'package:intl/intl.dart';
import 'package:jiffy/jiffy.dart';

class CustomDate{

  static String slash(String date) {
    final formattedDate = Jiffy.parse(date).yMMMMEEEEdjm;
    return formattedDate;
  }

  static String formatAppliedDate(String date) {
    final formattedDate = Jiffy.parse(date).yMMMd;
    return formattedDate;
  }

  static String formatTransactionDate(String date) {
    final formattedDate = Jiffy.parse(date).yMMMEd;
    return formattedDate;
  }

  static String formatTransactionDateWithoutYear(String date) {
    final formattedDate = Jiffy.parse(date).MMMEd;
    return formattedDate;
  }

  static String getDate(String date) {
    var inputFormat = DateFormat('yyyy-MM-dd HH:mm');
    var inputDate = inputFormat.parse(date);
    var outputFormat = DateFormat('dd/MM/yyyy');
    return outputFormat.format(inputDate);
  }
}