import 'package:flutter/material.dart';
import 'package:money_management/components/base64_image_widget.dart';
import 'package:money_management/model/icon.dart';

class DropDownIconItemWidget extends StatelessWidget {
  const DropDownIconItemWidget({
    super.key,
    required this.icon,
    required this.isItemSelected,
    this.firstSpace = 30,
    this.padding,
    this.fontSize,
  });

  final IconModel? icon;
  final bool isItemSelected;
  final double firstSpace;
  final EdgeInsetsGeometry? padding;
  final double? fontSize;

  @override
  Widget build(BuildContext context) {
    return Base64ImageWidget(base64String: icon?.image);
  }
}
