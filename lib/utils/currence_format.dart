String formatCurrency(dynamic value, [bool isDecimal = false]) {
  // Kiểm tra giá trị đầu vào có phải là số âm hay không
  bool isNegative = false;
  String stringValue = value.toString();
  if (stringValue.startsWith('-')) {
    isNegative = true;
    // Loại bỏ dấu trừ (-)
    stringValue = stringValue.substring(1);
  }

  // Xóa các ký tự không phải số khỏi giá trị nhập vào
  String cleanValue = stringValue.replaceAll(RegExp(r'[^0-9]'), '');
  // Chuyển đổi giá trị sang số nguyên
  int intValue = int.tryParse(cleanValue) ?? 0;

  // Định dạng số nguyên thành định dạng tiền tệ VND
  String formattedValue = intValue.toString().replaceAllMapped(
      RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'), (Match m) => '${m[1]}.');
  // Nếu giá trị ban đầu là số âm, thêm dấu trừ vào kết quả
  if (isNegative) {
    formattedValue = '-$formattedValue';
  }

  if (isDecimal) return '$formattedValue ₫';
  return formattedValue;
}

int parseCurrency(String value) {
  // Xóa các ký tự không phải số khỏi giá trị nhập vào
  String cleanValue = value.replaceAll(RegExp(r'[^0-9]'), '');
  // Chuyển đổi giá trị thành số nguyên
  int intValue = int.tryParse(cleanValue) ?? 0;
  return intValue;
}
