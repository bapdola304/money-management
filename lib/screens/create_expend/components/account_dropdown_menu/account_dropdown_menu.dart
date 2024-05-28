import 'package:flutter/material.dart';
import 'package:money_management/model/account.dart';
import 'package:money_management/provider/account_provider.dart';
import 'package:money_management/screens/accounts/components/TypeSelect.dart';
import 'package:money_management/screens/create_expend/components/account_dropdown_menu/account_menu_item.dart';
import 'package:mirai_dropdown_menu/mirai_dropdown_menu.dart';
import 'package:money_management/storage/locator.dart';
import 'package:money_management/storage/user_storage.dart';
import 'package:provider/provider.dart';

class AccountDropdownMenu extends StatefulWidget {
  final Function(Account account) onChanged;
  final ValueNotifier<Account> account;
  const AccountDropdownMenu(
      {super.key, required this.onChanged, required this.account});

  @override
  State<AccountDropdownMenu> createState() => _AccountDropdownMenuState();
}

class _AccountDropdownMenuState extends State<AccountDropdownMenu> {
  final sharedPrefService = serviceLocator<UserStorage>();
  @override
  void initState() {
    super.initState();
    if (context.read<AccountProvider>().accounts.isNotEmpty) return;
    final userId = sharedPrefService.getUserId() ?? "";
    Future.delayed(Duration.zero, () async {
      context.read<AccountProvider>().getAllAccounts(userId);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<AccountProvider>(
      builder: (context, accountProvider, child) => MiraiDropDownMenu<Account>(
        key: UniqueKey(),
        children: accountProvider.accounts,
        valueNotifier: widget.account,
        // showSearchTextField: true,
        selectedItemBackgroundColor: Colors.green,
        itemPadding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
        itemWidgetBuilder: (
          int index,
          Account? account, {
          bool isItemSelected = true,
        }) {
          return AccountMenuItem(
            account: account,
            isItemSelected: isItemSelected,
          );
        },
        onChanged: widget.onChanged,
        child: ValueListenableBuilder<Account>(
            key: GlobalKey(),
            valueListenable: widget.account,
            builder: (_, Account accountItem, __) {
              return TypeSelect(
                  icon: Image.asset(
                    'assets/icons/wallet.png',
                    width: 40,
                  ),
                  text: accountItem.accountName);
            }),
      ),
    );
  }
}
