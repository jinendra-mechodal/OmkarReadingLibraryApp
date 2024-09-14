// lib/pages/superadmin_home_page.dart

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../../../res/colors/app_color.dart';
import '../../../../../res/fonts/text_style.dart';
import '../../../res/routes/app_routes.dart';
import '../../../utils/logger.dart'; // Ensure you have this import or use your logging package
import '../../../utils/custom_navigator_observer.dart';
import '../../login/view_models/login_usecase.dart';
import '../../notification/ViewModel/notification_viewmodel.dart';
import 'ViewModel/student_dashboard_viewmodel.dart';

class SuperAdminHomePage extends StatefulWidget {
  @override
  _SuperAdminHomePageState createState() => _SuperAdminHomePageState();
}

class _SuperAdminHomePageState extends State<SuperAdminHomePage> {
  @override
  void initState() {
    super.initState();

    Future.microtask(() async {
      try {
        final prefs = await SharedPreferences.getInstance();
        print('SharedPreferences instance obtained.');

        final userIdString = prefs.getString('user_id');
        print('Retrieved user ID as String: $userIdString');

        final userId = userIdString != null ? int.tryParse(userIdString) : 0;
        print('Parsed user ID: $userId');

        if (userId != null && userId != 0) {
          print('Valid user ID found. Loading notifications and dashboard data...');

          final notificationViewModel = Provider.of<NotificationViewModel>(context, listen: false);
          print('Loading notifications...');
          await notificationViewModel.loadNotifications(userId);
          print('Notifications loaded.');

          final dashboardViewModel = Provider.of<StudentDashboardViewModel>(context, listen: false);
          print('Loading dashboard data...');
          await dashboardViewModel.loadDashboardData(userId);
          print('Dashboard data loaded.');
        } else {
          print('User ID not found in SharedPreferences or invalid.');
        }
      } catch (e) {
        print('Error loading data: $e');
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(context);

    final screenWidth = MediaQuery.of(context).size.width;
    final notificationViewModel = Provider.of<NotificationViewModel>(context);
    final dashboardViewModel = Provider.of<StudentDashboardViewModel>(context);

    if (dashboardViewModel.isLoading) {
      print('Dashboard data is loading...');
    }

    if (dashboardViewModel.error.isNotEmpty) {
      print('Dashboard Error: ${dashboardViewModel.error}');
    }

    if (notificationViewModel.isLoading) {
      print('Notifications are loading...');
    }

    if (notificationViewModel.error.isNotEmpty) {
      print('Notifications Error: ${notificationViewModel.error}');
    }

    return WillPopScope(
      onWillPop: () async {
        final loginViewModel = Provider.of<LoginViewModel>(context, listen: false);
        final shouldLogout = await showLogoutConfirmationDialog(context);

        if (shouldLogout == true) {
          print('User confirmed logout.');
          await loginViewModel.logout(context);
          print('User logged out.');
          return false;
        } else {
          print('User canceled logout.');
          return false;
        }
      },
      child: Scaffold(
        backgroundColor: AppColor.whiteColor,
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(kToolbarHeight),
          child: Container(
            decoration: BoxDecoration(
              color: AppColor.whiteColor,
              boxShadow: [
                BoxShadow(
                  color: Colors.black12.withOpacity(0.05),
                  spreadRadius: 1,
                  blurRadius: 4,
                  offset: Offset(0, 4),
                ),
              ],
            ),
            child: AppBar(
              backgroundColor: AppColor.whiteColor,
              title: Image.asset(
                "assets/images/login-img.png",
                height: 40.h,
                width: 109.w,
              ),
              actions: [
                InkWell(
                  onTap: () {
                    print('Navigating to Student Registration...');
                    Navigator.pushNamed(context, AppRoutes.registration);
                  },
                  child: Row(
                    children: [
                      Text(
                        "Student registration",
                        style: LexendtextFont500.copyWith(
                          fontSize: 16.sp,
                          color: AppColor.textcolor_gold,
                        ),
                        overflow: TextOverflow.ellipsis,
                      ),
                      Icon(
                        Icons.chevron_right,
                        color: AppColor.textcolor_gold,
                      ),
                    ],
                  ),
                ),
              ],
              automaticallyImplyLeading: false,
            ),
          ),
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 19.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 20.h),
                InkWell(
                  onTap: () {
                    print('Navigating to Student Record Portal...');
                    Navigator.pushNamed(context, AppRoutes.studentRecordScreen);
                  },
                  child: Container(
                    height: 70.h,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: AppColor.btncolor,
                      borderRadius: BorderRadius.circular(12.0),
                    ),
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: 10.w),
                      child: Row(
                        children: [
                          Image.asset(
                            "assets/icons/cap-icon.png",
                            width: 40.w,
                            height: 50.h,
                          ),
                          SizedBox(width: screenWidth * 0.020),
                          Expanded(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Students Record Portal",
                                  style: LexendtextFont600.copyWith(
                                    fontSize: 14.sp,
                                    color: AppColor.whiteColor,
                                  ),
                                ),
                                Text(
                                  "You Can Check All Student Details here",
                                  style: LexendtextFont600.copyWith(
                                    fontSize: 10.sp,
                                    color: AppColor.whiteColor,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(width: screenWidth * 0.020),
                          Icon(
                            Icons.arrow_forward_ios,
                            color: AppColor.whiteColor,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 20.h),
                Container(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Dashboard",
                        style: LexendtextFont500.copyWith(
                          fontSize: 14.sp,
                          color: AppColor.textcolorSilver,
                        ),
                      ),
                      SizedBox(height: 20.h),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          _buildDashboardCard(context, 'Available', dashboardViewModel.dashboardData?.todayAvailableStudents ?? '0', AppColor.btncolor),
                          _buildDashboardCard(context, 'Left Library', dashboardViewModel.dashboardData?.leftLibraryStudents ?? '0', AppColor.textcolor_gold),
                          _buildDashboardCard(context, 'Present Today', dashboardViewModel.dashboardData?.todayPresentStudents ?? '0', AppColor.green),
                        ],
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 20.h),
                Container(
                  padding: EdgeInsets.only(
                    left: 18.w,
                    right: 42.w,
                    top: 20.h,
                    bottom: 20.h,
                  ),
                  decoration: BoxDecoration(
                    color: AppColor.bglightgray,
                    borderRadius: BorderRadius.circular(12.0),
                  ),
                  width: double.infinity,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _buildActionItem(context, "Available Student", AppRoutes.availableStudents),
                      SizedBox(height: 26.h),
                      _buildActionItem(context, "Print Payment Slip", AppRoutes.printPaymentScreen),
                      SizedBox(height: 26.h),
                      _buildActionItem(context, "Students Report", AppRoutes.studentReportScreen),
                      SizedBox(height: 26.h),
                      _buildActionItem(context, "Notification", AppRoutes.notification),
                    ],
                  ),
                ),
                SizedBox(height: 20.h),
                Text(
                  "Notification",
                  style: LexendtextFont500.copyWith(
                    fontSize: 14.sp,
                    color: AppColor.textcolorSilver,
                  ),
                ),
                SizedBox(height: 20.h),
                notificationViewModel.isLoading
                    ? Center(child: CircularProgressIndicator(color: AppColor.btncolor))
                    : notificationViewModel.error.isNotEmpty
                    ? Center(child: Text(notificationViewModel.error))
                    : notificationViewModel.notifications.isEmpty
                    ? Center(child: Text('No notifications available'))
                    : ListView.builder(
                  itemCount: notificationViewModel.notifications.length,
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  itemBuilder: (context, index) {
                    final notification = notificationViewModel.notifications[index];
                   // print('Displaying notification: ${notification.studentName}');
                    return GestureDetector(
                      onTap: () {
                        print('Notification tapped: ${notification.studentName}');
                        Navigator.pushNamed(context, '/studentDetails');
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
                            Icon(Icons.notification_important),
                            SizedBox(width: 10.0),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    children: [
                                      Text(
                                        notification.studentName,
                                        style: LexendtextFont400.copyWith(
                                          color: AppColor.textcolor_red,
                                          fontSize: 11.sp,
                                        ),
                                      ),
                                      SizedBox(width: 4.0),
                                      Text(
                                        'Subscription expiring soon',
                                        style: LexendtextFont400.copyWith(
                                          color: AppColor.textcolorBlack,
                                          fontSize: 11.sp,
                                        ),
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
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildDashboardCard(BuildContext context, String title, String value, Color borderColor) {
    print('Building Dashboard Card: $title with value $value');
    return Container(
      width: 100.w,
      height: 65.h,
      decoration: BoxDecoration(
        color: Colors.transparent,
        border: Border.all(
          color: borderColor,
          width: 1,
        ),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            title,
            style: LexendtextFont600.copyWith(
              fontSize: 12.sp,
              color: borderColor,
            ),
          ),
          Text(
            value,
            style: LexendtextFont700.copyWith(
              fontSize: 20.sp,
              color: AppColor.textcolorBlack,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildActionItem(BuildContext context, String title, String route) {
    print('Building Action Item: $title');
    return InkWell(
      onTap: () {
        print('Navigating to route: $route');
        Navigator.pushNamed(context, route);
      },
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 1.h), // Adds vertical padding for a larger tap area
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              title,
              style: LexendtextFont600.copyWith(
                fontSize: 14.sp,
                color: AppColor.textcolorBlack,
              ),
            ),
            Image.asset(
              "assets/icons/right-icon.png",
            ),
          ],
        ),
      ),
    );
  }

// Widget _buildActionItem(BuildContext context, String title, String route) {
  //   print('Building Action Item: $title');
  //   return GestureDetector(
  //     onTap: () {
  //       print('Navigating to route: $route');
  //       Navigator.pushNamed(context, route);
  //     },
  //     child: Row(
  //       mainAxisAlignment: MainAxisAlignment.spaceBetween,
  //       children: [
  //         Text(
  //           title,
  //           style: LexendtextFont600.copyWith(
  //             fontSize: 14.sp,
  //             color: AppColor.textcolorBlack,
  //           ),
  //         ),
  //         Image.asset(
  //           "assets/icons/right-icon.png",
  //         ),
  //       ],
  //     ),
  //   );
  // }
}
