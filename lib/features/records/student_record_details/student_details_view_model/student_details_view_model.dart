// // lib/viewmodels/student_view_model.dart
// import 'package:flutter/material.dart';
//
// import '../student_details_modal/student_details_modal.dart';
// import '../student_details_repository/student_details_repository.dart';
//
// class StudentViewModel extends ChangeNotifier {
//   final StudentDetailsRepository _repository = StudentDetailsRepository();
//
//   StudentDetailsModal? _student;
//   StudentDetailsModal? get student => _student;
//
//   bool _isLoading = false;
//   bool get isLoading => _isLoading;
//
//   String? _errorMessage;
//   String? get errorMessage => _errorMessage;
//
//   Future<void> fetchStudentDetails(int studentId) async {
//     _isLoading = true;
//     notifyListeners();
//
//     try {
//       _student = await _repository.fetchStudentDetails(studentId);
//       _errorMessage = null;
//     } catch (e) {
//       _errorMessage = e.toString();
//     } finally {
//       _isLoading = false;
//       notifyListeners();
//     }
//   }
// }
