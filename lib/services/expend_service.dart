import 'dart:convert';
import 'package:money_management/model/expend.dart';
import 'package:money_management/services/request.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

class ExpendService {
  Request request = Request();
  Future<List<ExpendModel>> getAll(String userId) async {
    final url = '/expend?order=created_at.desc';
    final response = await request.get(url);
    if (response.statusCode == 200) {
      final json = jsonDecode(response.body) as List;
      return json
          .map(
            (user) => ExpendModel.fromMap(user),
          )
          .toList();
    }
    final json = jsonDecode(response.body);
    EasyLoading.showError('Có lỗi xảy ra: ${json['message']}',
        maskType: EasyLoadingMaskType.clear,
        duration: const Duration(seconds: 5));
    return [];
  }

  Future<dynamic> createExpend(ExpendModel body) async {
    const url = '/expend';
    final response = await request.post(url, body);
    if (response.statusCode == 201) {
      return response;
    }
    final json = jsonDecode(response.body);
    EasyLoading.showError('Có lỗi xảy ra: ${json['message']}',
        maskType: EasyLoadingMaskType.clear,
        dismissOnTap: true,
        duration: const Duration(seconds: 5));
    return null;
  }
}
