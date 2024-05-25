import 'package:flutter/material.dart';
import 'package:money_management/utils/currence_format.dart';
import 'package:flutter/services.dart';

class CurrencyInput extends StatefulWidget {
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
  State<CurrencyInput> createState() => _CurrencyInputState();
}

class _CurrencyInputState extends State<CurrencyInput> {
  final FocusNode _focusNode = FocusNode();

  @override
  void initState() {
    super.initState();
    _focusNode.addListener(() {
      if (_focusNode.hasFocus) {
        // Move cursor to the beginning
        setState(() {
          widget._controller?.selection = TextSelection.fromPosition(
            TextPosition(offset: 1),
          );
        });
      }
    });
  }

  @override
  void dispose() {
    _focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Column(crossAxisAlignment: CrossAxisAlignment.end, children: [
      Text(widget.text),
      Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          SizedBox(
            width: size.width * 0.7,
            child: TextField(
                controller: widget._controller,
                focusNode: _focusNode,
                style: TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                    color: widget.numberColor),
                textAlign: TextAlign.end,
                decoration: const InputDecoration(
                  border: UnderlineInputBorder(),
                  contentPadding: EdgeInsets.symmetric(vertical: 0),
                ),
                keyboardType: TextInputType.number,
                inputFormatters: [
                  FilteringTextInputFormatter.digitsOnly,
                  new LengthLimitingTextInputFormatter(13),
                ],
                onChanged: (value) {
                  String formattedValue = formatCurrency(value);
                  widget._controller?.value = TextEditingValue(
                    text: formattedValue,
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
