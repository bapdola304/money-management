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
