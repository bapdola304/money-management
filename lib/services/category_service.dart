import 'dart:convert';
import 'package:money_management/model/category.dart';
import 'package:money_management/model/icon.dart';
import 'package:money_management/services/api_routes.dart';
import 'package:money_management/services/request.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:money_management/utils/data_utils.dart';

class CategoryService {
  Request request = Request();
  Future<List<IconModel>> getIcons() async {
    const url = ApiRoutes.icon;
    final response = await request.get(url);
    if (response.statusCode == 200) {
      final json = jsonDecode(response.body) as List;
      return json
          .map(
            (icon) => IconModel.fromMap(icon),
          )
          .toList();
    }
    EasyLoading.showError('Có lỗi xảy ra!');
    return [];
  }

  Future<dynamic> createCategory(CategoryRequestModel body) async {
    const url = ApiRoutes.category;
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

  Future<List<CategoryModel>> getCategoryList() async {
    final Map<String, String> params = {'select': '*,icon(id, image)'};
    final url = generateUrlFromParams(ApiRoutes.category, params);
    final response = await request.get(url);
    if (response.statusCode == 200) {
      final json = jsonDecode(response.body) as List;
      return json
          .map(
            (icon) => CategoryModel.fromMap(icon),
          )
          .toList();
    }
    EasyLoading.showError('Có lỗi xảy ra!');
    return [];
  }

  Future<dynamic> deleteCategory(String categoryId) async {
    final Map<String, String> params = {'id': 'eq.$categoryId'};
    final url = generateUrlFromParams(ApiRoutes.category, params);
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

  Future<dynamic> updateCategory(
      String categoryId, CategoryRequestModel body) async {
    final Map<String, String> params = {'id': 'eq.$categoryId'};
    final url = generateUrlFromParams(ApiRoutes.category, params);
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

  Future<dynamic> updateCategoryFavorite(
      String categoryId, CategoryFavoriteModel body) async {
    final Map<String, String> params = {'id': 'eq.$categoryId'};
    final url = generateUrlFromParams(ApiRoutes.category, params);
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
