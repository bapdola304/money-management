import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:money_management/components/button.dart';

showDialogConfirm(
    BuildContext context, String? content, Function()? onConfirm) {
  double screenWidth = MediaQuery.of(context).size.width;
  showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          backgroundColor: Colors.white,
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(
              Radius.circular(
                20.0,
              ),
            ),
          ),
          contentPadding: const EdgeInsets.only(
            top: 10.0,
          ),
          content: Container(
            height: 220,
            padding: const EdgeInsets.only(bottom: 10, left: 10, right: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const SizedBox(height: 10),
                SvgPicture.asset(
                  'assets/icons/delete_confirm.svg',
                  width: 120,
                ),
                const SizedBox(height: 10),
                Expanded(
                    child: Text(content!,
                        style: const TextStyle(
                            fontSize: 16, fontWeight: FontWeight.w500))),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Button(
                      width: screenWidth * 0.34,
                      textButton: 'Hủy',
                      bgColor: Colors.white,
                      borderColor: Colors.green,
                      textColor: Colors.black87,
                      onButtonPressed: () => Navigator.pop(context),
                    ),
                    Button(
                      width: screenWidth * 0.34,
                      textButton: 'Đồng ý',
                      bgColor: Colors.green,
                      onButtonPressed: onConfirm,
                    )
                  ],
                )
              ],
            ),
          ),
        );
      });
}
