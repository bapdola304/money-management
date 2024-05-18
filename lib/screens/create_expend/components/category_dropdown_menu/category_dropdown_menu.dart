import 'package:flutter/material.dart';
import 'package:money_management/data/data.dart';
import 'package:money_management/screens/accounts/components/TypeSelect.dart';
import 'package:money_management/screens/create_expend/components/category_dropdown_menu/children.dart';
import 'package:money_management/screens/create_expend/components/category_dropdown_menu/item.dart';
import 'package:mirai_dropdown_menu/mirai_dropdown_menu.dart';

class CategoryDropdownMenu extends StatelessWidget {
  final List<CategoryModel> categoryList;
  final Function(CategoryModel category) onChanged;
  final ValueNotifier<CategoryModel> category;
  const CategoryDropdownMenu(
      {super.key,
      required this.categoryList,
      required this.onChanged,
      required this.category});

  @override
  Widget build(BuildContext context) {
    return MiraiDropDownMenu<CategoryModel>(
      key: UniqueKey(),
      children: categoryList,
      valueNotifier: category,
      showSearchTextField: true,
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
      onChanged: onChanged,
      child: ValueListenableBuilder<CategoryModel>(
          key: GlobalKey(),
          valueListenable: category,
          builder: (_, CategoryModel categoryItem, __) {
            return TypeSelect(
                icon: Image.asset(categoryItem.icon, width: 35),
                text: categoryItem.name);
          }),
    );
  }
}
