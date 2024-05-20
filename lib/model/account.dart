class Account {
  final String? id;
  final String accountName;
  final int accountBalance;
  final String description;
  Account(
      {required this.accountName,
      required this.accountBalance,
      required this.description,
      this.id});

  factory Account.fromMap(Map<String, dynamic> map) {
    return Account(
      id: map['id'],
      accountName: map['accountName'],
      accountBalance: map['accountBalance'],
      description: map['description'],
    );
  }
  Map<String, dynamic> toJson() {
    return {
      'accountName': accountName,
      'accountBalance': accountBalance,
      'description': description
    };
  }
}
