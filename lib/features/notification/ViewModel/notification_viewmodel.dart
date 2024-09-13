// lib/viewmodels/notification_viewmodel.dart

import 'package:flutter/material.dart';
import '../../../utils/logger.dart';
import '../data/notification_model.dart';
import '../data/notification_repository.dart';

class NotificationViewModel extends ChangeNotifier {
  final NotificationRepository _repository = NotificationRepository();

  List<NotificationData> notifications = [];
  bool isLoading = false;
  String error = '';

  Future<void> loadNotifications(int userId) async {
    logDebug('Loading notifications for user_id: $userId'); // Debug log
    isLoading = true;
    notifyListeners();

    try {
      // Fetch notifications from repository
      final response = await _repository.fetchNotifications(userId);
      notifications = _extractNotifications(response); // Process the response
      error = '';
      logDebug('Notifications loaded: ${notifications.length} items'); // Debug log
    } catch (e) {
      error = 'Failed to load notifications';
      logDebug('Error loading notifications: $e'); // Debug log
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }

  // Method to process and extract notifications from response
  List<NotificationData> _extractNotifications(NotificationResponse response) {
    logDebug('Extracting notifications from response: ${response.data}'); // Debug log

    List<NotificationData> allNotifications = [];
    response.data.forEach((date, notificationsList) {
      allNotifications.addAll(notificationsList);
    });

    logDebug('Extracted notifications count: ${allNotifications.length}'); // Debug log
    return allNotifications;
  }
}
