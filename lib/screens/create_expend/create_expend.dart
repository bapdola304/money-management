import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:money_management/components/currency_input.dart';
import 'package:money_management/components/text_field_custom.dart';
import 'package:money_management/data/data.dart';
import 'package:money_management/screens/accounts/components/TypeSelect.dart';
import 'components/category_dropdown_menu/category_dropdown_menu.dart';
import 'package:money_management/utils/currence_format.dart';
import 'package:money_management/utils/date_format.dart';
import 'package:money_management/components/button.dart';

class CreateExpend extends StatefulWidget {
  const CreateExpend({Key? key}) : super(key: key);

  @override
  _CreateExpendState createState() => _CreateExpendState();
}

class _CreateExpendState extends State<CreateExpend> {
  TextEditingController _controller = TextEditingController(text: '0');
  TextEditingController _accountsController = TextEditingController();
  var focusNode = FocusNode();
  late ValueNotifier<CategoryModel> categorySelected;
  DateTime selectedDate = DateTime.now();

  @override
  void initState() {
    super.initState();
    setState(() {
      categorySelected = ValueNotifier(listProjects[0]);
    });
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
    String accountsValue = _accountsController.text;
    if (accountsValue.isEmpty) {
      // toastification.show(
      //     context: context,
      //     title: const Text(
      //       'Tên tài khoản không được để trống!',
      //       style: TextStyle(fontSize: 14),
      //     ),
      //     type: ToastificationType.warning,
      //     autoCloseDuration: const Duration(seconds: 5),
      //     closeButtonShowType: CloseButtonShowType.none,
      //     style: ToastificationStyle.flatColored,
      //     borderRadius: BorderRadius.circular(50),
      //     closeOnClick: true,
      //     animationDuration: const Duration(milliseconds: 100),
      //     showProgressBar: false);
      // focusNode.requestFocus();
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
        title: const Text(
          'Chi tiền',
          style: TextStyle(
              color: Colors.white, fontWeight: FontWeight.w600, fontSize: 18),
        ),
        centerTitle: true,
        actions: [
          IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: const Icon(
                Icons.check_rounded,
                color: Colors.white,
                size: 30,
              ))
        ],
      ),
      body: Container(
        color: const Color(0xFFefeff2),
        child: Column(children: [
          Container(
            color: Colors.white,
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            child: CurrencyInput(controller: _controller, text: 'Số tiền'),
          ),
          Container(
            color: Colors.white,
            margin: const EdgeInsets.only(top: 10),
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Column(children: [
              const SizedBox(height: 20),
              CategoryDropdownMenu(
                categoryList: listProjects,
                onChanged: (category) {
                  setState(() {
                    categorySelected.value = category;
                  });
                },
                category: categorySelected,
              ),
              const SizedBox(height: 20),
              TextFieldCustom(
                hintText: 'Mô tả',
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
              CategoryDropdownMenu(
                categoryList: listProjects,
                onChanged: (category) {
                  setState(() {
                    categorySelected.value = category;
                  });
                },
                category: categorySelected,
              ),
              const SizedBox(height: 20),
            ]),
          )
        ]),
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
