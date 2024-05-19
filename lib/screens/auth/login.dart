import 'package:flutter/material.dart';
import 'package:money_management/components/loading_overlay.dart';
import 'package:money_management/model/user.dart';
import 'package:money_management/provider/user_provider.dart';
import 'package:money_management/screens/auth/components/button_custom.dart';
import 'package:money_management/screens/auth/components/input_custom.dart';
import 'package:money_management/screens/auth/signup.dart';
import 'package:money_management/screens/main_screen/main_screen.dart';
import 'package:provider/provider.dart';
import 'package:toastification/toastification.dart';

class LoginScreen extends StatefulWidget {
  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  void initState() {
    super.initState();
    getAllUsers();
  }

  void getAllUsers() async {
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      LoadingOverlay.of(context).show();
      await context.read<UserProvider>().getAllUsers();
      LoadingOverlay.of(context).hide();
    });
  }

  String? validatorCommon(String? value, String inputName) {
    debugPrint(value);
    if (value == null || value.isEmpty) {
      return 'Vui lòng nhập tên $inputName';
    }
    return null;
  }

  bool checkLogin(String username, String password, List<User> userList) {
    for (User user in userList) {
      if (user.username == username && user.password == password) {
        return true;
      }
    }
    return false;
  }

  void handleLogin() {
    if (_formKey.currentState!.validate()) {
      List<User> userList = context.read<UserProvider>().users;
      bool isLogined = checkLogin(
          _usernameController.text, _passwordController.text, userList);
      if (isLogined) {
        FocusScope.of(context).unfocus();
        Navigator.of(context).pushAndRemoveUntil(
            MaterialPageRoute(builder: (context) => MainScreen()),
            (route) => false);
      } else {
        toastification.show(
            context: context,
            title: const Text(
              'Tài khoản hoặc mật khẩu không chính xác',
              style: TextStyle(fontSize: 14),
            ),
            type: ToastificationType.error,
            autoCloseDuration: const Duration(seconds: 5),
            closeButtonShowType: CloseButtonShowType.none,
            style: ToastificationStyle.flatColored,
            borderRadius: BorderRadius.circular(50),
            closeOnClick: true,
            animationDuration: const Duration(milliseconds: 100),
            showProgressBar: false);
      }
    }
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
                  const SizedBox(height: 50),
                  Image.asset('assets/images/logo.png', width: 300),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 40),
                    child: Form(
                      key: _formKey,
                      child: Column(
                        children: [
                          InputCustom(
                              label: 'Tài khoản',
                              controller: _usernameController,
                              obscureText: false,
                              validator: (value) =>
                                  validatorCommon(value, 'tài khoản')),
                          InputCustom(
                            label: 'Mật khẩu',
                            controller: _passwordController,
                            obscureText: true,
                            validator: (value) =>
                                validatorCommon(value, 'mật khẩu'),
                          )
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 30),
                  Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 40),
                      child: ButtonCustom(
                        textButton: 'Đăng nhập',
                        onButtonPressed: handleLogin,
                      )),
                  const SizedBox(height: 30),
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
