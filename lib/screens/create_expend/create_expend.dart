import 'package:flutter/material.dart';
import 'package:money_management/components/currency_input.dart';
import 'package:money_management/components/text_field_custom.dart';
import 'package:money_management/data/data.dart';
import 'package:money_management/model/account.dart';
import 'package:money_management/model/category.dart';
import 'package:money_management/model/expend.dart';
import 'package:money_management/provider/account_provider.dart';
import 'package:money_management/provider/expend_provider.dart';
import 'package:money_management/screens/accounts/components/TypeSelect.dart';
import 'package:money_management/screens/create_expend/components/account_dropdown_menu/account_dropdown_menu.dart';
import 'package:money_management/screens/create_expend/components/favorite_list.dart';
import 'package:money_management/screens/create_expend/components/transaction_type_dropdown_menu/transaction_type_dropdown_menu.dart';
import 'package:money_management/utils/currence_format.dart';
import 'package:provider/provider.dart';
import 'components/category_dropdown_menu/category_dropdown_menu.dart';
import 'package:money_management/utils/date_format.dart';
import 'package:money_management/components/button.dart';
import 'package:money_management/components/show_toastification.dart';

class CreateExpend extends StatefulWidget {
  const CreateExpend({Key? key}) : super(key: key);

  @override
  _CreateExpendState createState() => _CreateExpendState();
}

class _CreateExpendState extends State<CreateExpend> {
  TextEditingController _amountController = TextEditingController(text: '0');
  TextEditingController _desController = TextEditingController();
  var focusNode = FocusNode();
  ValueNotifier<CategoryModel> categorySelected =
      ValueNotifier(CategoryModel(name: '', iconId: ''));
  ValueNotifier<Account> accountSelected = ValueNotifier(Account(
      accountName: "",
      id: null,
      userId: null,
      accountBalance: null,
      description: null));
  ValueNotifier<TransactionTypeSelect> transactionTypeSelected =
      ValueNotifier(transactionTypeList[0]);
  DateTime selectedDate = DateTime.now();

  @override
  void initState() {
    super.initState();
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

  onSave() {
    if (categorySelected.value.name == '') {
      showToastification('Vui lòng chọn hạng mục!', 'warning', context);
      return;
    }
    String accountId = accountSelected.value.id ??
        context.read<AccountProvider>().accountSelected.id ??
        '';
    ExpendRequestModel expendRequest = ExpendRequestModel(
        accountId: accountId,
        amount: parseCurrency(_amountController.text),
        categoryId: categorySelected.value.id,
        dateTime: selectedDate,
        description: _desController.text);
    context.read<ExpendProvider>().createExpend(expendRequest).then((response) {
      if (response.statusCode == 201) {
        showToastification('Ghi chi tiêu thành công!', 'success', context);
        context.read<ExpendProvider>().getAllExpend(accountId);
        Navigator.pop(context);
      }
    });
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
              child:
                  CurrencyInput(controller: _amountController, text: 'Số tiền'),
            ),
            Container(
              color: Colors.white,
              margin: const EdgeInsets.only(top: 10),
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Column(children: [
                const SizedBox(height: 20),
                CategoryDropdownMenu(
                  onChanged: (category) {
                    setState(() {
                      categorySelected.value = category;
                    });
                  },
                  category: categorySelected,
                ),
                FavoriteList(
                  categorySelected: categorySelected.value,
                  transactionTypeSelect: transactionTypeSelected.value,
                  onItemClicked: (category) {
                    setState(() {
                      categorySelected.value = category;
                    });
                  },
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
                    account: accountSelected.value.accountName != ''
                        ? accountSelected
                        : ValueNotifier(accountProvider.accountSelected),
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
                textButton: 'Ghi',
                onButtonPressed: onSave,
                bgColor: Colors.green,
              ),
            ],
          )),
    );
  }
}
