class ExpendModel {
  final String? id;
  final String accountId;
  final int? amount;
  final String? description;
  final String? categoryId;
  final String? dateTime;
  ExpendModel({
    required this.accountId,
    this.amount,
    this.description,
    this.id,
    this.categoryId,
    this.dateTime,
  });

  factory ExpendModel.fromMap(Map<String, dynamic> map) {
    return ExpendModel(
      id: map['id'],
      accountId: map['accountId'],
      amount: map['amount'],
      description: map['description'],
      categoryId: map['categoryId'],
      dateTime: map['dateTime'],
    );
  }
  Map<String, dynamic> toJson() {
    return {
      'accountId': accountId,
      'amount': amount,
      'description': description,
      'categoryId': categoryId,
      'dateTime': dateTime
    };
  }
}
