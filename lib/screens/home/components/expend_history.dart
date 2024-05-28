import 'package:flutter/material.dart';
import 'package:money_management/components/base64_image_widget.dart';
import 'package:money_management/model/expend.dart';
import 'package:money_management/utils/currence_format.dart';
import 'package:money_management/utils/date_format.dart';
import 'package:money_management/utils/enum.dart';

class ExpendHistory extends StatelessWidget {
  const ExpendHistory({
    super.key,
    required this.expendList,
  });

  final List<ExpendModel> expendList;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: expendList.length,
      itemBuilder: (context, index) => Container(
        padding: const EdgeInsets.all(20),
        margin: const EdgeInsets.only(top: 10),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Base64ImageWidget(
              base64String: expendList[index].category?.icon?.image,
              width: 40,
            ),
            const SizedBox(width: 16.0),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(expendList[index].category?.name ?? "",
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style:
                          TextStyle(fontSize: 15, fontWeight: FontWeight.bold)),
                  Text(
                      displayDate(expendList[index].dateTime?.toUtc()) +
                          " - " +
                          formatDateTime(expendList[index].dateTime!),
                      style: TextStyle(fontSize: 12, color: Colors.black54))
                ],
              ),
            ),
            const SizedBox(width: 8),
            Text(
              formatCurrency(expendList[index].amount, true),
              style: TextStyle(
                  fontSize: 16,
                  color: expendList[index].transactionType ==
                          TransactionType.income.toString()
                      ? Colors.green[400]
                      : Colors.red[400]),
            )
          ],
        ),
      ),
    );
  }
}
