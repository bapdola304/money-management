import 'package:flutter/material.dart';

class TransactionTypeChildren extends StatelessWidget {
  const TransactionTypeChildren({super.key, required this.name});
  final String name;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(5),
      width: 160,
      decoration: BoxDecoration(
          color: Colors.white.withOpacity(0.2),
          borderRadius: BorderRadius.circular(15)),
      child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
        Text(
          name,
          style: TextStyle(
              fontSize: 18, fontWeight: FontWeight.w500, color: Colors.white),
        ),
        Icon(Icons.arrow_drop_down, color: Colors.white)
      ]),
    );
  }
}
