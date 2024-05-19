import 'package:flutter/material.dart';
import 'package:money_management/components/button.dart';
import 'package:money_management/components/currency_input.dart';
import 'package:money_management/components/text_field_custom.dart';
import 'package:money_management/screens/accounts/components/TypeSelect.dart';
import 'package:toastification/toastification.dart';

class CreateAccount extends StatefulWidget {
  const CreateAccount({Key? key}) : super(key: key);

  @override
  _CreateAccountState createState() => _CreateAccountState();
}

class _CreateAccountState extends State<CreateAccount> {
  TextEditingController _controller = TextEditingController(text: '0');
  TextEditingController _accountsController = TextEditingController();
  var focusNode = FocusNode();

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
        title: const Text(
          'Thêm tài khoản',
          style: TextStyle(
              color: Colors.white, fontWeight: FontWeight.w600, fontSize: 18),
        ),
        centerTitle: true,
      ),
      body: Container(
        color: const Color(0xFFefeff2),
        child: Column(children: [
          Container(
              color: Colors.white,
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              child: CurrencyInput(
                controller: _controller,
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
                  controller: _accountsController,
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

  onSave() {
    String accountsValue = _accountsController.text;
    if (accountsValue.isEmpty) {
      toastification.show(
          context: context,
          title: const Text(
            'Tên tài khoản không được để trống!',
            style: TextStyle(fontSize: 14),
          ),
          type: ToastificationType.warning,
          autoCloseDuration: const Duration(seconds: 5),
          closeButtonShowType: CloseButtonShowType.none,
          style: ToastificationStyle.flatColored,
          borderRadius: BorderRadius.circular(50),
          closeOnClick: true,
          animationDuration: const Duration(milliseconds: 100),
          showProgressBar: false);
      focusNode.requestFocus();
    }
  }
}
