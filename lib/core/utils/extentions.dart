import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:weathera/core/utils/parse_helpers/failure_parser.dart';

import '../../di/injection.dart';
import '../domain/presentation/blocs/theme_bloc/theme_bloc.dart';
import 'failures/base_failure.dart';

extension ContextMethods on BuildContext {
  /// Parse General Failure To String Message
  String failureParser(Failure failure) =>
      FailureParser.mapFailureToString(failure: failure, context: this);

  ThemeData get theme => Theme.of(this);

  TextTheme get textTheme => Theme.of(this).textTheme;

  bool get isDark => getIt<ThemeBloc>().isDark;

  bool get isArabic => locale.languageCode == 'ar';

  bool get isTablet => MediaQuery.of(this).size.width > 768;
}

extension IterableExtension<E> on Iterable<E> {
  Iterable<T> mapIndexed<T>(T Function(int index, E element) f) {
    var index = 0;
    return map((element) => f(index++, element));
  }
}

extension HexColor on Color {
  static Color fromHex(String hexString) {
    final buffer = StringBuffer();
    if (hexString.length == 6 || hexString.length == 7) buffer.write('ff');
    buffer.write(hexString.replaceFirst('#', ''));
    return Color(int.parse(buffer.toString(), radix: 16));
  }

  Color lighten([double factor = 0.1]) {
    HSLColor hsl = HSLColor.fromColor(this);
    double newLightness = (hsl.lightness + factor).clamp(0.0, 1.0);
    HSLColor brighterHSL = hsl.withLightness(newLightness);
    return brighterHSL.toColor();
  }
}

extension DoubleMethods on double {
  double roundTo2DigitsAfterDecimalPoint() => double.parse(toStringAsFixed(2));
}

// Bidi isolates: keep a date/time string left-to-right even when it sits
// inside an Arabic (RTL) paragraph, so its digits can't be reordered.
const String _ltrIsolateStart = '\u2066';
const String _ltrIsolateEnd = '\u2069';

String _isolateLtr(String value) => '$_ltrIsolateStart$value$_ltrIsolateEnd';

extension Date on DateTime {
  /// Date: `19/11/2026`.
  String toAppDate() =>
      _isolateLtr(DateFormat('dd/MM/yyyy', 'en').format(this));

  /// Time: `10:30 PM`.
  String toAppTime() => _isolateLtr(DateFormat('hh:mm a', 'en').format(this));

  /// Date and time: `19/11/2026 - 10:30 PM`.
  String toAppDateTime() =>
      _isolateLtr(DateFormat('dd/MM/yyyy - hh:mm a', 'en').format(this));

  String getDayName({String? locale}) {
    return DateFormat('EEEE', locale).format(this);
  }

  String getMonthName({String? locale}) {
    return DateFormat('MMMM', locale).format(this);
  }

  String getDateWithMonthNameDayNameAndYear(String local) {
    return DateFormat("EEEE, dd MMMM", local).format(this);
  }

  bool isSameDay(DateTime other) =>
      year == other.year && month == other.month && day == other.day;

  bool isTimeNowMorning() {
    final morningThreshold = DateTime(year, month, day, 16, 0);
    return isBefore(morningThreshold);
  }
}

extension ShowToast on String {
  void showToast({
    ToastGravity gravity = ToastGravity.BOTTOM,
    Color? backgroundColor,
    Toast? toast = Toast.LENGTH_SHORT,
    Color? textColor,
    int? timeInSecForIosWeb,
  }) {
    Fluttertoast.showToast(
      msg: this,
      toastLength: toast,
      gravity: gravity,
      timeInSecForIosWeb: timeInSecForIosWeb ?? 3,
      backgroundColor: backgroundColor ?? Colors.black87,
      textColor: textColor ?? Colors.white,
      fontSize: 16.0,
    );
  }
}
