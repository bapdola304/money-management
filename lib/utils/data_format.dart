import 'dart:convert';
import 'package:intl/intl.dart';
import 'package:money_management/model/expend.dart';

List<Map<String, dynamic>> groupAndFormatByDate(List<ExpendModel> dataList) {
  Map<String, List<ExpendModel>> groupedByDate = {};

  // Nhóm các mục theo ngày
  for (var item in dataList) {
    if (item.dateTime == null) continue;

    String day = DateFormat('dd').format(item.dateTime!);
    String monthYear = DateFormat('MM/yyyy').format(item.dateTime!);

    String dateKey = '{"day": "$day", "month_year": "$monthYear"}';

    if (groupedByDate.containsKey(dateKey)) {
      groupedByDate[dateKey]!.add(item);
    } else {
      groupedByDate[dateKey] = [item];
    }
  }

  // Tạo danh sách kết quả cuối cùng với tổng amount cho từng ngày
  List<Map<String, dynamic>> groupedData = groupedByDate.entries.map((entry) {
    Map<String, dynamic> dateKey = jsonDecode(entry.key);
    List<Map<String, dynamic>> items =
        entry.value.map((item) => item.toJson()).toList();

    // Tính tổng amount cho các mục trong cùng một ngày
    int totalAmount =
        entry.value.fold(0, (sum, item) => sum + (item.amount ?? 0));

    return {
      'date': dateKey,
      'items': items,
      'totalAmount': totalAmount,
    };
  }).toList();

  return groupedData;
}
