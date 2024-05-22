import 'package:flutter/material.dart';
import 'package:money_management/model/expend.dart';
import 'package:money_management/services/expend_service.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

class ExpendProvider extends ChangeNotifier {
  BuildContext context;
  ExpendProvider(this.context);
  final _service = ExpendService();
  List<ExpendModel> _expendList = [];
  List<ExpendModel> get expendList => _expendList;

  Future<List<ExpendModel>> getAllExpend(String accountId) async {
    EasyLoading.show();
    final response = await _service.getAll(accountId);
    EasyLoading.dismiss();
    _expendList = response;
    notifyListeners();
    return response;
  }

  Future<dynamic> createExpend(ExpendModel body) async {
    EasyLoading.show();
    final response = await _service.createExpend(body);
    EasyLoading.dismiss();
    return response;
  }
}
