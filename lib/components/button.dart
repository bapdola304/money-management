import 'package:flutter/material.dart';

class Button extends StatelessWidget {
  final Function()? onButtonPressed;
  final Color? bgColor;
  final String textButton;
  final Color? textColor;
  final double? width;
  final double? padding;
  final bool? isLoading;
  final Color? borderColor;

  const Button(
      {Key? key,
      required this.textButton,
      this.bgColor,
      this.textColor = Colors.white,
      this.onButtonPressed,
      this.padding = 12,
      this.width,
      this.isLoading,
      this.borderColor})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    return SizedBox(
      width: width ?? screenWidth,
      height: 48,
      child: ElevatedButton(
          onPressed: () {
            if (onButtonPressed != null) onButtonPressed!();
          },
          style: ElevatedButton.styleFrom(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15),
                side: BorderSide(
                    color: borderColor ?? bgColor ?? Colors.transparent),
              ),
              backgroundColor: bgColor),
          child: Padding(
            padding: const EdgeInsets.all(10),
            child: Text(
              textButton,
              style: TextStyle(fontSize: 17, color: textColor),
            ),
          )),
    );
  }
}
