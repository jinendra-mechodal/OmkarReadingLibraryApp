// lib/viewmodels/subscription_view_model.dart
import 'package:flutter/material.dart';

import '../data/subscription_repository.dart';
import '../data/subscription_response.dart';

class SubscriptionViewModel extends ChangeNotifier {
  final SubscriptionRepository _repository;
  SubscriptionResponse? _response;
  String? _error;

  SubscriptionViewModel(this._repository);

  SubscriptionResponse? get response => _response;
  String? get error => _error;

  Future<void> submitSubscription({
    required int studentId,
    required String startDate,
    required String endDate,
    required String fee,
  }) async {
    try {
      _response = await _repository.addSubscription(
        studentId: studentId,
        startDate: startDate,
        endDate: endDate,
        fee: fee,
      );
      _error = null;
    } catch (e) {
      _response = null;
      _error = e.toString();
    }
    notifyListeners();
  }
}
