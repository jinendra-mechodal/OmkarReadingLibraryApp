// lib/pages/notification_page.dart

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../res/colors/app_color.dart';
import '../../res/fonts/text_style.dart';
import '../../res/routes/app_routes.dart';
import '../../utils/logger.dart';
import 'ViewModel/notification_viewmodel.dart';

class NotificationPage extends StatefulWidget {
  const NotificationPage({super.key});

  @override
  State<NotificationPage> createState() => _NotificationPageState();
}

class _NotificationPageState extends State<NotificationPage> {
  @override
  void initState() {
    super.initState();
   // final viewModel = Provider.of<NotificationViewModel>(context, listen: false);
    logDebug('Fetching notifications'); // Debug log
   // viewModel.loadNotifications(2 ); // Replace with actual user ID
   _fetchNotifications();
  }

  Future<void> _fetchNotifications() async {
    try {
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      final String? userId = prefs.getString('user_id'); // Adjust the key to your preference

      if (userId != null && userId.isNotEmpty) {
        final viewModel = Provider.of<NotificationViewModel>(context, listen: false);
        logDebug('User ID retrieved: $userId'); // Debug log
        final int parsedUserId = int.parse(userId); // Assuming userId is a number
        logDebug('Fetching notifications for user ID: $parsedUserId'); // Debug log
        viewModel.loadNotifications(parsedUserId);
      } else {
        logDebug('User ID is empty or not found in shared preferences');
      }
    } catch (e) {
      logDebug('Error fetching notifications: $e'); // Log any error that occurs
    }
  }

  @override
  Widget build(BuildContext context) {
    final viewModel = Provider.of<NotificationViewModel>(context);
    final notificationViewModel = Provider.of<NotificationViewModel>(context);

    if (viewModel.isLoading) {
      logDebug('Loading...'); // Debug log
    }

    if (viewModel.error.isNotEmpty) {
      logDebug('Error: ${viewModel.error}'); // Debug log
    }

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(kToolbarHeight),
        child: Container(
          decoration: BoxDecoration(
            color: AppColor.whiteColor,
            boxShadow: [
              BoxShadow(
                color: Colors.black12.withOpacity(0.02), // Shadow color
                spreadRadius: 1, // Spread radius
                blurRadius: 4, // Blur radius
                offset: const Offset(0, 4), // Shadow offset (bottom side)
              ),
            ],
          ),
          child: AppBar(
            backgroundColor: AppColor.whiteColor,
            title: Text(
              'Notification',
              style: LexendtextFont500.copyWith(
                fontSize: 16.sp,
                color: AppColor.textcolorBlack,
              ),
            ),
            actions: [
              InkWell(
                onTap: () {
                 // Navigator.pushNamed(context, AppRoutes.home);
                  Navigator.of(context).pop();
                },
                child: Row(
                  children: [
                    Text(
                      "Go Back",
                      style: LexendtextFont500.copyWith(
                        fontSize: 14.sp,
                        color: AppColor.btncolor,
                      ),
                    ),
                    SizedBox(width: 5.w),
                    Icon(
                      Icons.arrow_forward_ios,
                      color: AppColor.btncolor,
                      size: 17.sp,
                    ),
                    SizedBox(width: 10.w),
                  ],
                ),
              ),
            ],
            automaticallyImplyLeading: false,
          ),
        ),
      ),
      body:
      viewModel.isLoading
          ? Center(child: CircularProgressIndicator())
          : viewModel.error.isNotEmpty
          ? Center(child: Text(viewModel.error)):
      notificationViewModel.notifications.isEmpty
          ? Center(child: Text('No notifications available'))
          : ListView.builder(
        padding: EdgeInsets.all(16.0),
        itemCount: viewModel.notifications.length,
        itemBuilder: (context, index) {
          final notification = viewModel.notifications[index];
          logDebug('Displaying notification: ${notification.studentName}'); // Debug log
          return GestureDetector(
            onTap: () {
              logDebug('Notification tapped: ${notification.studentName}'); // Debug log
             // Navigator.pushNamed(context, '/studentDetails');
            },
            child: Container(
              padding: EdgeInsets.all(16.0),
              margin: EdgeInsets.only(bottom: 10.0),
              decoration: BoxDecoration(
                color: Colors.grey[200],
                borderRadius: BorderRadius.circular(12.0),
              ),
              child: Row(
                children: [
                  Image.asset(
                    'assets/icons/ball-icon.png', // Path to your image asset
                    width: 24.w, // Set the width of the image
                    height: 24.h, // Set the height of the image
                    color: AppColor.textcolor_red, // Optional: Apply color filter if needed
                  ),
                 // Icon(Icons.notification_important, color: AppColor.textcolor_red,),
                  SizedBox(width: 10.0),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Text(
                            notification.studentName,
                            style: TextStyle(color: Colors.red, fontSize: 11),
                          ),
                          SizedBox(width: 4.w,),
                          Text(
                            'Subscription expiring soon',
                            style: TextStyle(color: Colors.black, fontSize: 10.sp),
                          ),
                        ],
                      ),

                      Row(
                        children: [
                          Text(
                            "Subscription End :",
                            style: LexendtextFont400.copyWith(
                              color: AppColor.textcolorBlack,
                              fontSize: 11.sp,
                            ),
                          ),
                          SizedBox(width: 2.w),
                          Text(
                            '${notification.endDate}',
                            style: LexendtextFont400.copyWith(
                              color: AppColor.textcolor_gray,
                              fontSize: 11.sp,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
