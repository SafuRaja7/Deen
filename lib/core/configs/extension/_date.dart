part of '../configs.dart';

final _date = DateFormat("MMM dd, y");
final _dateTimeWords = DateFormat("MMM dd, yyyy KK:mmaaa");
final _dateTimeDigits = DateFormat("MM/dd/yyyy  | h:mm a");
final _formatMDYE = DateFormat("MMM d, y | E");
final _formatMDE = DateFormat("dd MMM, E");
final _formatMD = DateFormat("dd MMM");
final _formatMY = DateFormat("MMM, yyyy");
final _formatHMA = DateFormat("HH:mm");

extension SuperDate on DateTime {
  DateTime get today => DateTime(year, month, day);

  DateTime get endOfDay => add(const Duration(days: 1)).subtract(Duration(
        hours: hour,
        minutes: minute,
        seconds: second,
        milliseconds: millisecond,
        microseconds: microsecond,
      ));

  String get date => _date.format(this);

  String get dateTimeWords => _dateTimeWords.format(toLocal());

  String get dateTimeDigits => _dateTimeDigits.format(toLocal());

  String get formatMDYE => _formatMDYE.format(toLocal());

  String get formatMDE => _formatMDE.format(toLocal());

  String get formatMD => _formatMD.format(toLocal());

  String get formatMY => _formatMY.format(toLocal());

  String get formatHMA => _formatHMA.format(toLocal());

  String get formatDDMMYYY => DateFormat('dd/MM/yyyy').format(this);
  String get formatDDMMMYYY => DateFormat('dd/MMM/yyyy').format(this);
  String get formatDMMYY => DateFormat('dd.MM.yyyy').format(this);
  String get currentYear => DateFormat("yyyy").format(this);
  String get currentDay => DateFormat("EEEE").format(this);
}

extension DurationFormatting on Duration {
  String toFormattedString() {
    final hours = inHours;
    final minutes = inMinutes.remainder(60);
    return '${hours.toString().padLeft(2, '0')}:${minutes.toString().padLeft(2, '0')}';
  }
}
