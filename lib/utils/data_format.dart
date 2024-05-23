import 'dart:convert';
import 'package:intl/intl.dart';
import 'package:money_management/model/expend.dart';

List<Map<String, dynamic>> groupAndFormatByDate(List<ExpendModel> dataList) {
  Map<String, List<ExpendModel>> groupedByDate = {};

  // Group items by date
  for (var item in dataList) {
    if (item.dateTime == null) continue;

    String day = DateFormat('dd').format(item.dateTime!);
    String monthYear = DateFormat('MM/yyyy').format(item.dateTime!);

    String dateKey = '{"day": "$day", "month_year": "$monthYear"}';

    if (groupedByDate.containsKey(dateKey)) {
      groupedByDate[dateKey]!.add(item);
    } else {
      groupedByDate[dateKey] = [item];
    }
  }

  // Create the final result list with total amount for each date
  List<Map<String, dynamic>> groupedData = groupedByDate.entries.map((entry) {
    Map<String, dynamic> dateKey = jsonDecode(entry.key);
    List<Map<String, dynamic>> items =
        entry.value.map((item) => item.toJson()).toList();

    // Separate income and expense items
    List<ExpendModel> incomeItems =
        entry.value.where((item) => item.transactionType == 'income').toList();
    List<ExpendModel> expenseItems =
        entry.value.where((item) => item.transactionType == 'expense').toList();

    // Calculate total amount for income and expense items, or set to null if no items
    int? totalIncome = incomeItems.isNotEmpty
        ? incomeItems.fold(0, (sum, item) => sum! + (item.amount ?? 0))
        : null;
    int? totalExpense = expenseItems.isNotEmpty
        ? expenseItems.fold(0, (sum, item) => sum! + (item.amount ?? 0))
        : null;

    return {
      'date': dateKey,
      'items': items,
      'totalIncome': totalIncome,
      'totalExpense': totalExpense,
    };
  }).toList();

  return groupedData;
}
