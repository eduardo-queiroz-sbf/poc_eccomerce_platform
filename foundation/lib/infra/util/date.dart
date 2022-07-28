import 'package:intl/intl.dart';

class DateUtil {
  static const String brazilianDateCompactFormat = 'dd/MM/yy';
  static const String brazilianDateFormat = 'dd/MM/yyyy';
  static const String brazilianDateTimeFormat = 'dd/MM/yyyy HH:mm:ss';
  static const String brazilianDateTimeFormat2 = "dd/MM/yyyy à's' HH'h'mm";
  static const String brazilianDateLocale = 'pt_BR';

  static DateTime? parse(String isoString) {
    try {
      return DateTime.parse(isoString);
    } on Exception catch (_) {
      return null;
    }
  }

  static String format(DateTime? date, String format) {
    if (date != null) {
      return DateFormat(format).format(date);
    }
    return '';
  }

  static String formatFromString(String date, String format) =>
      DateUtil.format(parse(date), format);
}
