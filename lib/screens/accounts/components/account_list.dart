import 'package:flutter/material.dart';
import 'package:money_management/utils/currence_format.dart';

class AccountList extends StatelessWidget {
  final Function()? onActionsPressed;
  final Function()? onItemClicked;
  const AccountList({super.key, this.onActionsPressed, this.onItemClicked});

  @override
  Widget build(BuildContext context) {
    String formattedValue = formatCurrency("50000000");
    return ListView.builder(
      itemCount: 10,
      itemBuilder: (context, index) => InkWell(
        onTap: onItemClicked,
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
                    const Text('Dòng text thứ nhất có rất nhiều chữ',
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                            fontSize: 15, fontWeight: FontWeight.bold)),
                    Text('-$formattedValue ₫',
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
