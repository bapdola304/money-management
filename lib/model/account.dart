class Account {
  final String? id;
  final String accountName;
  final int? accountBalance;
  final String? description;
  final String? userId;
  Account({
    required this.accountName,
    this.accountBalance,
    this.description,
    this.id,
    this.userId,
  });

  factory Account.fromMap(Map<String, dynamic> map) {
    return Account(
      id: map['id'],
      accountName: map['accountName'],
      accountBalance: map['accountBalance'],
      description: map['description'],
      userId: map['userId'],
    );
  }
  Map<String, dynamic> toJson() {
    return {
      'accountName': accountName,
      'accountBalance': accountBalance,
      'description': description,
      'userId': userId
    };
  }
}

class AccountRequestModel {
  final String accountName;
  final int? accountBalance;
  final String? description;
  final String? userId;
  final String? id;

  AccountRequestModel({
    this.id,
    required this.accountName,
    this.accountBalance,
    this.description,
    this.userId,
  });

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'accountName': accountName,
      'accountBalance': accountBalance,
      'description': description,
      'userId': userId
    };
  }
}
