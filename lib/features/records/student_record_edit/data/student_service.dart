import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:library_app/res/app_url/app_url.dart';

import 'delete_student_response.dart';
import 'student_details_response.dart';
import 'student_update_response.dart';

class StudentService {

  Future<StudentDetailsResponse> getStudentDetails(int studentId) async {
    final url = Uri.parse(AppUrl.recorddetaislApi);
    final response = await http.post(
      url,
      headers: {'Content-Type': 'application/x-www-form-urlencoded'}, // Correct header for form data
      body: {
        'student_id': studentId.toString(),
      },
    );

    print('Raw API Response: ${response.body}'); // Print the raw response body

    if (response.statusCode == 200) {
      try {
        final Map<String, dynamic> data = json.decode(response.body);
        // Ensure correct parsing based on your model
        return StudentDetailsResponse.fromJson(data);
      } catch (e) {
        throw FormatException('Error parsing response body: $e');
      }
    } else {
      throw Exception('Failed to load student details. Status: ${response.statusCode}');
    }
  }


  Future<StudentUpdateResponse> updateStudentDetails({
    required int studentId,
    required String name,
    required String serialNo,
    required String contact,
    required String aadharNo,
    required String address,
  }) async {
    final response = await http.post(
      Uri.parse(AppUrl.recordeditApi),
      body: {
        'student_id': studentId.toString(),
        'name': name,
        'serial_no': serialNo,
        'contact': contact,
        'aadhar_no': aadharNo,
        'address': address,
      },
    );

    if (response.statusCode == 200) {
      return StudentUpdateResponse.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to update student details');
    }
  }


  Future<void> deleteStudent(int studentId) async {
    final response = await http.post(
      Uri.parse(AppUrl.recorddeleteApi),
      body: {
        'student_id': studentId.toString(),
      },
    );

    if (response.statusCode == 200) {
      try {
        // Check if response is JSON
        final data = json.decode(response.body);
        if (data['status'] == 'success') {
          print(data['message']); // Successfully deleted
        } else {
          throw Exception(data['message']);
        }
      } catch (e) {
        // Handle JSON decoding errors
        throw Exception('Error parsing response: $e');
      }
    } else {
      throw Exception('Failed to delete student, status code: ${response.statusCode}');
    }
  }

}
