import 'package:flutter/material.dart';
import 'package:money_management/screens/accounts/components/expend_category_list.dart';
import 'package:money_management/utils/currence_format.dart';
import 'package:money_management/utils/data_utils.dart';
import 'package:money_management/utils/date_format.dart';

class ExpendDateList extends StatelessWidget {
  const ExpendDateList(
      {Key? key, required this.expendListGroupByDate, required this.accountId})
      : super(key: key);
  final List<Map<String, dynamic>> expendListGroupByDate;
  final String accountId;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: expendListGroupByDate.length,
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
                                expendListGroupByDate[index]['date']['day'],
                                style: const TextStyle(
                                    fontSize: 30, fontWeight: FontWeight.w600),
                              ),
                              const SizedBox(width: 16),
                              Column(
                                children: [
                                  Text(
                                    displayDate(
                                        expendListGroupByDate[index]['date']),
                                    style: const TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.w500),
                                  ),
                                  Text(
                                    expendListGroupByDate[index]['date']
                                        ['month_year'],
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
                              !isEmptyData(expendListGroupByDate[index]
                                      ['totalIncome'])
                                  ? Text(
                                      formatCurrency(
                                          expendListGroupByDate[index]
                                              ['totalIncome'],
                                          true),
                                      style: TextStyle(
                                          fontSize: 20,
                                          color: Colors.green[400]),
                                    )
                                  : Container(),
                              !isEmptyData(expendListGroupByDate[index]
                                      ['totalExpense'])
                                  ? Text(
                                      formatCurrency(
                                          expendListGroupByDate[index]
                                              ['totalExpense'],
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
            accountId: accountId,
            expendListGroupByCategory: expendListGroupByDate[index]['items'],
            onItemClicked: () {},
          )
        ]),
      ),
    );
  }
}
