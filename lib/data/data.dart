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
