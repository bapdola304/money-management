import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:money_management/model/expend.dart';
import 'package:money_management/skeletons/skeleton_home_board.dart';
import 'package:money_management/utils/currence_format.dart';
import 'package:money_management/utils/data_utils.dart';

class ExpendBoard extends StatelessWidget {
  const ExpendBoard({
    super.key,
    required this.expendList,
    required this.isLoading,
  });
  final List<ExpendModel> expendList;
  final bool isLoading;

  int calculateTotalAmountByType(List<ExpendModel> dataList, String type) {
    List<ExpendModel> items =
        dataList.where((item) => item.transactionType == type).toList();

    int? total = dataList.isNotEmpty
        ? items.fold(0, (sum, item) => sum! + (item.amount ?? 0))
        : 0;
    return total ?? 0;
  }

  @override
  Widget build(BuildContext context) {
    int totalIncome = calculateTotalAmountByType(expendList, 'income');
    int totalExpense = calculateTotalAmountByType(expendList, 'expense');
    return Container(
      height: 120,
      padding: const EdgeInsets.symmetric(horizontal: 20),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              Colors.green[100] ?? Colors.transparent,
              Colors.green[200] ?? Colors.transparent,
              Colors.green[400] ?? Colors.transparent,
              Colors.green[500] ?? Colors.transparent,
            ],
          )),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  const Icon(
                    Icons.arrow_circle_right_outlined,
                    color: Colors.green,
                  ),
                  const SizedBox(width: 5),
                  isLoading
                      ? SkeletonHomeBoard()
                      : Text(formatCurrency(totalIncome, true),
                          style: const TextStyle(
                              color: Colors.green,
                              fontSize: 20,
                              fontWeight: FontWeight.w500))
                ],
              ),
              const SizedBox(height: 10),
              Row(
                children: [
                  Icon(Icons.arrow_circle_left_outlined,
                      color: Colors.red[400]),
                  const SizedBox(width: 5),
                  isLoading
                      ? SkeletonHomeBoard()
                      : Text(
                          formatCurrency(totalExpense, true),
                          style: TextStyle(
                              color: Colors.red[400],
                              fontSize: 20,
                              fontWeight: FontWeight.w500),
                        )
                ],
              )
            ],
          ),
          SvgPicture.asset(
            'assets/icons/data.svg',
            width: 120,
          )
        ],
      ),
    );
  }
}
