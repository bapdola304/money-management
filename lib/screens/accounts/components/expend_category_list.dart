import 'package:flutter/material.dart';

class ExpendCategoryList extends StatelessWidget {
  final Function()? onItemClicked;
  const ExpendCategoryList({Key? key, this.onItemClicked}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: 2,
      shrinkWrap: true,
      itemBuilder: (context, index) => Material(
        color: Colors.white,
        child: InkWell(
          onTap: onItemClicked,
          child: Container(
            margin:
                const EdgeInsets.only(left: 40, top: 10, bottom: 15, right: 14),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Image.asset(
                  'assets/icons/wallet.png',
                  width: 30,
                ),
                const SizedBox(width: 8),
                const Expanded(
                  child: Text('Dịch vụ sinh hoạt',
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.w600)),
                ),
                const SizedBox(width: 8),
                Text(
                  '5.000.000 đ',
                  style: TextStyle(fontSize: 18, color: Colors.red[400]),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
