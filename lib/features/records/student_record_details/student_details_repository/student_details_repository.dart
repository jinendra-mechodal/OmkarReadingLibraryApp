// // lib/repositories/student_repository.dart
// import 'dart:convert';
// import 'package:http/http.dart' as http;
//
// import '../student_details_modal/student_details_modal.dart';
//
// class StudentDetailsRepository {
//   final String apiUrl = 'https://library.mechodal.com/student_details.php';
//
//   Future<StudentDetailsModal> fetchStudentDetails(int studentId) async {
//     final response = await http.post(
//       Uri.parse(apiUrl),
//       body: {
//         'student_id': studentId.toString(),
//       },
//     );
//
//     if (response.statusCode == 200) {
//       final data = json.decode(response.body);
//       if (data['status'] == 'success') {
//         return StudentDetailsModal.fromJson(data['data']);
//       } else {
//         throw Exception('Failed to load student details');
//       }
//     } else {
//       throw Exception('Failed to load student details');
//     }
//   }
// }
