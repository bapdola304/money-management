import 'package:flutter/material.dart';
import 'package:money_management/data/data.dart';

class TransactionTypeItem extends StatelessWidget {
  const TransactionTypeItem({
    super.key,
    required this.item,
  });

  final TransactionTypeSelect? item;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(children: [
        Image.asset(
          item!.icon,
          width: 30,
        ),
        const SizedBox(width: 10),
        Text(
          item!.name,
          style: TextStyle(fontSize: 16, color: Colors.black),
        )
      ]),
    );
  }
}
