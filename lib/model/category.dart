import 'package:money_management/model/icon.dart';

class CategoryModel {
  final String? id;
  final String? name;
  final String iconId;
  final bool? isFavorite;
  final IconModel? icon;
  final String? transactionType;

  CategoryModel(
      {required this.name,
      required this.iconId,
      this.isFavorite,
      this.id,
      this.icon,
      this.transactionType});

  factory CategoryModel.fromMap(Map<String, dynamic> map) {
    return CategoryModel(
      id: map['id'],
      name: map['name'] != null ? map['name'] : "",
      iconId: map['iconId'] != null ? map['iconId'] : "",
      isFavorite: map['name'] != null ? map['isFavorite'] : false,
      icon: map['icon'] != null ? IconModel.fromMap(map['icon']) : null,
      transactionType: map['transactionType'] ?? "",
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'iconId': iconId,
      'isFavorite': isFavorite,
      'icon': icon?.toJson(),
      'transactionType': transactionType
    };
  }
}

class CategoryRequestModel {
  final String? id;
  final String? name;
  final String iconId;
  final bool? isFavorite;
  final String? transactionType;

  CategoryRequestModel(
      {required this.name,
      required this.iconId,
      this.isFavorite,
      this.id,
      this.transactionType});

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'iconId': iconId,
      'isFavorite': isFavorite,
      'transactionType': transactionType
    };
  }
}
