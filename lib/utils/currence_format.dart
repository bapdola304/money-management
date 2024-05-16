String formatCurrency(String value) {
  // Xóa các ký tự không phải số khỏi giá trị nhập vào
  String cleanValue = value.replaceAll(RegExp(r'[^0-9]'), '');
  // Chuyển đổi giá trị sang số nguyên
  int intValue = int.tryParse(cleanValue) ?? 0;
  // Định dạng số nguyên thành định dạng tiền tệ VND
  String formattedValue = intValue.toString().replaceAllMapped(
      RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'), (Match m) => '${m[1]}.');
  return formattedValue;
}
