import 'package:flutter/material.dart';
import 'package:money_management/components/base64_image_widget.dart';
import 'package:money_management/model/category.dart';

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
        Base64ImageWidget(
          base64String: category?.icon?.image,
          width: 40,
        ),
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
