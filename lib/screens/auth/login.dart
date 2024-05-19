import 'package:flutter/material.dart';
import 'package:money_management/screens/auth/components/button_custom.dart';
import 'package:money_management/screens/auth/components/input_custom.dart';
import 'package:money_management/screens/auth/signup.dart';
import 'package:money_management/screens/main_screen/main_screen.dart';

class LoginScreen extends StatelessWidget {
  final _formKey = GlobalKey<FormState>();

  String? validatorCommon(String? value, String inputName) {
    debugPrint(value);
    if (value == null || value.isEmpty) {
      return 'Vui lòng nhập tên $inputName';
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Container(
          height: MediaQuery.of(context).size.height,
          width: double.infinity,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  SizedBox(height: 50),
                  Image.asset('assets/images/logo.png', width: 300),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 40),
                    child: Form(
                      key: _formKey,
                      child: Column(
                        children: [
                          InputCustom(
                              label: 'Tài khoản',
                              obscureText: false,
                              validator: (value) =>
                                  validatorCommon(value, 'tài khoản')),
                          InputCustom(
                            label: 'Mật khẩu',
                            obscureText: true,
                            validator: (value) =>
                                validatorCommon(value, 'mật khẩu'),
                          )
                        ],
                      ),
                    ),
                  ),
                  SizedBox(height: 30),
                  Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 40),
                      child: ButtonCustom(
                        textButton: 'Đăng nhập',
                        onButtonPressed: () {
                          if (_formKey.currentState!.validate()) {
                            Navigator.of(context, rootNavigator: true).push(
                              MaterialPageRoute(
                                builder: (context) => const MainScreen(),
                              ),
                            );
                          }
                        },
                      )),
                  SizedBox(height: 30),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text("Không có tài khoản?"),
                      InkWell(
                        onTap: () =>
                            Navigator.of(context, rootNavigator: true).push(
                          MaterialPageRoute(
                            builder: (context) => SignupPage(),
                          ),
                        ),
                        child: const Text(
                          " Đăng ký ngay",
                          style: TextStyle(
                            fontWeight: FontWeight.w600,
                            fontSize: 18,
                          ),
                        ),
                      )
                    ],
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
