/*
* Created By Mirai Devs.
* On 24/6/2022.
*/
import 'package:flutter/material.dart';
import 'package:money_management/data/data.dart';

class DropDownItemWidget extends StatelessWidget {
  const DropDownItemWidget({
    super.key,
    required this.category,
    required this.isItemSelected,
    this.firstSpace = 30,
    this.padding,
    this.fontSize,
  });

  final CategoryModel? category;
  final bool isItemSelected;
  final double firstSpace;
  final EdgeInsetsGeometry? padding;
  final double? fontSize;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(children: [
        Image.asset(category?.icon ?? '', width: 40),
        const SizedBox(width: 10),
        Text(
          category?.name ?? '',
          style: TextStyle(
              fontSize: 16,
              color: isItemSelected ? Colors.white : Colors.black),
        )
      ]),
    );
  }
}
