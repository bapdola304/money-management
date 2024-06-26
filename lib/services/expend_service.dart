import 'dart:convert';
import 'package:money_management/model/expend.dart';
import 'package:money_management/services/api_routes.dart';
import 'package:money_management/services/request.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:money_management/utils/data_utils.dart';
import 'package:flutter/material.dart';

class ExpendService {
  Request request = Request();
  Future<List<ExpendModel>> getAll(String accountId) async {
    final Map<String, String> params = {
      'select': '*,category(id,name, icon(image))',
      'accountId': 'eq.$accountId',
      'order': 'dateTime.desc'
    };
    final url = generateUrlFromParams(ApiRoutes.expend, params);
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

  Future<List<ExpendModel>> getExpendsByDate(
      String? startDate, String? endDate, String userId) async {
    final Map<String, String?> params = {
      'select':
          'amount,transactionType,dateTime,id, category(id,name, icon(image)), account(*)',
      'userId': 'eq.$userId',
      'dateTime': isEmptyData(startDate)
          ? null
          : 'gte.$startDate&dateTime=lte.$endDate',
      'order': 'dateTime.desc'
    };
    final url = generateUrlFromParams(ApiRoutes.expend, params);
    debugPrint(url);
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
    const url = ApiRoutes.expend;
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
    final Map<String, String> params = {'id': 'eq.$expendId'};
    final url = generateUrlFromParams(ApiRoutes.expend, params);
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
    final Map<String, String> params = {'id': 'eq.$expendId'};
    final url = generateUrlFromParams(ApiRoutes.expend, params);
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
}
