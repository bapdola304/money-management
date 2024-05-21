import 'package:flutter/material.dart';
import 'package:money_management/components/base64_image_widget.dart';

class DropDownIconChildWidget extends StatelessWidget {
  const DropDownIconChildWidget({
    super.key,
    this.icon,
  });

  final String? icon;

  @override
  Widget build(BuildContext context) {
    bool isIconSelected = (icon?.isNotEmpty ?? false);
    return Row(
      children: [
        isIconSelected
            ? Base64ImageWidget(base64String: icon, width: 60)
            : Image.asset('assets/icons/empty_icon.png', width: 60),
        const SizedBox(width: 10),
        Text(
          isIconSelected ? 'Thay đổi biểu tượng' : 'Chọn biểu tượng',
          style: const TextStyle(
              fontSize: 18, fontWeight: FontWeight.w400, color: Colors.black38),
        )
      ],
    );
  }
}
