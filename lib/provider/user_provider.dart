import 'package:flutter/material.dart';
import 'package:money_management/model/user.dart';
import 'package:money_management/services/user_service.dart';

class UserProvider extends ChangeNotifier {
  final _service = UserService();
  bool isLoading = false;
  List<User> _users = [];
  List<User> get users => _users;

  Future<void> getAllUsers() async {
    isLoading = true;
    notifyListeners();
    final response = await _service.getAll();
    debugPrint(response.toString());
    _users = response;
    isLoading = false;
    notifyListeners();
  }
}
