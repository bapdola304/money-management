import 'dart:convert';
import 'package:money_management/model/expend.dart';
import 'package:money_management/services/request.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

class ExpendService {
  Request request = Request();
  Future<List<ExpendModel>> getAll(String accountId) async {
    final url =
        '/expend?select=*,category(id,name, icon(image))&accountId=eq.$accountId&order=dateTime.desc';
    final response = await request.get(url);
    if (response.statusCode == 200) {
      final json = jsonDecode(response.body) as List;
      return json
          .map(
            (expend) => ExpendModel.fromJson(expend),
          )
          .toList();
    }
    final json = jsonDecode(response.body);
    EasyLoading.showError('Có lỗi xảy ra: ${json['message']}',
        maskType: EasyLoadingMaskType.clear,
        duration: const Duration(seconds: 5));
    return [];
  }

  Future<dynamic> createExpend(ExpendRequestModel body) async {
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

  Future<dynamic> deleteExpend(String expendId) async {
    final url = '/expend?id=eq.$expendId';
    final response = await request.delete(url);
    if (response.statusCode == 204) {
      return response;
    }
    final json = jsonDecode(response.body);
    EasyLoading.showError('Có lỗi xảy ra: ${json['message']}',
        maskType: EasyLoadingMaskType.clear,
        dismissOnTap: true,
        duration: const Duration(seconds: 5));
    return null;
  }

  Future<dynamic> updateExpend(String expendId, ExpendRequestModel body) async {
    final url = '/expend?id=eq.$expendId';
    final response = await request.put(url, body);
    if (response.statusCode == 204) {
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
