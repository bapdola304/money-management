import 'package:flutter/material.dart';
import 'package:money_management/model/account.dart';

class AccountMenuItem extends StatelessWidget {
  const AccountMenuItem({
    super.key,
    required this.account,
    required this.isItemSelected,
  });

  final Account? account;
  final bool isItemSelected;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(children: [
        Image.asset(
          'assets/icons/wallet.png',
          width: 50,
        ),
        const SizedBox(width: 10),
        Text(
          account?.accountName ?? '',
          style: TextStyle(
              fontSize: 16,
              color: isItemSelected ? Colors.white : Colors.black),
        )
      ]),
    );
  }
}
