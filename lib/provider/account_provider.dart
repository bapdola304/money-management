import 'package:flutter/material.dart';
import 'package:money_management/model/account.dart';
import 'package:money_management/services/account_service.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

class AccountProvider extends ChangeNotifier {
  BuildContext context;
  AccountProvider(this.context);
  final _service = AccountService();
  List<Account> _accounts = [];
  List<Account> get accounts => _accounts;
  String _accountIdSelected = '';
  String? get accountIdSelected => _accountIdSelected;
  Account _accountSelected = Account(accountName: '', id: '');
  Account get accountSelected => _accountSelected;

  Future<void> getAllAccounts(String userId) async {
    EasyLoading.show();
    final response = await _service.getAll(userId);
    EasyLoading.dismiss();
    debugPrint(_accountIdSelected.toString());
    _accounts = response;
    if (_accountIdSelected != '') {
      _accountSelected =
          _accounts.firstWhere((item) => item.id == _accountIdSelected);
    }
    notifyListeners();
  }

  Future<dynamic> createAccount(Account body) async {
    EasyLoading.show();
    final response = await _service.createAccount(body);
    EasyLoading.dismiss();
    return response;
  }

  void setAccountIdSelected(String accountId) {
    _accountIdSelected = accountId;
    notifyListeners();
  }
}
