import 'package:money_management/model/category.dart';

class ExpendModel {
  final String? accountId;
  final int? amount;
  final String? description;
  final String? id;
  final String? categoryId;
  final DateTime? dateTime;
  final CategoryModel? category;
  final String? transactionType;

  ExpendModel(
      {required this.accountId,
      this.amount,
      this.description,
      this.id,
      this.categoryId,
      this.dateTime,
      this.transactionType,
      this.category});

  // Phương thức để chuyển đổi từ JSON thành đối tượng ExpendModel
  factory ExpendModel.fromJson(Map<String, dynamic> json) {
    return ExpendModel(
        accountId: json['accountId'],
        amount: json['amount'],
        description: json['description'],
        id: json['id'],
        categoryId: json['categoryId'],
        category: json['category'] != null
            ? CategoryModel.fromMap(json['category'])
            : null,
        dateTime:
            json['dateTime'] != null ? DateTime.parse(json['dateTime']) : null,
        transactionType: json['transactionType']);
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
      'category': category?.toJson(),
      'transactionType': transactionType
    };
  }
}

class ExpendRequestModel {
  final String accountId;
  final int? amount;
  final String? description;
  final String? categoryId;
  final DateTime? dateTime;
  final String? transactionType;
  final String? id;
  final String? userId;

  ExpendRequestModel(
      {required this.accountId,
      this.amount,
      this.description,
      this.categoryId,
      this.dateTime,
      this.id,
      this.userId,
      this.transactionType});

  Map<String, dynamic> toJson() {
    return {
      'accountId': accountId,
      'amount': amount,
      'description': description,
      'categoryId': categoryId,
      'dateTime': dateTime?.toIso8601String(),
      'transactionType': transactionType,
      'userId': userId
    };
  }

  Map<String, dynamic> toJsonWithId() {
    return {
      'accountId': accountId,
      'amount': amount,
      'description': description,
      'categoryId': categoryId,
      'dateTime': dateTime?.toIso8601String(),
      'transactionType': transactionType,
      'id': id
    };
  }
}
