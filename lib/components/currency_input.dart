import 'package:flutter/material.dart';
import 'package:money_management/utils/currence_format.dart';
import 'package:flutter/services.dart';

class CurrencyInput extends StatelessWidget {
  const CurrencyInput(
      {super.key,
      TextEditingController? controller,
      required this.text,
      this.numberColor = Colors.red})
      : _controller = controller;

  final TextEditingController? _controller;
  final String text;
  final MaterialColor? numberColor;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Column(crossAxisAlignment: CrossAxisAlignment.end, children: [
      const Text('Số tiền'),
      Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          SizedBox(
            width: size.width * 0.7,
            child: TextField(
                controller: _controller,
                style: TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                    color: numberColor),
                textAlign: TextAlign.right,
                decoration: const InputDecoration(
                  border: UnderlineInputBorder(),
                  contentPadding: EdgeInsets.symmetric(vertical: 0),
                ),
                keyboardType: TextInputType.number,
                inputFormatters: [
                  FilteringTextInputFormatter.digitsOnly,
                ],
                onChanged: (value) {
                  String formattedValue = formatCurrency(value);
                  _controller?.value = TextEditingValue(
                    text: formattedValue,
                    selection:
                        TextSelection.collapsed(offset: formattedValue.length),
                  );
                }),
          ),
          const SizedBox(width: 8),
          const Text(
            '₫',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
          )
        ],
      ),
    ]);
  }
}
