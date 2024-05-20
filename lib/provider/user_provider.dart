import 'package:flutter/material.dart';
import 'package:money_management/model/user.dart';
import 'package:money_management/services/user_service.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

class UserProvider extends ChangeNotifier {
  BuildContext context;
  UserProvider(this.context);
  final _service = UserService();
  List<User> _users = [];
  List<User> get users => _users;

  Future<List<User>> getAllUsers() async {
    EasyLoading.show();
    final response = await _service.getAll();
    EasyLoading.dismiss();
    _users = response;
    notifyListeners();
    return response;
  }

  Future<dynamic> singUpUser(User body) async {
    EasyLoading.show();
    final response = await _service.singUpUser(body);
    EasyLoading.dismiss();
    return response;
  }
}
