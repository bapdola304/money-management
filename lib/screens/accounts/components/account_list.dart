import 'package:flutter/material.dart';
import 'package:money_management/model/account.dart';
import 'package:money_management/utils/currence_format.dart';

class AccountList extends StatelessWidget {
  final Function()? onActionsPressed;
  final Function(String? accountId)? onItemClicked;
  final List<Account> accountList;
  const AccountList(
      {super.key,
      this.onActionsPressed,
      this.onItemClicked,
      required this.accountList});

  String formatCurrencyData(int value) {
    String formattedValue = formatCurrency(value.toString());
    return '-$formattedValue ₫';
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: accountList.length,
      itemBuilder: (context, index) => InkWell(
        onTap: () => onItemClicked!(accountList[index].id),
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 8),
          margin: const EdgeInsets.only(top: 10),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(20),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                child: Image.asset(
                  'assets/icons/wallet.png',
                  width: 50,
                ),
              ),
              const SizedBox(width: 16.0),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(accountList[index].accountName,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                            fontSize: 15, fontWeight: FontWeight.bold)),
                    Text(
                        formatCurrencyData(
                            accountList[index].accountBalance ?? 0),
                        style: const TextStyle(fontSize: 14, color: Colors.red))
                  ],
                ),
              ),
              const SizedBox(width: 8),
              IconButton(
                  onPressed: onActionsPressed,
                  icon: const Icon(Icons.more_vert, color: Colors.black)),
            ],
          ),
        ),
      ),
    );
  }
}
