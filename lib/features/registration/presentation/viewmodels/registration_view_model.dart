// lib/viewmodels/registration_viewmodel.dart

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../utils/logger.dart';
import '../../data/registration_model.dart';
import '../../data/registration_repository.dart';

class RegistrationViewModel extends ChangeNotifier {
  final RegistrationRepository _registrationRepository;

  RegistrationViewModel(this._registrationRepository);

  bool _isLoading = false;
  String? _errorMessage;
  RegistrationResponse? _registrationResponse;

  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;
  RegistrationResponse? get registrationResponse => _registrationResponse;

  Future<void> registerStudent({
    required String name,
    required String serialNo,
    required String contact,
    required String aadharNo,
    required String address,
    required String startDate,
    required String endDate,
    required String fee,
  }) async {
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    try {
      // Get user_id from SharedPreferences
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String? userId = prefs.getString('user_id');

      if (userId == null) {
        _errorMessage = 'User ID not found';
        logDebug('User ID not found');
        return;
      }

      logDebug('User ID retrieved from SharedPreferences: $userId');
      // Call repository to register student
      final response = await _registrationRepository.registerStudent(
        name: name,
        serialNo: serialNo,
        contact: contact,
        aadharNo: aadharNo,
        address: address,
        startDate: startDate,
        endDate: endDate,
        fee: fee,
        userId: userId,
      );
      _registrationResponse = response;

      if (response.status == 'success') {
        logDebug('Registration successful: ${response.message}');
      } else {
        _errorMessage = response.message;
        logDebug('Registration failed: ${response.message}');
      }
    } catch (e) {
      _errorMessage = 'An error occurred: $e';
      logDebug(_errorMessage!);
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
}
