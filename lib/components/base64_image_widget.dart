import 'package:flutter/material.dart';
import 'dart:convert';
import 'dart:typed_data';

class Base64ImageWidget extends StatelessWidget {
  final String? base64String;

  Base64ImageWidget({this.base64String});

  @override
  Widget build(BuildContext context) {
    if (base64String == null) return Image.asset('assets/icons/empty_icon.png');
    // Loại bỏ tiền tố "data:image/png;base64,"
    String base64StringWithoutPrefix = base64String!.split(',').last;

    // Chuyển đổi base64 thành Uint8List
    Uint8List bytes = base64Decode(base64StringWithoutPrefix);

    return Image.memory(bytes, width: 60);
  }
}
