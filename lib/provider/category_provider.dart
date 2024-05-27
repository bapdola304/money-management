import 'package:flutter/material.dart';
import 'package:money_management/model/category.dart';
import 'package:money_management/model/icon.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:money_management/services/category_service.dart';

class CategoryProvider extends ChangeNotifier {
  BuildContext context;
  CategoryProvider(this.context);
  final _service = CategoryService();
  List<IconModel> _icons = [];
  List<IconModel> get icons => _icons;
  List<CategoryModel> _categoryList = [];
  List<CategoryModel> get categoryList => _categoryList;
  String _categoryIdSelected = '';
  String? get categoryIdSelected => _categoryIdSelected;
  CategoryModel _categorySelected =
      CategoryModel(name: '', id: '', iconId: '', isFavorite: false);
  CategoryModel get categorySelected => _categorySelected;
  bool loading = false;

  Future<void> getIcons() async {
    EasyLoading.show();
    final response = await _service.getIcons();
    EasyLoading.dismiss();
    _icons = response;
    notifyListeners();
  }

  Future<dynamic> createCategory(CategoryRequestModel body) async {
    EasyLoading.show();
    final response = await _service.createCategory(body);
    EasyLoading.dismiss();
    return response;
  }

  Future<void> getCategoryList() async {
    loading = true;
    final response = await _service.getCategoryList();
    loading = false;
    _categoryList = response;
    if (_categoryIdSelected != '') {
      _categorySelected =
          _categoryList.firstWhere((item) => item.id == _categoryIdSelected);
    }
    notifyListeners();
  }

  Future<dynamic> deleteCategory(String categoryId) async {
    EasyLoading.show();
    final response = await _service.deleteCategory(categoryId);
    EasyLoading.dismiss();
    return response;
  }

  Future<dynamic> updateCategory(
      String categoryId, CategoryRequestModel body) async {
    EasyLoading.show();
    final response = await _service.updateCategory(categoryId, body);
    EasyLoading.dismiss();
    return response;
  }

  Future<dynamic> updateCategoryFavorite(
      String categoryId, CategoryFavoriteModel body) async {
    EasyLoading.show();
    final response = await _service.updateCategoryFavorite(categoryId, body);
    EasyLoading.dismiss();
    return response;
  }

  void setCategoryIdSelected(String categoryId) {
    _categoryIdSelected = categoryId;
    notifyListeners();
  }
}
