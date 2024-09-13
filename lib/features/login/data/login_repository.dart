import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:library_app/res/app_url/app_url.dart';
import '../../../data/app_excaption.dart';
import '../../../utils/logger.dart';
import '../../../utils/utils.dart';
import 'login_model.dart';

class AuthRepository {

  Future<LoginModel> login(String email, String password) async {
    try {
      final response = await http.post(
        Uri.parse(AppUrl.loginApi),
        body: {
          'email': email,
          'password': password,
        },
      );

      logDebug('Response status: ${response.statusCode}');
      logDebug('Response body: ${response.body}');

      final responseJson = json.decode(response.body);

      if (response.statusCode == 200) {
        if (responseJson['status'] == 'error') {
          // Using Utils to display error message
          Utils.snackBar('Login Error', responseJson['message']);
          //throw FetchDataException(responseJson['message']);
          throw AppExceptions(responseJson['message'], 'Login Error: ');
        }

        return LoginModel.fromJson(responseJson);
      } else {
        // Display error message
        Utils.snackBar('Login Failed', 'Failed to login with status code ${response.statusCode}');
        throw FetchDataException('Failed to login with status code ${response.statusCode}');
      }
    } catch (e) {
      logDebug('Login error: $e');
      Utils.snackBar('Login Error', 'An unexpected error occurred: $e');
      throw FetchDataException('$e');
    //  throw FetchDataException('An unexpected error occurred: $e');
    }
  }


}
