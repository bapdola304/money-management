import 'package:flutter/material.dart';
import 'package:money_management/model/account.dart';
import 'package:money_management/utils/currence_format.dart';

class AccountList extends StatefulWidget {
  final Function(Account account)? onActionsPressed;
  final Function(Account account)? onItemClicked;
  final List<Account> accountList;
  const AccountList(
      {super.key,
      this.onActionsPressed,
      this.onItemClicked,
      required this.accountList});

  @override
  State<AccountList> createState() => _AccountListState();
}

class _AccountListState extends State<AccountList> {
  final ScrollController _scrollController = ScrollController();
  int pageSize = 10;
  int pageNumber = 2;

  @override
  void initState() {
    _scrollController.addListener(() {
      int offset = (pageNumber - 1) * pageSize;
      if (_scrollController.position.pixels ==
              _scrollController.position.maxScrollExtent &&
          offset <= widget.accountList.length) {
        setState(() {
          pageNumber++;
        });
      }
    });
    super.initState();
  }

  List<Account> subAccountList(int currentPage) {
    int offset = (currentPage - 1) * pageSize;
    return (widget.accountList.length < pageSize ||
            offset > widget.accountList.length)
        ? widget.accountList
        : widget.accountList.sublist(0, offset);
  }

  @override
  Widget build(BuildContext context) {
    List<Account> accountListSub = subAccountList(pageNumber);
    return ListView.builder(
      itemCount: accountListSub.length,
      controller: _scrollController,
      itemBuilder: (context, index) => InkWell(
        onTap: () => widget.onItemClicked!(accountListSub[index]),
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
                    Text(accountListSub[index].accountName,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                            fontSize: 16, fontWeight: FontWeight.bold)),
                    Text(
                        formatCurrency(
                            accountListSub[index].accountBalance, true),
                        style: const TextStyle(
                            fontSize: 14, color: Colors.black87))
                  ],
                ),
              ),
              const SizedBox(width: 8),
              IconButton(
                  onPressed: () =>
                      widget.onActionsPressed!(accountListSub[index]),
                  icon: const Icon(Icons.more_vert, color: Colors.black)),
            ],
          ),
        ),
      ),
    );
  }
}
