import 'package:flutter/material.dart';
import 'package:money_management/model/account.dart';
import 'package:money_management/utils/currence_format.dart';

class AccountList extends StatelessWidget {
  final Function(Account account)? onActionsPressed;
  final Function(Account account)? onItemClicked;
  final List<Account> accountList;
  const AccountList(
      {super.key,
      this.onActionsPressed,
      this.onItemClicked,
      required this.accountList});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: accountList.length,
      itemBuilder: (context, index) => InkWell(
        onTap: () => onItemClicked!(accountList[index]),
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
                  width: 40,
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
                            fontSize: 16, fontWeight: FontWeight.bold)),
                    Text(
                        formatCurrency(accountList[index].accountBalance, true),
                        style: const TextStyle(
                            fontSize: 14, color: Colors.black87))
                  ],
                ),
              ),
              const SizedBox(width: 8),
              IconButton(
                  onPressed: () => onActionsPressed!(accountList[index]),
                  icon: const Icon(Icons.more_vert, color: Colors.black)),
            ],
          ),
        ),
      ),
    );
  }
}
