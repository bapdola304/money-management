enum TransactionType {
  expense('expense'),
  income('income');

  final String value;

  const TransactionType(this.value);

  @override
  String toString() => value;

  static TransactionType fromIndex(int index) {
    return TransactionType.values[index];
  }

  static TransactionType fromString(String value) {
    return TransactionType.values.firstWhere((type) => type.value == value);
  }
}
