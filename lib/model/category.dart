import 'package:money_management/model/icon.dart';

class CategoryModel {
  final String? id;
  final String name;
  final String iconId;
  final bool? isFavorite;
  final IconModel? icon;
  CategoryModel(
      {required this.name,
      required this.iconId,
      this.isFavorite,
      this.id,
      this.icon});

  factory CategoryModel.fromMap(Map<String, dynamic> map) {
    return CategoryModel(
      id: map['id'],
      name: map['name'],
      iconId: map['iconId'],
      isFavorite: map['isFavorite'],
      icon: map['icon'] != null ? IconModel.fromMap(map['icon']) : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {'name': name, 'iconId': iconId, 'isFavorite': isFavorite};
  }
}
