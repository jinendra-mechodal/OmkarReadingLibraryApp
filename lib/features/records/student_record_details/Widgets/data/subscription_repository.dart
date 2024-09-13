// lib/repositories/subscription_repository.dart
import 'dart:convert';
import 'package:http/http.dart' as http;

import 'subscription_response.dart';

class SubscriptionRepository {
  final String _url = 'https://library.mechodal.com/add_new_subscription.php';

  Future<SubscriptionResponse> addSubscription({
    required int studentId,
    required String startDate,
    required String endDate,
    required String fee,
  }) async {
    final response = await http.post(
      Uri.parse(_url),
      body: {
        'student_id': studentId.toString(),
        'start_date': startDate,
        'end_date': endDate,
        'fee': fee,
      },
    );

    if (response.statusCode == 200) {
      return SubscriptionResponse.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to submit subscription');
    }
  }
}
