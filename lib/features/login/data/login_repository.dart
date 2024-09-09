import 'dart:convert';
import 'package:http/http.dart' as http;
import '../../../utils/constants/logger.dart';
import 'login_model.dart';

class AuthRepository {
  final String _baseUrl = 'https://library.mechodal.com/login.php';

  Future<LoginModel> login(String email, String password) async {
    final response = await http.post(
      Uri.parse(_baseUrl),
      body: {
        'email': email,
        'password': password,
      },
    );

    logDebug('Response status: ${response.statusCode}');
    logDebug('Response body: ${response.body}');

    if (response.statusCode == 200) {
      return LoginModel.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to login');
    }
  }
}
