import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart'; // Import flutter_spinkit

import '../../../utils/logger.dart';
import '../data/login_repository.dart';

class LoginViewModel extends ChangeNotifier {
  final AuthRepository _authRepository;
  bool _isLoading = false;
  String? _errorMessage;
  String? _navigationRoute;

  LoginViewModel(this._authRepository);

  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;
  String? get navigationRoute => _navigationRoute;

  void setIsLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }

  Future<void> login(String email, String password, BuildContext context) async {
    setIsLoading(true); // Set isLoading to true before API call
    _errorMessage = null;
    _navigationRoute = null;
    notifyListeners();

    try {
      final loginResponse = await _authRepository.login(email, password);
      logDebug('Login successful: ${loginResponse.message}');

      SharedPreferences prefs = await SharedPreferences.getInstance();
      await prefs.setString('user_id', loginResponse.data.id);
      await prefs.setString('user_type', loginResponse.data.type);

      switch (loginResponse.data.type) {
        case 'Superwiser':
          _navigationRoute = '/supervisor_home';
          break;
        case 'Accountant':
          _navigationRoute = '/accountant_home';
          break;
        case 'Superadmin':
          _navigationRoute = '/super_admin_home';
          break;
        default:
          _navigationRoute = '/available_students';
      }

      logDebug('Navigation result: $_navigationRoute');
    } catch (e) {
      _errorMessage = e.toString();
      logDebug('Error during login: $e');

      // Notify listeners so the UI can update
      notifyListeners();

      // Display the error message in a Snackbar if context is available
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(_errorMessage!)),
        );
      }
    } finally {
      setIsLoading(false); // Set isLoading to false after API call completes
    }
  }

  Future<void> logout(BuildContext context) async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();

      String? userId = prefs.getString('user_id');
      String? userType = prefs.getString('user_type');
      logDebug('Current user ID: $userId');
      logDebug('Current user type: $userType');

      await prefs.remove('user_id');
      await prefs.remove('user_type');

      logDebug('User session cleared.');

      Navigator.pushNamedAndRemoveUntil(
        context,
        '/login',
            (Route<dynamic> route) => false,
      );
    } catch (e) {
      logDebug('Logout error: $e');
    }
  }
}
