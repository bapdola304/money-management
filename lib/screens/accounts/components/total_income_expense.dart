import 'package:flutter/material.dart';
import 'package:money_management/model/expend.dart';
import 'package:money_management/utils/currence_format.dart';

class TotalIncomeExpense extends StatelessWidget {
  const TotalIncomeExpense({
    super.key,
    required this.listExpend,
  });

  final List<ExpendModel> listExpend;

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;

    int calculateTotalAmountByType(List<ExpendModel> dataList, String type) {
      // Filter items by transactionType and calculate the total amount
      num totalAmount = dataList
          .where((item) => item.transactionType == type)
          .fold(0, (sum, item) => sum + (item.amount ?? 0));

      // Return null if there are no items or totalAmount is 0, otherwise return totalAmount
      return totalAmount.toInt();
    }

    return Row(
      children: [
        Container(
          width: screenWidth * 0.5 - 2,
          padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 8),
          color: Colors.white,
          child: Column(
            children: [
              const Text(
                'Tổng thu',
                style: TextStyle(fontWeight: FontWeight.w500),
              ),
              Text(
                  formatCurrency(
                      calculateTotalAmountByType(listExpend, 'income'), true),
                  maxLines: 1,
                  style: const TextStyle(
                      color: Colors.green,
                      fontSize: 18,
                      fontWeight: FontWeight.w500)),
            ],
          ),
        ),
        const SizedBox(width: 4),
        Container(
          width: screenWidth * 0.5 - 2,
          padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 8),
          color: Colors.white,
          child: Column(
            children: [
              const Text(
                'Tổng chi',
                style: TextStyle(fontWeight: FontWeight.w500),
              ),
              Text(
                  formatCurrency(
                      calculateTotalAmountByType(listExpend, 'expense'), true),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                      color: Colors.red,
                      fontSize: 18,
                      fontWeight: FontWeight.w500)),
            ],
          ),
        )
      ],
    );
  }
}
