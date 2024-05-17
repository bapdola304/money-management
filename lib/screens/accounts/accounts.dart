import 'package:flutter/material.dart';
import 'package:money_management/screens/accounts/components/account_bottom_sheet.dart';
import 'package:money_management/screens/accounts/components/account_list.dart';
import 'package:money_management/screens/accounts/create_account.dart';
import 'package:money_management/screens/accounts/expend.dart';

class Accounts extends StatefulWidget {
  const Accounts({Key? key}) : super(key: key);

  @override
  _AccountsState createState() => _AccountsState();
}

class _AccountsState extends State<Accounts> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.green,
          leading: IconButton(
              onPressed: () {},
              icon: const Icon(Icons.search_rounded, color: Colors.white)),
          title: const Text(
            'Tài khoản',
            style: TextStyle(
                color: Colors.white, fontWeight: FontWeight.w600, fontSize: 18),
          ),
          centerTitle: true,
        ),
        body: Container(
          color: const Color(0xFFefeff2),
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Expanded(
            child: AccountList(
                onItemClicked: () => Navigator.of(context, rootNavigator: true)
                        .push(MaterialPageRoute(
                      builder: (context) => const Expend(),
                    )),
                onActionsPressed: () => onActionsPressed(context)),
          ),
        ),
        floatingActionButton: FloatingActionButton(
          heroTag: "btn1",
          backgroundColor: Colors.green,
          elevation: 0,
          onPressed: () {
            Navigator.of(context, rootNavigator: true).push(
              MaterialPageRoute(
                builder: (context) => const CreateAccount(),
              ),
            );
          },
          shape: RoundedRectangleBorder(
            side: const BorderSide(width: 3, color: Colors.green),
            borderRadius: BorderRadius.circular(100),
          ),
          child: const Icon(
            Icons.add,
            color: Colors.white,
          ),
        ),
      ),
    );
  }

  onActionsPressed(BuildContext context) {
    showModalBottomSheet(
        context: context,
        useRootNavigator: true,
        builder: (context) =>
            AccountBottomSheet(onDeletePressed: () {}, onEditPressed: () {}));
  }
}
