import 'package:flutter/material.dart';
import 'package:money_management/model/account.dart';
import 'package:money_management/model/user.dart';
import 'package:money_management/services/account_service.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

class AccountProvider extends ChangeNotifier {
  BuildContext context;
  AccountProvider(this.context);
  final _service = AccountService();
  List<Account> _accounts = [];
  List<Account> get accounts => _accounts;

  Future<void> getAllAccounts(String userId) async {
    EasyLoading.show();
    try {
      final response = await _service.getAll(userId);
      EasyLoading.dismiss();
      _accounts = response;
      notifyListeners();
    } catch (e) {
      debugPrint(e.toString());
      EasyLoading.dismiss();
    }
  }
}
