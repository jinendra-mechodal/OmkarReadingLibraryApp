// lib/repositories/student_record_repository.dart
import 'dart:convert';
import 'package:http/http.dart' as http;

import '../../../../utils/constants/logger.dart';
import 'student_record_model.dart';

class StudentRecordRepository {
  final String apiUrl = 'https://library.mechodal.com/student_record.php';

  Future<List<StudentRecord>> fetchStudentRecord(int userId) async {
    final Map<String, String> requestBody = {
      'user_id': userId.toString(),
    };

    logDebug('Request Body for fetchStudentRecord: ${jsonEncode(requestBody)}'); // Log the request body

    try {
      final response = await http.post(
        Uri.parse(apiUrl),
        body: requestBody,
      );

      // Log the status code and response body
      logDebug('Response Status Code for fetchStudentRecord: ${response.statusCode}');
      logDebug('Response Body for fetchStudentRecord: ${response.body}');

      if (response.statusCode == 200) {
        final Map<String, dynamic> responseData = json.decode(response.body);
        if (responseData['status'] == 'success') {
          List<dynamic> data = responseData['data'];
          logDebug('Data fetched successfully for fetchStudentRecord');
          return data.map((json) => StudentRecord.fromJson(json)).toList();
        } else {
          logDebug('Error in fetchStudentRecord: ${responseData['message']}');
          return [];
        }
      } else {
        logDebug('Error: Failed to load data in fetchStudentRecord');
        return [];
      }
    } catch (error) {
      logDebug('Exception in fetchStudentRecord: $error');
      return [];
    }
  }

  Future<List<StudentRecord>> fetchStudentRecords(int userId, String endDate) async {
    final Map<String, String> requestBody = {
      'user_id': userId.toString(),
      'end_date': endDate,
    };

    logDebug('Request Body for fetchStudentRecords: ${jsonEncode(requestBody)}'); // Log the request body

    try {
      final response = await http.post(
        Uri.parse(apiUrl),
        body: requestBody,
      );

      // Log the status code and response body
      logDebug('Response Status Code for fetchStudentRecords: ${response.statusCode}');
      logDebug('Response Body for fetchStudentRecords: ${response.body}');

      if (response.statusCode == 200) {
        final Map<String, dynamic> responseData = json.decode(response.body);
        if (responseData['status'] == 'success') {
          List<dynamic> data = responseData['data'];
          logDebug('Data fetched successfully for fetchStudentRecords');
          return data.map((json) => StudentRecord.fromJson(json)).toList();
        } else {
          logDebug('Error in fetchStudentRecords: ${responseData['message']}');
          return [];
        }
      } else {
        logDebug('Error: Failed to load data in fetchStudentRecords');
        return [];
      }
    } catch (error) {
      logDebug('Exception in fetchStudentRecords: $error');
      return [];
    }
  }
}
