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
    const url = '/category?select=*,icon(image)';
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
}
