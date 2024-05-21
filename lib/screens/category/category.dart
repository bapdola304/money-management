import 'package:flutter/material.dart';
import 'package:money_management/components/button.dart';
import 'package:money_management/components/text_field_custom.dart';
import 'package:money_management/model/icon.dart';
import 'package:money_management/screens/category/components/category_bottom_sheet.dart';
import 'package:money_management/screens/category/components/category_list.dart';
import 'package:money_management/screens/category/components/icon_dropdown_menu/icon_dropdown_menu.dart';
import 'package:money_management/screens/category/components/search_input.dart';

class Category extends StatefulWidget {
  const Category({Key? key}) : super(key: key);

  @override
  _CreateCategoryState createState() => _CreateCategoryState();
}

class _CreateCategoryState extends State<Category> {
  bool isShowSearch = false;
  late ValueNotifier<IconModel> iconSelected =
      ValueNotifier(IconModel(id: '', image: ''));
  final TextEditingController _desController = TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  onActionsPressed(BuildContext context) {
    showModalBottomSheet(
        context: context,
        useRootNavigator: true,
        builder: (context) =>
            CategoryBottomSheet(onDeletePressed: () {}, onEditPressed: () {}));
  }

  showDataAlert() {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(
                Radius.circular(
                  20.0,
                ),
              ),
            ),
            contentPadding: const EdgeInsets.only(
              top: 10.0,
            ),
            title: const Text(
              "Thêm hạng mục chi tiêu",
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
            content: Container(
              child: SingleChildScrollView(
                padding:
                    const EdgeInsets.symmetric(horizontal: 12, vertical: 25),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    IconDropdownMenu(
                      icons: [],
                      onChanged: (icon) {
                        setState(() {
                          iconSelected.value = icon;
                        });
                      },
                      icon: iconSelected,
                    ),
                    const SizedBox(height: 20),
                    TextFieldCustom(
                      hintText: 'Tên hạng mục',
                      controller: _desController,
                      icon: Image.asset(
                        'assets/icons/category.png',
                        width: 40,
                      ),
                    ),
                    const SizedBox(height: 20),
                    Button(
                      textButton: 'LƯU',
                      bgColor: Colors.green,
                      onButtonPressed: () {},
                    )
                  ],
                ),
              ),
            ),
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green,
        leading: IconButton(
            onPressed: () {
              setState(() {
                isShowSearch = !isShowSearch;
              });
            },
            icon: const Icon(Icons.search_rounded, color: Colors.white)),
        title: const Text(
          'Hạng mục chi tiêu',
          style: TextStyle(
              color: Colors.white, fontWeight: FontWeight.w600, fontSize: 18),
        ),
        centerTitle: true,
      ),
      body: Container(
        color: const Color(0xFFefeff2),
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          children: [
            isShowSearch ? const SizedBox(height: 20) : Container(),
            isShowSearch
                ? SearchInput(
                    onChanged: (text) {},
                  )
                : Container(),
            const SizedBox(height: 10),
            Expanded(
                child: CategoryTabList(
                    onItemClicked: () {},
                    onActionsPressed: () => onActionsPressed(context)))
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        heroTag: "btn3",
        backgroundColor: Colors.green,
        elevation: 0,
        onPressed: () {
          showDataAlert();
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
    );
  }
}
