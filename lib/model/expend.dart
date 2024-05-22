import 'package:money_management/model/category.dart';
import 'dart:convert';

class ExpendModel {
  final String accountId;
  final int? amount;
  final String? description;
  final String? id;
  final String? categoryId;
  final DateTime? dateTime;
  final CategoryModel? category;

  ExpendModel(
      {required this.accountId,
      this.amount,
      this.description,
      this.id,
      this.categoryId,
      this.dateTime,
      this.category});

  // Phương thức để chuyển đổi từ JSON thành đối tượng ExpendModel
  factory ExpendModel.fromJson(Map<String, dynamic> json) {
    return ExpendModel(
      accountId: json['accountId'],
      amount: json['amount'],
      description: json['description'],
      id: json['id'],
      categoryId: json['categoryId'],
      category: CategoryModel.fromMap(jsonDecode(json['category'])),
      dateTime:
          json['dateTime'] != null ? DateTime.parse(json['dateTime']) : null,
    );
  }

  // Phương thức để chuyển đổi từ đối tượng ExpendModel thành JSON
  Map<String, dynamic> toJson() {
    return {
      'accountId': accountId,
      'amount': amount,
      'description': description,
      'id': id,
      'categoryId': categoryId,
      'dateTime': dateTime?.toIso8601String(),
    };
  }
}
