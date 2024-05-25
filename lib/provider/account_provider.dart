import 'package:flutter/material.dart';
import 'package:money_management/model/account.dart';
import 'package:money_management/services/account_service.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:money_management/utils/data_utils.dart';

class AccountProvider extends ChangeNotifier {
  BuildContext context;
  AccountProvider(this.context);
  final _service = AccountService();
  List<Account> _accounts = [];
  List<Account> get accounts => _accounts;
  Account _accountSelected = Account(accountName: '', id: '');
  Account get accountSelected => _accountSelected;
  bool loading = false;

  Future<void> getAllAccounts(String userId) async {
    loading = true;
    final response = await _service.getAll(userId);
    loading = false;
    _accounts = response;
    if (!isEmptyData(_accountSelected)) {
      _accountSelected = _accounts.firstWhere(
          (item) => item.id == _accountSelected.id,
          orElse: () => Account(accountName: '', id: ''));
    }
    notifyListeners();
  }

  Future<dynamic> createAccount(Account body) async {
    EasyLoading.show();
    final response = await _service.createAccount(body);
    EasyLoading.dismiss();
    return response;
  }

  Future<dynamic> updateAccount(String accountId, Account body) async {
    EasyLoading.show();
    final response = await _service.updateAccount(accountId, body);
    EasyLoading.dismiss();
    return response;
  }

  Future<dynamic> deleteAccount(String accountId) async {
    EasyLoading.show();
    final response = await _service.deleteAccount(accountId);
    EasyLoading.dismiss();
    return response;
  }

  void setAccountSelected(Account account) {
    _accountSelected = account;
    notifyListeners();
  }
}
