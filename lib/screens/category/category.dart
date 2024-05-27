import 'package:flutter/material.dart';
import 'package:money_management/components/button.dart';
import 'package:money_management/components/dialog_confirm.dart';
import 'package:money_management/components/show_toastification.dart';
import 'package:money_management/components/text_field_custom.dart';
import 'package:money_management/model/category.dart';
import 'package:money_management/model/icon.dart';
import 'package:money_management/provider/category_provider.dart';
import 'package:money_management/screens/category/components/category_bottom_sheet.dart';
import 'package:money_management/screens/category/components/category_list.dart';
import 'package:money_management/screens/category/components/icon_dropdown_menu/icon_dropdown_menu.dart';
import 'package:money_management/screens/category/components/search_input.dart';
import 'package:money_management/skeletons/skeleton_category_list.dart';
import 'package:money_management/utils/enum.dart';
import 'package:provider/provider.dart';
import 'package:wc_form_validators/wc_form_validators.dart';

class Category extends StatefulWidget {
  const Category({Key? key}) : super(key: key);

  @override
  _CreateCategoryState createState() => _CreateCategoryState();
}

class _CreateCategoryState extends State<Category>
    with SingleTickerProviderStateMixin {
  bool isShowSearch = false;
  late ValueNotifier<IconModel> iconSelected =
      ValueNotifier(IconModel(id: '', image: ''));
  final TextEditingController _categoryNameController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  late TabController _tabController = TabController(length: 2, vsync: this);
  bool isEdit = false;
  late CategoryModel categorySelected =
      CategoryModel(name: '', iconId: '', isFavorite: false);

  void initState() {
    super.initState();
    context.read<CategoryProvider>().getCategoryList();
  }

  onActionsPressed(BuildContext context, CategoryModel category) {
    showModalBottomSheet(
        context: context,
        useRootNavigator: true,
        builder: (context) => CategoryBottomSheet(
            categorySelected: category,
            onUpdateFavoritePressed: () => handleUpdateFavorite(category),
            onDeletePressed: () {
              showDialogConfirm(
                  context, 'Bạn có muốn xóa hạng mục: "${category.name}"?',
                  () {
                onConfirm(category.id ?? "");
              });
            },
            onEditPressed: () {
              isEdit = true;
              iconSelected.value = category.icon!;
              _categoryNameController.text = category.name ?? "";
              categorySelected = category;
              showDataAlert();
            }));
  }

  handleUpdateFavorite(CategoryModel categorySelected) {
    CategoryFavoriteModel categoryRequest = CategoryFavoriteModel(
      id: categorySelected.id!,
      isFavorite: !categorySelected.isFavorite,
    );
    context
        .read<CategoryProvider>()
        .updateCategoryFavorite(categorySelected.id!, categoryRequest)
        .then((response) {
      if (response.statusCode == 204) {
        showToastification(
            'Đã thêm hạng mục vào mục hay dùng!', 'success', context);
        context.read<CategoryProvider>().getCategoryList();
      }
    });
    return;
  }

  void onConfirm(String categoryId) {
    context
        .read<CategoryProvider>()
        .deleteCategory(categoryId)
        .then((response) {
      if (response.statusCode == 204) {
        showToastification('Xóa hạng mục thành công!', 'success', context);
        context.read<CategoryProvider>().getCategoryList();
        Navigator.pop(context);
      }
    });
  }

  handleCreateCategory() {
    if (_formKey.currentState!.validate()) {
      CategoryRequestModel category = CategoryRequestModel(
        name: _categoryNameController.text,
        iconId: iconSelected.value.id ?? "",
        id: categorySelected.id ?? "",
        transactionType:
            TransactionType.fromIndex(_tabController.index).toString(),
      );
      if (isEdit) {
        context
            .read<CategoryProvider>()
            .updateCategory(categorySelected.id!, category)
            .then((response) {
          if (response.statusCode == 204) {
            actionSuccess('Sửa hạng mục thành công!');
          }
        });
        return;
      }
      context
          .read<CategoryProvider>()
          .createCategory(category)
          .then((response) {
        if (response.statusCode == 201) {
          actionSuccess('Thêm hạng mục thành công!');
        }
      });
    }
  }

  actionSuccess(String text) {
    showToastification(text, 'success', context);
    clearForm();
    context.read<CategoryProvider>().getCategoryList();
    Navigator.pop(context);
  }

  clearForm() {
    iconSelected.value = IconModel(id: '', image: '');
    _categoryNameController.value = TextEditingValue.empty;
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
              'Thêm hạng mục',
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
            content: Container(
              child: SingleChildScrollView(
                padding:
                    const EdgeInsets.symmetric(horizontal: 12, vertical: 25),
                child: Form(
                  key: _formKey,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      IconDropdownMenu(
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
                          controller: _categoryNameController,
                          icon: Image.asset(
                            'assets/icons/category.png',
                            width: 40,
                          ),
                          validator: Validators.compose([
                            Validators.required('Vui lòng nhập tên hạng mục')
                          ])),
                      const SizedBox(height: 20),
                      Button(
                        textButton: 'LƯU',
                        bgColor: Colors.green,
                        onButtonPressed: handleCreateCategory,
                      )
                    ],
                  ),
                ),
              ),
            ),
          );
        });
  }

  List<CategoryModel> filterCategoryList(
      List<CategoryModel> categoryList, String type) {
    return categoryList
        .where((category) => category.transactionType == type)
        .toList();
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
      body: DefaultTabController(
        length: 2,
        child: Container(
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
              Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: TabBar(
                  controller: _tabController,
                  padding: const EdgeInsets.only(bottom: 0),
                  indicatorColor: Colors.green,
                  dividerColor: Colors.transparent,
                  labelColor: Colors.green,
                  labelPadding: EdgeInsets.zero,
                  unselectedLabelColor: Colors.black,
                  unselectedLabelStyle:
                      const TextStyle(fontWeight: FontWeight.normal),
                  labelStyle: const TextStyle(
                      fontSize: 16, fontWeight: FontWeight.w700),
                  tabs: const [
                    Tab(text: 'CHI TIỀN'),
                    Tab(text: 'THU TIỀN'),
                  ],
                ),
              ),
              const SizedBox(height: 20),
              Expanded(
                  child: TabBarView(
                controller: _tabController,
                children: [
                  Consumer<CategoryProvider>(
                    builder: (context, categoryProviderData, child) =>
                        categoryProviderData.loading
                            ? const SkeletonCategoryList()
                            : CategoryTabList(
                                categoryList: filterCategoryList(
                                    categoryProviderData.categoryList,
                                    TransactionType.expense.toString()),
                                onItemClicked: () {},
                                onActionsPressed: (category) =>
                                    onActionsPressed(context, category)),
                  ),
                  Consumer<CategoryProvider>(
                    builder: (context, categoryProviderData, child) =>
                        CategoryTabList(
                            categoryList: filterCategoryList(
                                categoryProviderData.categoryList,
                                TransactionType.income.toString()),
                            onItemClicked: () {},
                            onActionsPressed: (category) =>
                                onActionsPressed(context, category)),
                  )
                ],
              ))
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        heroTag: "btn3",
        backgroundColor: Colors.green,
        elevation: 0,
        onPressed: () {
          isEdit = false;
          clearForm();
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
