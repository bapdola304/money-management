import 'package:flutter/material.dart';

class TypeSelect extends StatelessWidget {
  final String? text;
  final Image? icon;
  const TypeSelect({super.key, this.text = "", this.icon});

  @override
  Widget build(BuildContext context) {
    return Row(
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
          child: icon,
        ),
        const SizedBox(width: 8),
        Expanded(
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    text ?? "",
                    style: TextStyle(fontSize: 18),
                  ),
                  Icon(Icons.keyboard_arrow_right_rounded)
                ],
              ),
              const SizedBox(height: 12),
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
      ],
    );
  }
}
