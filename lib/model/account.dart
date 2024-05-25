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

  Map<String, dynamic> toJsonWithId() {
    return {
      'accountName': accountName,
      'accountBalance': accountBalance,
      'description': description,
      'userId': userId,
      'id': id,
    };
  }
}
