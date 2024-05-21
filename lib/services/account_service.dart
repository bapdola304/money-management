import 'dart:convert';
import 'package:money_management/model/account.dart';
import 'package:money_management/services/request.dart';

class AccountService {
  Request request = Request();
  Future<List<Account>> getAll(String userId) async {
    final url = '/account?userId=eq.$userId&order=created_at.desc';
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

  Future<dynamic> createAccount(Account body) async {
    const url = '/account';
    final response = await request.post(url, body);
    return response;
  }
}
