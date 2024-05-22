import 'dart:convert';
import 'package:intl/intl.dart';
import 'package:money_management/model/expend.dart';

// Hàm tổng hợp để nhóm và định dạng các đối tượng theo ngày
List<Map<String, dynamic>> groupAndFormatByDate(List<ExpendModel> dataList) {
  // Bước 2: Nhóm các đối tượng theo ngày
  Map<String, List<ExpendModel>> groupedByDate = {};

  for (var item in dataList) {
    // Bỏ qua nếu dateTime là null
    if (item.dateTime == null) continue;

    // Định dạng ngày
    String day = DateFormat('dd').format(item.dateTime!);
    String monthYear = DateFormat('MM/yyyy').format(item.dateTime!);

    // Tạo khóa ngày với định dạng yêu cầu
    String dateKey = '{"day": "$day", "month_year": "$monthYear"}';

    // Nhóm các đối tượng theo ngày đã định dạng
    if (groupedByDate.containsKey(dateKey)) {
      groupedByDate[dateKey]!.add(item);
    } else {
      groupedByDate[dateKey] = [item];
    }
  }

  // Bước 3: Chuyển đổi Map thành danh sách các đối tượng chứa ngày và danh sách các đối tượng có cùng ngày
  List<Map<String, dynamic>> groupedData = groupedByDate.entries.map((entry) {
    return {
      'date': jsonDecode(entry.key),
      'items': entry.value.map((item) => item.toJson()).toList(),
    };
  }).toList();

  return groupedData;
}
