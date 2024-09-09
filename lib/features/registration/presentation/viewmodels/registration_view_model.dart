// lib/presentation/viewmodels/registration_view_model.dart
import 'package:flutter/material.dart';
import '../../domain/entities/registration_entity.dart';
import '../../domain/use_cases/registration_use_case.dart';

class RegistrationViewModel extends ChangeNotifier {
  final RegistrationUseCase _useCase;
  late RegistrationEntity _registration;

  RegistrationViewModel(this._useCase) {
    _loadRegistration();
  }

  RegistrationEntity get registration => _registration;

  Future<void> _loadRegistration() async {
    _registration = await _useCase.fetchRegistration();
    notifyListeners();
  }

  void updateRegistration({
    String? studentName,
    DateTime? startDate,
    DateTime? endDate,
    double? fees,
    String? serialNumber,
    String? contactDetails,
    String? aadharNumber,
    String? address,
  }) {
    _registration = RegistrationEntity(
      studentName: studentName ?? _registration.studentName,
      startDate: startDate ?? _registration.startDate,
      endDate: endDate ?? _registration.endDate,
      fees: fees ?? _registration.fees,
      serialNumber: serialNumber ?? _registration.serialNumber,
      contactDetails: contactDetails ?? _registration.contactDetails,
      aadharNumber: aadharNumber ?? _registration.aadharNumber,
      address: address ?? _registration.address,
    );
    notifyListeners();
  }

  Future<void> submitRegistration() async {
    await _useCase.saveRegistration(_registration);
  }
}
