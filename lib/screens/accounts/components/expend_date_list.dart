import 'package:flutter/material.dart';
import 'package:money_management/screens/accounts/components/expend_category_list.dart';

class ExpendDateList extends StatelessWidget {
  const ExpendDateList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: 2,
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
                          const Row(
                            children: [
                              Text(
                                '17',
                                style: TextStyle(
                                    fontSize: 30, fontWeight: FontWeight.w600),
                              ),
                              SizedBox(width: 16),
                              Column(
                                children: [
                                  Text(
                                    'Hôm nay',
                                    style: TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.w500),
                                  ),
                                  Text(
                                    '05/2024',
                                    style: TextStyle(
                                        fontSize: 16, color: Colors.black54),
                                  )
                                ],
                              ),
                            ],
                          ),
                          Text(
                            '5.000.000 đ',
                            style:
                                TextStyle(fontSize: 20, color: Colors.red[400]),
                          )
                        ],
                      ),
                      SizedBox(height: 10),
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
            onItemClicked: () {},
          )
        ]),
      ),
    );
  }
}
