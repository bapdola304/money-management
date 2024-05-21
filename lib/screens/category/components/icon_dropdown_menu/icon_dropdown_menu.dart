import 'package:flutter/material.dart';
import 'package:money_management/model/icon.dart';
import 'package:money_management/provider/category_provider.dart';
import 'package:money_management/screens/category/components/icon_dropdown_menu/icon_chidren.dart';
import 'package:money_management/screens/category/components/icon_dropdown_menu/icon_item.dart';
import 'package:mirai_dropdown_menu/mirai_dropdown_menu.dart';
import 'package:provider/provider.dart';

class IconDropdownMenu extends StatefulWidget {
  final Function(IconModel icon) onChanged;
  final ValueNotifier<IconModel> icon;
  const IconDropdownMenu(
      {super.key, required this.onChanged, required this.icon});

  @override
  State<IconDropdownMenu> createState() => _IconDropdownMenuState();
}

class _IconDropdownMenuState extends State<IconDropdownMenu> {
  @override
  void initState() {
    super.initState();
    List<IconModel> iconList = context.read<CategoryProvider>().icons;
    if (iconList.isEmpty) {
      context.read<CategoryProvider>().getIcons();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<CategoryProvider>(
      builder: (context, categoryData, child) => MiraiDropDownMenu<IconModel>(
        key: UniqueKey(),
        children: categoryData.icons,
        valueNotifier: widget.icon,
        selectedItemBackgroundColor: Colors.green,
        itemPadding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
        itemWidgetBuilder: (
          int index,
          IconModel? icon, {
          bool isItemSelected = true,
        }) {
          return DropDownIconItemWidget(
            icon: icon,
            isItemSelected: isItemSelected,
          );
        },
        onChanged: widget.onChanged,
        child: ValueListenableBuilder<IconModel>(
            key: GlobalKey(),
            valueListenable: widget.icon,
            builder: (_, IconModel icon, __) {
              return DropDownIconChildWidget(
                icon: icon.image,
              );
            }),
      ),
    );
  }
}
