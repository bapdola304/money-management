import 'package:flutter/material.dart';

class TextFieldCustom extends StatelessWidget {
  final String? hintText;
  final Image? icon;
  final TextEditingController? controller;
  final FocusNode? focusNode;
  const TextFieldCustom(
      {super.key, this.hintText, this.icon, this.controller, this.focusNode});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
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
            child: icon),
        const SizedBox(width: 8),
        Expanded(
          child: TextField(
            controller: controller,
            focusNode: focusNode,
            textCapitalization: TextCapitalization.words,
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.w400),
            decoration: InputDecoration(
                enabledBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.grey.withOpacity(0.5)),
                ),
                border: UnderlineInputBorder(),
                contentPadding: EdgeInsets.symmetric(vertical: 0),
                hintText: hintText,
                hintStyle: TextStyle(color: Colors.black38)),
          ),
        ),
      ],
    );
  }
}
