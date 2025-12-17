import 'package:intl/intl.dart';

abstract class Formatters {
  static String currency(double amount, {String symbol = '\$'}) {
    final formatter = NumberFormat.currency(symbol: symbol, decimalDigits: 2);
    return formatter.format(amount);
  }

  static String number(num value) {
    final formatter = NumberFormat('#,###');
    return formatter.format(value);
  }

  static String cardNumber(String number) {
    final cleaned = number.replaceAll(' ', '');
    final buffer = StringBuffer();
    for (int i = 0; i < cleaned.length; i++) {
      if (i > 0 && i % 4 == 0) {
        buffer.write(' ');
      }
      buffer.write(cleaned[i]);
    }
    return buffer.toString();
  }

  static String maskedCardNumber(String number) {
    final cleaned = number.replaceAll(' ', '');
    if (cleaned.length < 4) return cleaned;
    final lastFour = cleaned.substring(cleaned.length - 4);
    return '**** **** **** $lastFour';
  }

  static String date(DateTime date, {String format = 'MMM dd, yyyy'}) {
    return DateFormat(format).format(date);
  }

  static String time(DateTime time, {String format = 'HH:mm'}) {
    return DateFormat(format).format(time);
  }

  static String dateTime(
    DateTime dateTime, {
    String format = 'MMM dd, yyyy HH:mm',
  }) {
    return DateFormat(format).format(dateTime);
  }
}
