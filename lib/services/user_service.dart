import 'dart:convert';
import 'package:money_management/model/user.dart';
import 'package:money_management/services/api_routes.dart';
import 'package:money_management/services/request.dart';

class UserService {
  Request request = Request();
  Future<List<User>> getAll() async {
    const url = ApiRoutes.user;
    final response = await request.get(url);
    if (response.statusCode == 200) {
      final json = jsonDecode(response.body) as List;
      return json
          .map(
            (user) => User.fromMap(user),
          )
          .toList();
    }
    return [];
  }

  Future<dynamic> singUpUser(User body) async {
    const url = ApiRoutes.user;
    final response = await request.post(url, body);
    return response;
  }
}
