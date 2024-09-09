import 'package:flutter/material.dart';
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

  Future<void> login(String email, String password) async {
    _isLoading = true;
    _errorMessage = null;
    _navigationRoute = null; // Reset the route
    notifyListeners();

    try {
      final loginResponse = await _authRepository.login(email, password);
      logDebug('Login successful: ${loginResponse.message}');

      // Determine the page based on user type
      switch (loginResponse.data.type) {
        case 'Superwiser':
          _navigationRoute = '/supervisor_home'; // Adjust with your actual route
          break;
        case 'Accountant':
          _navigationRoute = '/accountant_home'; // Adjust with your actual route
          break;
        case 'Superadmin':
          _navigationRoute = '/super_admin_home'; // Adjust with your actual route
          break;
        default:
          _navigationRoute = '/available_students'; // Adjust with a default route if needed
      }



      logDebug('Navigation result: $_navigationRoute');
    } catch (e) {
      _errorMessage = 'Failed to login: $e';
      logDebug(_errorMessage!);
    } finally {
      _isLoading = false;
      notifyListeners();
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
