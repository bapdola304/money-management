import 'package:flutter/material.dart';
import 'package:money_management/components/show_toastification.dart';
import 'package:money_management/model/user.dart';
import 'package:money_management/provider/user_provider.dart';
import 'package:money_management/screens/auth/components/button_custom.dart';
import 'package:money_management/screens/auth/components/input_custom.dart';
import 'package:money_management/screens/auth/signup.dart';
import 'package:money_management/screens/main_screen/main_screen.dart';
import 'package:money_management/storage/locator.dart';
import 'package:money_management/storage/user_storage.dart';
import 'package:provider/provider.dart';
import 'package:wc_form_validators/wc_form_validators.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final sharedPrefService = serviceLocator<UserStorage>();

  User? checkLogin(String username, String password, List<User> userList) {
    for (User user in userList) {
      if (user.username == username && user.password == password) {
        return user;
      }
    }
    return null;
  }

  void handleLogin() async {
    if (_formKey.currentState!.validate()) {
      FocusScope.of(context).unfocus();
      List<User> userList = await context.read<UserProvider>().getAllUsers();
      User? user = checkLogin(
          _usernameController.text, _passwordController.text, userList);
      if (user != null) {
        sharedPrefService.saveUserData(
            user.id ?? "", user.username, user.fullName);
        Navigator.of(context).pushAndRemoveUntil(
            MaterialPageRoute(builder: (context) => const MainScreen()),
            (route) => false);
      } else {
        showToastification(
            'Tài khoản hoặc mật khẩu không chính xác!', 'error', context);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: SizedBox(
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
                              validator: Validators.compose([
                                Validators.required('Vui lòng nhập tài khoản'),
                                Validators.patternRegExp(
                                    RegExp(r"^[A-Za-z0-9]+$"),
                                    'Tài khoản không chứa ký tự đặc biệt'),
                                Validators.minLength(
                                    3, 'Tài khoản phải có ít nhất 3 ký tự')
                              ])),
                          InputCustom(
                              label: 'Mật khẩu',
                              controller: _passwordController,
                              obscureText: true,
                              validator: Validators.compose([
                                Validators.required('Vui lòng nhập mật khẩu'),
                                Validators.patternRegExp(
                                    RegExp(r"^[A-Za-z0-9@#$%^&*]+$"),
                                    'Mật không chứa ký tự đặc biệt ngoài: [@#\$%^&*]'),
                                Validators.minLength(
                                    6, 'Mật khẩu phải có ít nhất 6 ký tự')
                              ]))
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
