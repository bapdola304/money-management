import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class TextFieldCustom extends StatelessWidget {
  final String? hintText;
  final Image? icon;
  final TextEditingController? controller;
  final FocusNode? focusNode;
  final String? Function(String?)? validator;
  const TextFieldCustom(
      {super.key,
      this.hintText,
      this.icon,
      this.controller,
      this.focusNode,
      this.validator});

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
          child: TextFormField(
            controller: controller,
            inputFormatters: [CapitalizeFirstWordOnlyInputFormatter()],
            focusNode: focusNode,
            autovalidateMode: AutovalidateMode.onUserInteraction,
            validator: validator,
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

class CapitalizeFirstWordOnlyInputFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue oldValue,
    TextEditingValue newValue,
  ) {
    if (newValue.text.isEmpty) {
      return newValue;
    }

    String text = newValue.text;
    String formattedText;

    // Viết hoa chữ cái đầu tiên và giữ các từ còn lại ở dạng chữ thường
    formattedText = text[0].toUpperCase() + text.substring(1).toLowerCase();

    return newValue.copyWith(
      text: formattedText,
      selection: newValue.selection,
    );
  }
}
