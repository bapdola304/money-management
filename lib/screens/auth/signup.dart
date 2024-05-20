import 'package:flutter/material.dart';
import 'package:money_management/components/show_toastification.dart';
import 'package:money_management/model/user.dart';
import 'package:money_management/provider/user_provider.dart';
import 'package:money_management/screens/auth/components/button_custom.dart';
import 'package:money_management/screens/auth/components/input_custom.dart';
import 'package:money_management/screens/auth/login.dart';
import 'package:provider/provider.dart';
import 'package:wc_form_validators/wc_form_validators.dart';

class SignupPage extends StatefulWidget {
  @override
  State<SignupPage> createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController _usernameController = TextEditingController();

  final TextEditingController _passwordController = TextEditingController();

  final TextEditingController _fullNameController = TextEditingController();

  String? validatorCommon(String? value, String inputName) {
    if (value == null || value.isEmpty) {
      return 'Vui lòng nhập $inputName';
    }
    if (value != _passwordController.text) {
      return 'Mật khẩu xác nhận không giống với mật khẩu';
    }
    return null;
  }

  bool checkUsernameIsExist(String username, List<User> userList) {
    for (User user in userList) {
      if (user.username == username) {
        return true;
      }
    }
    return false;
  }

  void handleSingUp() async {
    if (_formKey.currentState!.validate()) {
      FocusScope.of(context).unfocus();
      List<User> userList = await context.read<UserProvider>().getAllUsers();
      if (checkUsernameIsExist(_usernameController.text, userList)) {
        showToastification('Tài khoản đã tồn tại!', 'warning', context);
        return;
      }
      User user = User(
          username: _usernameController.text,
          fullName: _fullNameController.text,
          password: _passwordController.text);
      final response = await context.read<UserProvider>().singUpUser(user);
      if (response.statusCode == 201) {
        clearForm();
        showToastification(
            'TĐăng ký tài khoản thành công!', 'success', context);
        Navigator.of(context, rootNavigator: true).push(MaterialPageRoute(
          builder: (context) => LoginScreen(),
        ));
      }
    }
  }

  void clearForm() {
    _formKey.currentState?.reset();
    _usernameController.clear();
    _passwordController.clear();
    _fullNameController.clear();
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
                        label: 'Tên người dùng',
                        controller: _fullNameController,
                        obscureText: false,
                        validator: Validators.required(
                            'Vui lòng nhập tên người dùng')),
                    InputCustom(
                      label: 'Tài khoản',
                      controller: _usernameController,
                      obscureText: false,
                      validator: Validators.compose([
                        Validators.required('Vui lòng nhập tài khoản'),
                        Validators.patternRegExp(RegExp(r"^[A-Za-z0-9]+$"),
                            'Tài khoản không chứa ký tự đặc biệt'),
                        Validators.minLength(
                            3, 'Tài khoản phải có ít nhất 3 ký tự')
                      ]),
                    ),
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
                      ]),
                    ),
                    InputCustom(
                        label: 'Xác nhận mật khẩu',
                        obscureText: true,
                        validator: (value) =>
                            validatorCommon(value, 'mật khẩu xác nhận'))
                  ],
                ),
              ),
              ButtonCustom(
                textButton: 'Đăng ký',
                onButtonPressed: handleSingUp,
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
