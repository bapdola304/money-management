import 'package:flutter/material.dart';
import 'package:money_management/model/icon.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:money_management/services/category_service.dart';

class CategoryProvider extends ChangeNotifier {
  BuildContext context;
  CategoryProvider(this.context);
  final _service = CategoryService();
  List<IconModel> _icons = [];
  List<IconModel> get icons => _icons;

  Future<void> getIcons() async {
    EasyLoading.show();
    final response = await _service.getIcons();
    EasyLoading.dismiss();
    _icons = response;
    notifyListeners();
  }
}
