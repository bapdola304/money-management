import 'package:flutter/material.dart';
import 'package:money_management/screens/accounts/components/expend_category_list.dart';
import 'package:money_management/utils/currence_format.dart';
import 'package:money_management/utils/data_utils.dart';
import 'package:money_management/utils/date_format.dart';

class ExpendDateList extends StatefulWidget {
  const ExpendDateList(
      {super.key,
      required this.expendListGroupByDate,
      required this.accountId});
  final List<Map<String, dynamic>> expendListGroupByDate;
  final String accountId;

  @override
  State<ExpendDateList> createState() => _ExpendDateListState();
}

class _ExpendDateListState extends State<ExpendDateList> {
  final ScrollController _scrollController = ScrollController();
  int pageSize = 5;
  int pageNumber = 2;

  @override
  void initState() {
    _scrollController.addListener(() {
      int offset = (pageNumber - 1) * pageSize;
      if (_scrollController.position.pixels ==
              _scrollController.position.maxScrollExtent &&
          offset <= widget.expendListGroupByDate.length) {
        setState(() {
          pageNumber++;
        });
      }
    });
    super.initState();
  }

  List<Map<String, dynamic>> subExpendList(int currentPage) {
    int offset = (currentPage - 1) * pageSize;
    return (widget.expendListGroupByDate.length < pageSize ||
            offset > widget.expendListGroupByDate.length)
        ? widget.expendListGroupByDate
        : widget.expendListGroupByDate.sublist(0, offset);
  }

  @override
  Widget build(BuildContext context) {
    List<Map<String, dynamic>> expendListSub = subExpendList(pageNumber);
    return ListView.builder(
      itemCount: expendListSub.length,
      controller: _scrollController,
      shrinkWrap: true,
      itemBuilder: (context, index) => Container(
        margin: const EdgeInsets.only(top: 10),
        color: Colors.white,
        child: Column(children: [
          Row(
            children: [
              Container(
                width: 6,
                height: 70,
                decoration: const BoxDecoration(
                  color: Colors.green,
                ),
              ),
              Expanded(
                child: Container(
                  padding: const EdgeInsets.only(left: 16, right: 16, top: 10),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              Text(
                                expendListSub[index]['date']['day'],
                                style: const TextStyle(
                                    fontSize: 30, fontWeight: FontWeight.w600),
                              ),
                              const SizedBox(width: 16),
                              Column(
                                children: [
                                  Text(
                                    displayDate(expendListSub[index]['date']),
                                    style: const TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.w500),
                                  ),
                                  Text(
                                    expendListSub[index]['date']['month_year'],
                                    style: const TextStyle(
                                        fontSize: 16, color: Colors.black54),
                                  )
                                ],
                              ),
                            ],
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              !isEmptyData(expendListSub[index]['totalIncome'])
                                  ? Text(
                                      formatCurrency(
                                          expendListSub[index]['totalIncome'],
                                          true),
                                      style: TextStyle(
                                          fontSize: 20,
                                          color: Colors.green[400]),
                                    )
                                  : Container(),
                              !isEmptyData(expendListSub[index]['totalExpense'])
                                  ? Text(
                                      formatCurrency(
                                          expendListSub[index]['totalExpense'],
                                          true),
                                      style: TextStyle(
                                          fontSize: 20, color: Colors.red[400]),
                                    )
                                  : Container()
                            ],
                          )
                        ],
                      ),
                      const SizedBox(height: 10),
                      Container(
                        height: 1,
                        // width: 50,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5),
                          color: Colors.grey,
                        ),
                      )
                    ],
                  ),
                ),
              )
            ],
          ),
          ExpendCategoryList(
            accountId: widget.accountId,
            expendListGroupByCategory: expendListSub[index]['items'],
          )
        ]),
      ),
    );
  }
}
