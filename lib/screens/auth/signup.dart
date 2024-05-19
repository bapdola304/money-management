import 'package:flutter/material.dart';
import 'package:money_management/screens/auth/components/button_custom.dart';
import 'package:money_management/screens/auth/components/input_custom.dart';
import 'package:money_management/screens/auth/login.dart';

class SignupPage extends StatelessWidget {
  final _formKey = GlobalKey<FormState>();

  String? validatorCommon(String? value, String inputName) {
    if (value == null || value.isEmpty) {
      return 'Vui lòng nhập $inputName';
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 40),
          height: MediaQuery.of(context).size.height - 50,
          width: double.infinity,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Image.asset('assets/images/logo.png', width: 300),
              Form(
                key: _formKey,
                child: Column(
                  children: <Widget>[
                    InputCustom(
                      label: 'Tài khoản',
                      obscureText: false,
                      validator: (value) => validatorCommon(value, 'tài khoản'),
                    ),
                    InputCustom(
                      label: 'Tên người dùng',
                      obscureText: false,
                      validator: (value) =>
                          validatorCommon(value, 'tên người dùng'),
                    ),
                    InputCustom(
                      label: 'Mật khẩu',
                      obscureText: true,
                      validator: (value) => validatorCommon(value, 'mật khẩu'),
                    ),
                    InputCustom(
                      label: 'Xác nhận mật khẩu',
                      obscureText: true,
                      validator: (value) =>
                          validatorCommon(value, 'mật khẩu xác nhận'),
                    )
                  ],
                ),
              ),
              ButtonCustom(
                textButton: 'Đăng ký',
                onButtonPressed: () {
                  if (_formKey.currentState!.validate()) {}
                },
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  const Text("Bạn đã có tài khoản?"),
                  InkWell(
                    onTap: () =>
                        Navigator.of(context, rootNavigator: true).push(
                      MaterialPageRoute(
                        builder: (context) => LoginScreen(),
                      ),
                    ),
                    child: const Text(
                      " Đăng nhập",
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 18,
                      ),
                    ),
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
