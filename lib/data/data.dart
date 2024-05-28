import 'package:money_management/model/home_date_category.dart';
import 'package:money_management/utils/enum.dart';

class TransactionTypeSelect {
  final String name;
  final String value;
  final String icon;
  TransactionTypeSelect(
      {required this.name, required this.value, required this.icon});
}

List<TransactionTypeSelect> transactionTypeList = [
  TransactionTypeSelect(
      name: 'Chi tiền',
      value: TransactionType.expense.toString(),
      icon: 'assets/icons/minus.png'),
  TransactionTypeSelect(
      name: 'Thu tiền',
      value: TransactionType.income.toString(),
      icon: 'assets/icons/plus.png')
];

List<DateCategory> dateCategoryList = [
  DateCategory(startDate: null, endDate: null, title: 'Tất cả', index: 0),
  DateCategory(
      startDate: formatStartDate(DateTime.now()),
      endDate: formatEndDate(DateTime.now()),
      title: 'Hôm nay',
      index: 1),
  DateCategory(
      startDate:
          formatStartDate(DateTime.now().subtract(const Duration(days: 7))),
      endDate: formatEndDate(DateTime.now()),
      title: '7 ngày qua',
      index: 2),
  DateCategory(
      startDate:
          formatStartDate(DateTime.now().subtract(const Duration(days: 30))),
      endDate: formatEndDate(DateTime.now()),
      title: '30 ngày qua',
      index: 3),
];

String formatEndDate(DateTime dateTime) {
  DateTime dateTimeFormat =
      DateTime(dateTime.year, dateTime.month, dateTime.day, 23, 59, 0);
  return dateTimeFormat.toIso8601String();
}

String formatStartDate(DateTime dateTime) {
  DateTime dateTimeFormat =
      DateTime(dateTime.year, dateTime.month, dateTime.day, 00, 00, 0);
  return dateTimeFormat.toIso8601String();
}
