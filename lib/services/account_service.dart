import 'dart:convert';
import 'package:money_management/model/account.dart';
import 'package:money_management/services/api_routes.dart';
import 'package:money_management/services/request.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:money_management/utils/data_utils.dart';

class AccountService {
  Request request = Request();
  Future<List<Account>> getAll(String userId) async {
    final Map<String, String> params = {
      'userId': 'eq.$userId',
      'order': 'created_at.desc'
    };
    final url = generateUrlFromParams(ApiRoutes.account, params);
    final response = await request.get(url);
    if (response.statusCode == 200) {
      final json = jsonDecode(response.body) as List;
      return json
          .map(
            (user) => Account.fromMap(user),
          )
          .toList();
    }
    return [];
  }

  Future<dynamic> createAccount(Account body) async {
    const url = ApiRoutes.account;
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

  Future<dynamic> updateAccount(String accountId, Account body) async {
    final Map<String, String> params = {'id': 'eq.$accountId'};
    final url = generateUrlFromParams(ApiRoutes.account, params);
    final jsonBody = body.toJsonWithId();
    final response = await request.put(url, jsonBody);
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

  Future<dynamic> deleteAccount(String accountId) async {
    final Map<String, String> params = {'id': 'eq.$accountId'};
    final url = generateUrlFromParams(ApiRoutes.account, params);
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
}
