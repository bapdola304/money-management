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
  DateCategory(startDate: null, endDate: null, title: 'Tất cả'),
  DateCategory(
      startDate:
          DateTime.now().subtract(const Duration(days: 1)).toIso8601String(),
      endDate: DateTime.now().toIso8601String(),
      title: 'Hôm nay'),
  DateCategory(
      startDate:
          DateTime.now().subtract(const Duration(days: 7)).toIso8601String(),
      endDate: DateTime.now().toIso8601String(),
      title: '7 ngày qua'),
  DateCategory(
      startDate:
          DateTime.now().subtract(const Duration(days: 30)).toIso8601String(),
      endDate: DateTime.now().toIso8601String(),
      title: '30 ngày qua'),
];
