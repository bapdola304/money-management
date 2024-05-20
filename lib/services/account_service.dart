import 'dart:convert';
import 'package:money_management/model/account.dart';
import 'package:money_management/model/user.dart';
import 'package:money_management/services/request.dart';

class AccountService {
  Request request = Request();
  Future<List<Account>> getAll(String userId) async {
    final url = '/account?id.eq=$userId';
    final response = await request.get(url);
    if (response.statusCode == 200) {
      final json = jsonDecode(response.body) as List;
      return json
          .map(
            (user) => Account.fromMap(user),
          )
          .toList();
    }
    return [];
  }

  Future<dynamic> singUpUser(User body) async {
    const url = '/user';
    final response = await request.post(url, body);
    return response;
  }
}
