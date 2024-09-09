
import 'registration_model.dart';

class RegistrationRepository {
  Future<void> saveRegistration(RegistrationModel model) async {
    // This is where you would implement data persistence
    // For example, saving to a database or an API call
    print('Saving registration data: ${model.toJson()}');
  }

  Future<RegistrationModel> fetchRegistration() async {
    // This is where you would implement data fetching
    // For example, fetching from a database or an API call
    return RegistrationModel(
      studentName: '',
      startDate: DateTime.now(),
      endDate: DateTime.now(),
      fees: 0.0,
      serialNumber: '',
      contactDetails: '',
      aadharNumber: '',
      address: '',
    );
  }
}
