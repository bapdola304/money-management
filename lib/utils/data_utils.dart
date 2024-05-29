bool isEmptyData(dynamic data) {
  if (data == null) {
    return true;
  }

  if (data is String && data.isEmpty) {
    return true;
  }

  if (data is List && data.isEmpty) {
    return true;
  }

  if (data is Map && data.isEmpty) {
    return true;
  }

  return false;
}

String generateUrlFromParams(String url, Map<String, String?> params) {
  // Tạo một danh sách các phần tử từ các cặp key-value trong params
  List<String> queryParams = params.entries
      .where((entry) => entry.value != null) // Lọc ra các giá trị không null
      .map((entry) {
    // Tạo phần tử của query nếu giá trị không null
    return '${entry.key}=${entry.value}';
  }).toList();

  // Kết hợp các phần tử của danh sách queryParams thành một chuỗi
  String queryString = queryParams.join('&');

  // Tạo path dựa trên chuỗi query
  String path = '$url?$queryString';

  return path;
}
