import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../utils/constants/logger.dart';
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

  Future<void> login(String email, String password,
      BuildContext context) async {
    _isLoading = true;
    _errorMessage = null;
    _navigationRoute = null; // Reset the route
    notifyListeners();

    try {
      final loginResponse = await _authRepository.login(email, password);
      logDebug('Login successful: ${loginResponse.message}');

      // Store user session
      SharedPreferences prefs = await SharedPreferences.getInstance();
      await prefs.setString('user_id', loginResponse.data.id);
      await prefs.setString('user_type', loginResponse.data.type);

      // Determine the page based on user type
      switch (loginResponse.data.type) {
        case 'Superwiser':
          _navigationRoute =
          '/supervisor_home'; // Adjust with your actual route
          break;
        case 'Accountant':
          _navigationRoute =
          '/accountant_home'; // Adjust with your actual route
          break;
        case 'Superadmin':
          _navigationRoute =
          '/super_admin_home'; // Adjust with your actual route
          break;
        default:
          _navigationRoute =
          '/available_students'; // Adjust with a default route if needed
      }


      logDebug('Navigation result: $_navigationRoute');
    } catch (e) {
      _errorMessage = '$e';
      logDebug(_errorMessage!);

      // Display the error message in a Snackbar
      if (context != null) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(_errorMessage!)),
        );
      }
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> logout(BuildContext context) async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();

      // Log the current user session before clearing
      String? userId = prefs.getString('user_id');
      String? userType = prefs.getString('user_type');
      logDebug('Current user ID: $userId');
      logDebug('Current user type: $userType');

      // Remove user session data
      await prefs.remove('user_id');
      await prefs.remove('user_type');

      // Log that the user session has been cleared
      logDebug('User session cleared.');

      // Navigate to the login screen
      Navigator.pushNamedAndRemoveUntil(
        context,
        '/login', // Redirect to login screen
            (Route<dynamic> route) => false,
      );

      // Log that navigation to the login screen has been initiated
      logDebug('Navigating to login screen.');
    } catch (e) {
      // Log any exceptions that occur during logout
      logDebug('An error occurred during logout: $e');
    }
  }

}



// import 'package:flutter/material.dart';
// import '../../../utils/constants/logger.dart';
// import '../data/login_repository.dart';
//
// class LoginViewModel extends ChangeNotifier {
//   final AuthRepository _authRepository;
//   bool _isLoading = false;
//   String? _errorMessage;
//
//   LoginViewModel(this._authRepository);
//
//   bool get isLoading => _isLoading;
//   String? get errorMessage => _errorMessage;
//
//   Future<void> login(String email, String password) async {
//     _isLoading = true;
//     _errorMessage = null;
//     notifyListeners();
//
//     try {
//       final loginResponse = await _authRepository.login(email, password);
//       // Handle successful login
//       logDebug('Login successful: ${loginResponse.message}');
//       // Navigate to Home or any other screen
//     } catch (e) {
//       _errorMessage = 'Failed to login: $e';
//       logDebug(_errorMessage!);
//     } finally {
//       _isLoading = false;
//       notifyListeners();
//     }
//   }
// }
