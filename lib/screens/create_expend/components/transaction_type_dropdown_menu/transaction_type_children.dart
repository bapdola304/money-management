import 'package:flutter/material.dart';

class TransactionTypeChildren extends StatelessWidget {
  const TransactionTypeChildren({super.key, required this.name});
  final String name;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(5),
      width: 160,
      decoration: BoxDecoration(
          color: Colors.white.withOpacity(0.2),
          borderRadius: BorderRadius.circular(15)),
      child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
        Text(
          name,
          style: const TextStyle(
              fontSize: 18, fontWeight: FontWeight.w500, color: Colors.white),
        ),
        const Icon(Icons.arrow_drop_down, color: Colors.white)
      ]),
    );
  }
}
