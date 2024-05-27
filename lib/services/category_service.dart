import 'dart:convert';
import 'package:money_management/model/category.dart';
import 'package:money_management/model/icon.dart';
import 'package:money_management/services/request.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

class CategoryService {
  Request request = Request();
  Future<List<IconModel>> getIcons() async {
    const url = '/icon';
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
    const url = '/category';
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
    const url = '/category?select=*,icon(id, image)';
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
    final url = '/category?id=eq.$categoryId';
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
    final url = '/category?id=eq.$categoryId';
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
    final url = '/category?id=eq.$categoryId';
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
