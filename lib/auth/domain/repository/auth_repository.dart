import 'package:http/http.dart';

abstract class AuthRepository {
  Future<Response> onGetAuthEvent(String username, String email);
}
