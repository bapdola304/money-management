import 'package:intl/intl.dart';

String getCurrentDateTime() {
  DateTime now = DateTime.now();
  DateFormat formatter = DateFormat('dd/MM/yyyy, HH:mm a');
  return formatter.format(now);
}

String formatDateTime(DateTime date) {
  DateFormat formatter = DateFormat('dd/MM/yyyy');
  return formatter.format(date);
}

String displayDate(dynamic date) {
  DateTime now = DateTime.now();
  DateTime dateTime = _parseDateTime(date);

  if (dateTime.isAtSameMomentAs(now)) {
    return "Hôm nay";
  } else if (_isYesterday(dateTime, now)) {
    return "Hôm qua";
  } else if (_isTomorrow(dateTime, now)) {
    return "Ngày mai";
  } else {
    return DateFormat('EEEE', 'vi_VN').format(dateTime);
  }
}

DateTime _parseDateTime(dynamic date) {
  int day = int.parse(date['day']);
  int month = int.parse(date['month_year'].split('/')[0]);
  int year = int.parse(date['month_year'].split('/')[1]);

  return DateTime(year, month, day);
}

bool _isYesterday(DateTime dateTime, DateTime now) {
  return dateTime.year == now.year &&
      dateTime.month == now.month &&
      dateTime.day == now.day - 1;
}

bool _isTomorrow(DateTime dateTime, DateTime now) {
  return dateTime.year == now.year &&
      dateTime.month == now.month &&
      dateTime.day == now.day + 1;
}
