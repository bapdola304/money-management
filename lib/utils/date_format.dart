import 'package:intl/intl.dart';

String getCurrentDateTime() {
  DateTime now = DateTime.now();
  DateFormat formatter = DateFormat('dd/MM/yyyy, HH:mm a');
  return formatter.format(now);
}
