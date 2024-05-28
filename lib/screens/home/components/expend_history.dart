import 'package:flutter/material.dart';
import 'package:money_management/components/base64_image_widget.dart';
import 'package:money_management/model/expend.dart';
import 'package:money_management/provider/account_provider.dart';
import 'package:money_management/provider/category_provider.dart';
import 'package:money_management/screens/create_expend/create_expend.dart';
import 'package:money_management/utils/currence_format.dart';
import 'package:money_management/utils/date_format.dart';
import 'package:money_management/utils/enum.dart';
import 'package:provider/provider.dart';

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
      itemBuilder: (context, index) => InkWell(
        onTap: () {
          ExpendModel expendSelected = expendList[index];
          context
              .read<AccountProvider>()
              .setAccountSelected(expendSelected.account!);
          context
              .read<CategoryProvider>()
              .setCategoryIdSelected(expendSelected.category?.id ?? "");
          Navigator.of(context, rootNavigator: true).push(
            MaterialPageRoute(
              builder: (context) =>
                  CreateExpend(expendSelected: expendSelected),
            ),
          );
        },
        child: Container(
          padding: const EdgeInsets.all(20),
          margin: const EdgeInsets.only(top: 10),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(20),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                  decoration: BoxDecoration(
                    color: Colors.black54,
                    shape: BoxShape.circle,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.5),
                        spreadRadius: 2,
                        blurRadius: 4,
                        offset: const Offset(0, 2),
                      ),
                    ],
                  ),
                  child: Base64ImageWidget(
                    base64String: expendList[index].category?.icon?.image,
                    width: 40,
                  )),
              const SizedBox(width: 16.0),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(expendList[index].category?.name ?? "",
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                            fontSize: 15, fontWeight: FontWeight.bold)),
                    Text(
                        "${displayDate(expendList[index].dateTime?.toUtc())} - ${formatDateTime(expendList[index].dateTime!)}",
                        style: const TextStyle(
                            fontSize: 12, color: Colors.black54)),
                    Text(
                        "Tài khoản: ${expendList[index].account?.accountName ?? ""}",
                        style: const TextStyle(
                            fontSize: 12, color: Colors.black87))
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
      ),
    );
  }
}
