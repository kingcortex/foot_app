import 'package:intl/intl.dart';

String formatDateForCalendarButton(DateTime date) {
  final DateFormat formatter = DateFormat('dd MMM');
  return formatter.format(date).toUpperCase();
}

String extractTime(String isoString) {
  DateTime dateTime = DateTime.parse(isoString);
  String formattedTime = dateTime.toIso8601String().substring(11, 16);
  return formattedTime;
}

String formatDateForApi(DateTime date) {
  // Récupérer l'année, le mois et le jour
  String year = date.year.toString();
  String month = date.month.toString().padLeft(2, '0');
  String day = date.day.toString().padLeft(2, '0');

  // Combiner pour former la chaîne au format YYYY-MM-DD
  return '$year-$month-$day';
}
