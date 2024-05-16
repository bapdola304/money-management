import 'package:flutter/material.dart';

class AccountList extends StatelessWidget {
  final Function()? onActionsPressed;
  const AccountList({super.key, this.onActionsPressed});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: 10,
      itemBuilder: (context, index) => Container(
        padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 8),
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
                    offset: Offset(0, 2),
                  ),
                ],
              ),
              child: Image.asset(
                'assets/icons/wallet.png',
                width: 50,
              ),
            ),
            const SizedBox(width: 16.0),
            const Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Dòng text thứ nhất có rất nhiều chữ',
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                  Text('Tháng 1, 2022, 10:00 AM',
                      style: TextStyle(fontSize: 12, color: Colors.black54))
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
    );
  }
}
