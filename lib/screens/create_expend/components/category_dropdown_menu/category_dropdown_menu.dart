import 'package:flutter/material.dart';
import 'package:money_management/components/base64_image_widget.dart';
import 'package:money_management/data/data.dart';
import 'package:money_management/model/category.dart';
import 'package:money_management/provider/category_provider.dart';
import 'package:money_management/screens/accounts/components/TypeSelect.dart';
import 'package:money_management/screens/create_expend/components/category_dropdown_menu/item.dart';
import 'package:mirai_dropdown_menu/mirai_dropdown_menu.dart';
import 'package:provider/provider.dart';

class CategoryDropdownMenu extends StatefulWidget {
  final Function(CategoryModel category) onChanged;
  final ValueNotifier<CategoryModel> category;
  const CategoryDropdownMenu(
      {super.key,
      required this.onChanged,
      required this.category,
      this.transactionTypeSelect});
  final TransactionTypeSelect? transactionTypeSelect;

  @override
  State<CategoryDropdownMenu> createState() => _CategoryDropdownMenuState();
}

class _CategoryDropdownMenuState extends State<CategoryDropdownMenu> {
  @override
  void initState() {
    super.initState();
    if (context.read<CategoryProvider>().categoryList.isNotEmpty) return;
    Future.delayed(Duration.zero, () async {
      context.read<CategoryProvider>().getCategoryList();
    });
  }

  List<CategoryModel> getCategoryListByTransactionType(
      List<CategoryModel> categoryList) {
    return categoryList
        .where((item) =>
            item.transactionType == widget.transactionTypeSelect!.value)
        .toList();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<CategoryProvider>(
      builder: (context, categoryProvider, child) =>
          MiraiDropDownMenu<CategoryModel>(
        key: UniqueKey(),
        children:
            getCategoryListByTransactionType(categoryProvider.categoryList),
        valueNotifier: widget.category,
        // showSearchTextField: true,
        selectedItemBackgroundColor: Colors.green,
        itemPadding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
        itemWidgetBuilder: (
          int index,
          CategoryModel? category, {
          bool isItemSelected = true,
        }) {
          return DropDownItemWidget(
            category: category,
            isItemSelected: isItemSelected,
          );
        },
        onChanged: widget.onChanged,
        child: ValueListenableBuilder<CategoryModel>(
            key: GlobalKey(),
            valueListenable: widget.category,
            builder: (_, CategoryModel categoryItem, __) {
              return TypeSelect(
                  emptyText: 'Chọn hạng mục',
                  icon: Base64ImageWidget(
                    base64String: categoryItem.icon?.image,
                    width: 40,
                  ),
                  text: categoryItem.name);
            }),
      ),
    );
  }
}
