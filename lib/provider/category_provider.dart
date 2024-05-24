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
  CategoryModel _categorySelected = CategoryModel(name: '', id: '', iconId: '');
  CategoryModel get categorySelected => _categorySelected;

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
    EasyLoading.show();
    final response = await _service.getCategoryList();
    EasyLoading.dismiss();
    _categoryList = response;
    if (_categoryIdSelected != '') {
      _categorySelected =
          _categoryList.firstWhere((item) => item.id == _categoryIdSelected);
    }
    notifyListeners();
  }

  void setCategoryIdSelected(String categoryId) {
    _categoryIdSelected = categoryId;
    notifyListeners();
  }
}
