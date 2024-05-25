import 'package:flutter/material.dart';
import 'package:money_management/components/button.dart';
import 'package:money_management/components/currency_input.dart';
import 'package:money_management/components/show_toastification.dart';
import 'package:money_management/components/text_field_custom.dart';
import 'package:money_management/model/account.dart';
import 'package:money_management/provider/account_provider.dart';
import 'package:money_management/screens/accounts/components/TypeSelect.dart';
import 'package:money_management/storage/locator.dart';
import 'package:money_management/storage/user_storage.dart';
import 'package:money_management/utils/currence_format.dart';
import 'package:money_management/utils/data_utils.dart';
import 'package:provider/provider.dart';

class CreateAccount extends StatefulWidget {
  const CreateAccount({super.key, this.accountSelected});
  final Account? accountSelected;
  @override
  _CreateAccountState createState() => _CreateAccountState();
}

class _CreateAccountState extends State<CreateAccount> {
  final TextEditingController _amountController =
      TextEditingController(text: '0');
  final TextEditingController _accountNameController = TextEditingController();
  final TextEditingController _desController = TextEditingController();
  var focusNode = FocusNode();
  final sharedPrefService = serviceLocator<UserStorage>();
  bool isEdit = false;

  @override
  void initState() {
    super.initState();
    isEdit = !isEmptyData(widget.accountSelected);
    if (isEdit) {
      _accountNameController.text = widget.accountSelected?.accountName ?? "";
      _amountController.text =
          formatCurrency(widget.accountSelected?.accountBalance ?? 0);
      _desController.text = widget.accountSelected?.description ?? "";
    }
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
        title: Text(
          isEdit ? 'Sửa tài khoản' : 'Thêm tài khoản',
          style: const TextStyle(
              color: Colors.white, fontWeight: FontWeight.w600, fontSize: 18),
        ),
        actions: [
          IconButton(
              onPressed: () {
                onSave();
              },
              tooltip: 'Lưu',
              icon: const Icon(
                Icons.check_rounded,
                color: Colors.white,
                size: 30,
              ))
        ],
        centerTitle: true,
      ),
      body: Container(
        color: const Color(0xFFefeff2),
        child: Column(children: [
          Container(
              color: Colors.white,
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              child: CurrencyInput(
                controller: _amountController,
                text: 'Số dư ban đầu',
                numberColor: Colors.green,
              )),
          const SizedBox(height: 10),
          Container(
            color: Colors.white,
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            child: Column(
              children: [
                TextFieldCustom(
                  controller: _accountNameController,
                  focusNode: focusNode,
                  hintText: 'Tên tài khoản',
                  icon: Image.asset(
                    'assets/icons/account_name.png',
                    width: 40,
                  ),
                ),
                const SizedBox(height: 20),
                TypeSelect(
                    text: 'Tiền mặt',
                    icon: Image.asset(
                      'assets/icons/wallet.png',
                      width: 40,
                    )),
                const SizedBox(height: 20),
                TypeSelect(
                    text: 'VND',
                    icon: Image.asset(
                      'assets/icons/money.png',
                      width: 40,
                    )),
                const SizedBox(height: 20),
                TextFieldCustom(
                  hintText: 'Mô tả',
                  controller: _desController,
                  icon: Image.asset(
                    'assets/icons/description.png',
                    width: 40,
                  ),
                ),
              ],
            ),
          )
        ]),
      ),
      bottomNavigationBar: BottomAppBar(
          surfaceTintColor: Colors.transparent,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Button(
                textButton: 'LƯU',
                onButtonPressed: onSave,
                bgColor: Colors.green,
              ),
            ],
          )),
    );
  }

  void actionSuccess(String text, String userId) {
    showToastification(text, 'success', context);
    Navigator.pop(context);
    context.read<AccountProvider>().getAllAccounts(userId);
  }

  onSave() {
    String accountsValue = _accountNameController.text.trim();
    final userId = sharedPrefService.getUserId() ?? "";
    if (accountsValue.isEmpty) {
      showToastification(
          'Tên tài khoản không được để trống!', 'warning', context);
      focusNode.requestFocus();
      return;
    }
    Account accountRequest = Account(
        id: widget.accountSelected?.id,
        accountName: _accountNameController.text,
        accountBalance: parseCurrency(_amountController.text),
        userId: userId,
        description: _desController.text);
    if (isEdit) {
      context
          .read<AccountProvider>()
          .updateAccount(widget.accountSelected?.id ?? "", accountRequest)
          .then((response) {
        if (response.statusCode == 204) {
          actionSuccess('Sửa tài khoản thành công!', userId);
        }
      });
      return;
    }
    context
        .read<AccountProvider>()
        .createAccount(accountRequest)
        .then((response) {
      if (response.statusCode == 201) {
        actionSuccess('Tạo tài khoản thành công!', userId);
      }
    });
  }
}
