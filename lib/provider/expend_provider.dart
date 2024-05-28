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
  List<ExpendModel> _expendListByDate = [];
  List<ExpendModel> get expendListByDate => _expendListByDate;
  bool loading = false;

  Future<List<ExpendModel>> getAllExpend(String accountId) async {
    loading = true;
    final response = await _service.getAll(accountId);
    loading = false;
    _expendList = response;
    notifyListeners();
    return response;
  }

  Future<List<ExpendModel>> getExpendsByDate(
      String? startDate, String? endDate, String userId) async {
    setLoading(true);
    final response =
        await _service.getExpendsByDate(startDate, endDate, userId);
    loading = false;
    _expendListByDate = response;
    notifyListeners();
    return response;
  }

  Future<dynamic> createExpend(ExpendRequestModel body) async {
    EasyLoading.show();
    final response = await _service.createExpend(body);
    EasyLoading.dismiss();
    return response;
  }

  Future<dynamic> deleteExpend(String expendId) async {
    EasyLoading.show();
    final response = await _service.deleteExpend(expendId);
    EasyLoading.dismiss();
    return response;
  }

  Future<dynamic> updateExpend(String expendId, ExpendRequestModel body) async {
    EasyLoading.show();
    final response = await _service.updateExpend(expendId, body);
    EasyLoading.dismiss();
    return response;
  }

  setLoading(bool value) {
    loading = value;
    if (value) {
      notifyListeners();
    }
  }
}
