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

class ExpendHistory extends StatefulWidget {
  const ExpendHistory({
    super.key,
    required this.expendList,
  });

  final List<ExpendModel> expendList;

  @override
  State<ExpendHistory> createState() => _ExpendHistoryState();
}

class _ExpendHistoryState extends State<ExpendHistory> {
  final ScrollController _scrollController = ScrollController();
  int pageSize = 5;
  int pageNumber = 2;

  @override
  void initState() {
    _scrollController.addListener(() {
      int offset = (pageNumber - 1) * pageSize;
      if (_scrollController.position.pixels ==
              _scrollController.position.maxScrollExtent &&
          offset <= widget.expendList.length) {
        setState(() {
          pageNumber++;
        });
      }
    });
    super.initState();
  }

  List<ExpendModel> subExpendList(int currentPage) {
    int offset = (currentPage - 1) * pageSize;
    return (widget.expendList.length < pageSize ||
            offset > widget.expendList.length)
        ? widget.expendList
        : widget.expendList.sublist(0, offset);
  }

  @override
  Widget build(BuildContext context) {
    List<ExpendModel> expendListSub = subExpendList(pageNumber);
    return ListView.builder(
        itemCount: expendListSub.length,
        controller: _scrollController,
        itemBuilder: (context, index) => InkWell(
              onTap: () {
                ExpendModel expendSelected = expendListSub[index];
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
                          base64String:
                              expendListSub[index].category?.icon?.image,
                          width: 40,
                        )),
                    const SizedBox(width: 16.0),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(expendListSub[index].category?.name ?? "",
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                              style: const TextStyle(
                                  fontSize: 15, fontWeight: FontWeight.bold)),
                          Text(
                              "${displayDate(expendListSub[index].dateTime?.toUtc())} - ${formatDateTime(expendListSub[index].dateTime!)}",
                              style: const TextStyle(
                                  fontSize: 12, color: Colors.black54)),
                          Text(
                              "Tài khoản: ${expendListSub[index].account?.accountName ?? ""}",
                              style: const TextStyle(
                                  fontSize: 12, color: Colors.black87))
                        ],
                      ),
                    ),
                    const SizedBox(width: 8),
                    Text(
                      formatCurrency(expendListSub[index].amount, true),
                      style: TextStyle(
                          fontSize: 16,
                          color: expendListSub[index].transactionType ==
                                  TransactionType.income.toString()
                              ? Colors.green[400]
                              : Colors.red[400]),
                    )
                  ],
                ),
              ),
            ));
  }
}
