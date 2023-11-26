import 'package:flutter_app_new/auth/domain/repository/auth_repository.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';
import 'dart:convert' as convert;

class AuthRepositoryImpl extends AuthRepository {
  @override
  Future<Response> onGetAuthEvent(String username, String email) async {
    try {
      final response = await http.post(
        Uri.parse("http://localhost:3000/rest/user/register"),
        body: convert.jsonEncode({
          'username': username,
          'email': email,
        }),
      );
      return response;
    } catch (_) {
      throw Exception('Ошибка!');
    }
  }
}
