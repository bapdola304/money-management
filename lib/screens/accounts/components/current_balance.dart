import 'package:flutter/material.dart';
import 'package:money_management/model/expend.dart';
import 'package:money_management/utils/currence_format.dart';

class CurrentBalance extends StatelessWidget {
  const CurrentBalance({
    super.key,
    required this.listExpend,
    required this.accountBalance,
  });

  final List<ExpendModel> listExpend;
  final int accountBalance;

  int calculateTotalAmountByType(List<ExpendModel> dataList, String type) {
    // Filter items by transactionType and calculate the total amount
    num totalAmount = dataList
        .where((item) => item.transactionType == type)
        .fold(0, (sum, item) => sum + (item.amount ?? 0));

    // Return null if there are no items or totalAmount is 0, otherwise return totalAmount
    return totalAmount.toInt();
  }

  int calculateCurrentBalance(List<ExpendModel> dataList) {
    int totalExpense = calculateTotalAmountByType(dataList, 'expense');
    int totalIncome = calculateTotalAmountByType(dataList, 'income');
    return (accountBalance + totalIncome) - totalExpense;
  }

  @override
  Widget build(BuildContext context) {
    int currentBalance = calculateCurrentBalance(listExpend);
    return Container(
      color: Colors.white,
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const Text('Số dư hiện tại',
              style: TextStyle(fontSize: 16, color: Colors.black54)),
          Text(formatCurrency(currentBalance, true),
              style: const TextStyle(
                  fontSize: 18,
                  color: Colors.black,
                  fontWeight: FontWeight.bold)),
        ],
      ),
    );
  }
}
