import 'package:flutter/material.dart';
import 'package:money_management/components/currency_input.dart';
import 'package:money_management/components/text_field_custom.dart';
import 'package:money_management/data/data.dart';
import 'package:money_management/model/account.dart';
import 'package:money_management/model/category.dart';
import 'package:money_management/model/expend.dart';
import 'package:money_management/model/home_date_category.dart';
import 'package:money_management/provider/account_provider.dart';
import 'package:money_management/provider/category_provider.dart';
import 'package:money_management/provider/expend_provider.dart';
import 'package:money_management/screens/accounts/components/TypeSelect.dart';
import 'package:money_management/screens/create_expend/components/account_dropdown_menu/account_dropdown_menu.dart';
import 'package:money_management/screens/create_expend/components/favorite_list.dart';
import 'package:money_management/screens/create_expend/components/transaction_type_dropdown_menu/transaction_type_dropdown_menu.dart';
import 'package:money_management/skeletons/skeleton_category_expend.dart';
import 'package:money_management/storage/locator.dart';
import 'package:money_management/storage/user_storage.dart';
import 'package:money_management/utils/currence_format.dart';
import 'package:money_management/utils/data_utils.dart';
import 'package:money_management/utils/enum.dart';
import 'package:provider/provider.dart';
import 'components/category_dropdown_menu/category_dropdown_menu.dart';
import 'package:money_management/utils/date_format.dart';
import 'package:money_management/components/button.dart';
import 'package:money_management/components/show_toastification.dart';

class CreateExpend extends StatefulWidget {
  const CreateExpend(
      {Key? key, this.expendSelected, this.isCreateFromBottomMenu})
      : super(key: key);
  final ExpendModel? expendSelected;
  final bool? isCreateFromBottomMenu;
  @override
  _CreateExpendState createState() => _CreateExpendState();
}

class _CreateExpendState extends State<CreateExpend> {
  TextEditingController _amountController = TextEditingController(text: '0');
  TextEditingController _desController = TextEditingController();
  var focusNode = FocusNode();
  ValueNotifier<CategoryModel> categorySelected =
      ValueNotifier(CategoryModel(name: '', iconId: '', isFavorite: false));
  CategoryModel emptyCategoryData =
      CategoryModel(name: '', iconId: '', isFavorite: false);
  Account emptyAccountData =
      Account(accountName: "", id: null, userId: null, accountBalance: null);
  ValueNotifier<Account> accountSelected = ValueNotifier(
      Account(accountName: "", id: null, userId: null, accountBalance: null));
  ValueNotifier<TransactionTypeSelect> transactionTypeSelected =
      ValueNotifier(transactionTypeList[0]);
  DateTime selectedDate = DateTime.now();
  bool isEdit = false;

  @override
  void initState() {
    super.initState();
    isEdit = !isEmptyData(widget.expendSelected);
    if (isEdit) {
      _amountController.text =
          formatCurrency(widget.expendSelected?.amount ?? 0);
      _desController.text = widget.expendSelected?.description ?? "";
      selectedDate = widget.expendSelected?.dateTime ?? DateTime.now();
      transactionTypeSelected.value =
          getTransactionTypeByValue(widget.expendSelected?.transactionType);
      categorySelected.value =
          widget.expendSelected?.category ?? emptyCategoryData;
    }
  }

  TransactionTypeSelect getTransactionTypeByValue(String? value) {
    return transactionTypeList.firstWhere((item) => item.value == value);
  }

  _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: selectedDate,
      firstDate: DateTime(2024),
      lastDate: DateTime(2050),
      helpText: 'Chọn ngày',
      cancelText: 'Hủy',
      confirmText: 'Xong',
    );
    if (picked != null && picked != selectedDate) {
      setState(() {
        selectedDate = picked;
      });
    }
  }

  void actionSuccess(String text, Account account) {
    showToastification(text, 'success', context);
    getExpendListByDate();
    context.read<ExpendProvider>().getAllExpend(account.id ?? "");
    context.read<AccountProvider>().setAccountSelected(account);
    Navigator.pop(context);
  }

  void getExpendListByDate() {
    DateCategory categoryDateSelected =
        context.read<ExpendProvider>().categoryDateSelected;
    String userId = serviceLocator<UserStorage>().getUserId() ?? "";
    Provider.of<ExpendProvider>(context, listen: false).getExpendsByDate(
        categoryDateSelected.startDate, categoryDateSelected.endDate, userId);
  }

  String? getAccountId() {
    AccountProvider accountProviderData =
        Provider.of<AccountProvider>(context, listen: false);
    return accountSelected.value.id ??
        context.read<AccountProvider>().accountSelected.id ??
        accountProviderData.accounts[0].id;
  }

  onSave() {
    if (categorySelected.value.name == '') {
      showToastification('Vui lòng chọn hạng mục!', 'warning', context);
      return;
    }
    AccountProvider accountProviderData =
        Provider.of<AccountProvider>(context, listen: false);
    Account account = getAccountSelected(accountProviderData);
    String userId = serviceLocator<UserStorage>().getUserId() ?? "";
    ExpendRequestModel expendRequest = ExpendRequestModel(
        accountId: account.id ?? "",
        amount: parseCurrency(_amountController.text),
        categoryId: categorySelected.value.id,
        dateTime: selectedDate,
        id: widget.expendSelected?.id,
        transactionType: transactionTypeSelected.value.value,
        userId: userId,
        description: _desController.text);

    if (isEdit) {
      context
          .read<ExpendProvider>()
          .updateExpend(widget.expendSelected?.id ?? "", expendRequest)
          .then((response) {
        if (response.statusCode == 204) {
          actionSuccess('Sửa bản ghi thành lại!', account);
        }
      });
      return;
    }
    context.read<ExpendProvider>().createExpend(expendRequest).then((response) {
      if (response.statusCode == 201) {
        actionSuccess('Tạo bản ghi thành công!', account);
      }
    });
  }

  Account getAccountSelected(AccountProvider accountProvider) {
    if (!isEmptyData(accountSelected.value.accountName)) {
      return accountSelected.value;
    }
    Account accountDefaultSelected = accountProvider.accounts.isNotEmpty
        ? accountProvider.accounts[0]
        : emptyAccountData;
    return isEmptyData(accountProvider.accountSelected.accountName)
        ? accountDefaultSelected
        : accountProvider.accountSelected;
  }

  CategoryModel getCategorySelected(CategoryProvider categoryProvider) {
    if (!isEmptyData(categorySelected.value.name)) {
      return categorySelected.value;
    }
    return isEdit ? categoryProvider.categorySelected : emptyCategoryData;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green,
        leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: const Icon(
              Icons.arrow_back_ios_rounded,
              color: Colors.white,
            )),
        title: TransactionTypeDropdownMenu(
            onChanged: (trans) {
              setState(() {
                transactionTypeSelected.value = trans;
                categorySelected.value = emptyCategoryData;
              });
            },
            transactionTypeSelected: transactionTypeSelected),
        centerTitle: true,
        actions: [
          IconButton(
              onPressed: onSave,
              icon: const Icon(
                Icons.check_rounded,
                color: Colors.white,
                size: 30,
              ))
        ],
      ),
      body: SingleChildScrollView(
        child: Container(
          color: const Color(0xFFefeff2),
          child: Column(children: [
            Container(
              color: Colors.white,
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              child: CurrencyInput(
                  controller: _amountController,
                  text: 'Số tiền',
                  numberColor: transactionTypeSelected.value.value ==
                          TransactionType.income.value
                      ? Colors.green
                      : Colors.red),
            ),
            Container(
              color: Colors.white,
              margin: const EdgeInsets.only(top: 10),
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Column(children: [
                const SizedBox(height: 20),
                Consumer<CategoryProvider>(
                  builder: (context, categoryProvider, child) =>
                      CategoryDropdownMenu(
                    onChanged: (category) {
                      setState(() {
                        categorySelected.value = category;
                      });
                    },
                    category:
                        ValueNotifier(getCategorySelected(categoryProvider)),
                    transactionTypeSelect: transactionTypeSelected.value,
                  ),
                ),
                Consumer<CategoryProvider>(
                  builder: (context, categoryProvider, child) =>
                      categoryProvider.loading
                          ? const SkeletonCategoryExpend()
                          : FavoriteList(
                              categoryList: categoryProvider.categoryList,
                              categorySelected:
                                  getCategorySelected(categoryProvider),
                              transactionTypeSelect:
                                  transactionTypeSelected.value,
                              onItemClicked: (category) {
                                setState(() {
                                  categorySelected.value = category;
                                });
                              },
                            ),
                ),
                const SizedBox(height: 20),
                TextFieldCustom(
                  hintText: 'Mô tả',
                  controller: _desController,
                  icon: Image.asset(
                    'assets/icons/description.png',
                    width: 35,
                  ),
                ),
                const SizedBox(height: 20),
                InkWell(
                  onTap: () => _selectDate(context),
                  child: TypeSelect(
                    icon: Image.asset('assets/icons/calendar.png', width: 35),
                    text: (formatDateTime(selectedDate)),
                  ),
                ),
                const SizedBox(height: 20),
                Consumer<AccountProvider>(
                  builder: (context, accountProvider, child) =>
                      AccountDropdownMenu(
                    onChanged: (account) {
                      setState(() {
                        accountSelected.value = account;
                      });
                    },
                    account: ValueNotifier(getAccountSelected(accountProvider)),
                  ),
                ),
                const SizedBox(height: 20),
              ]),
            )
          ]),
        ),
      ),
      bottomNavigationBar: BottomAppBar(
          surfaceTintColor: Colors.transparent,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Button(
                textButton: isEdit ? 'Lưu' : 'Ghi',
                onButtonPressed: onSave,
                bgColor: Colors.green,
              ),
            ],
          )),
    );
  }
}
