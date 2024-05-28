import 'package:flutter/material.dart';
import 'package:money_management/data/data.dart';
import 'package:mirai_dropdown_menu/mirai_dropdown_menu.dart';
import 'package:money_management/screens/create_expend/components/transaction_type_dropdown_menu/transaction_type_children.dart';
import 'package:money_management/screens/create_expend/components/transaction_type_dropdown_menu/transaction_type_item.dart';

class TransactionTypeDropdownMenu extends StatefulWidget {
  final Function(TransactionTypeSelect category) onChanged;
  final ValueNotifier<TransactionTypeSelect> transactionTypeSelected;
  const TransactionTypeDropdownMenu(
      {super.key,
      required this.onChanged,
      required this.transactionTypeSelected});

  @override
  State<TransactionTypeDropdownMenu> createState() =>
      _TransactionTypeDropdownMenuState();
}

class _TransactionTypeDropdownMenuState
    extends State<TransactionTypeDropdownMenu> {
  @override
  Widget build(BuildContext context) {
    return MiraiDropDownMenu<TransactionTypeSelect>(
      key: UniqueKey(),
      children: transactionTypeList,
      valueNotifier: widget.transactionTypeSelected,
      selectedItemBackgroundColor: Colors.green.withOpacity(0.3),
      itemPadding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
      itemWidgetBuilder: (
        int index,
        TransactionTypeSelect? transactionType, {
        bool isItemSelected = true,
      }) {
        return TransactionTypeItem(
          item: transactionType,
        );
      },
      onChanged: widget.onChanged,
      child: ValueListenableBuilder<TransactionTypeSelect>(
          key: GlobalKey(),
          valueListenable: widget.transactionTypeSelected,
          builder: (_, TransactionTypeSelect transactionType, __) {
            return TransactionTypeChildren(name: transactionType.name);
          }),
    );
  }
}
