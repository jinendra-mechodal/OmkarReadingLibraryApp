import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../res/colors/app_color.dart';
import '../../../../res/fonts/text_style.dart';
import '../../../../res/routes/app_routes.dart';
import '../../data/report_model.dart';
import '../../data/report_repository.dart';
import '../../domain/student_report_view_model.dart';

class StudentReportScreen extends StatefulWidget {
  const StudentReportScreen({super.key});

  @override
  State<StudentReportScreen> createState() => _StudentReportScreenState();
}

class _StudentReportScreenState extends State<StudentReportScreen> {
  // Variables to store selected dates
  String _startDate = 'Start Date';
  String _endDate = 'End Date';

  // Variable to store fetched reports
  List<StudentReport> _reports = [];

  // Function to show date picker and update the selected date
  Future<void> _selectDate(BuildContext context, bool isStartDate) async {
    final DateTime? selectedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2050),
    );

    if (selectedDate != null) {
      setState(() {
        final formattedDate = DateFormat('dd-MM-yyyy').format(selectedDate); // Corrected format
        if (isStartDate) {
          _startDate = formattedDate;
        } else {
          _endDate = formattedDate;
        }
      });

      // Log the selected dates
      print('Start Date: $_startDate');
      print('End Date: $_endDate');

      // If the end date is selected, make the API call
      if (!isStartDate) {
        await _fetchReports();
      }
    }
  }

  Future<void> _fetchReports() async {
    try {
      // Log the start of the fetch operation
      print('Starting report fetch...');

      // Retrieve user ID from SharedPreferences
      final prefs = await SharedPreferences.getInstance();
      final userId = prefs.getString('user_id') ?? ''; // Default to empty string if user_id is not found
      print('User ID: $userId');

      // Format dates using the updated _formatDate method
      final startDateFormatted = _formatDate(_startDate);
      final endDateFormatted = _formatDate(_endDate);

      // Log formatted dates
      print('Formatted Start Date: $startDateFormatted');
      print('Formatted End Date: $endDateFormatted');

      // Check if dates are valid
      if (startDateFormatted.isEmpty || endDateFormatted.isEmpty) {
        print('Error: One or both dates are invalid.');
        return;
      }

      // Log that the API call is being made
      print('Fetching reports from repository...');

      // Use Provider to access StudentReportViewModel
      final viewModel = Provider.of<StudentReportViewModel>(context, listen: false);

      // Ensure the correct named parameters are used
      await viewModel.fetchReports(
        userId: userId,
        startDate: startDateFormatted,
        endDate: endDateFormatted,
      );

      // Check if reports are empty
      if (viewModel.reports.isEmpty) {
        print('No reports found for the given date range.');
      } else {
        print('Reports fetched successfully: ${viewModel.reports}');
      }
    } catch (e) {
      // Log the error
      print('API Request Error: $e');
    }
  }

  String _formatDate(String date) {
    try {
      final inputFormat = DateFormat('dd-MM-yyyy');
      final outputFormat = DateFormat('yyyy-MM-dd');
      final parsedDate = inputFormat.parse(date); // Parse the date in dd-MM-yyyy format
      return outputFormat.format(parsedDate); // Format it to yyyy-MM-dd
    } catch (e) {
      print('Date formatting error: $e');
      return '';
    }
  }

  // Method to handle tap event and print student_id
  void _handleTap(String studentId) {
    print('Student ID: $studentId');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.whiteColor,
      appBar: AppBar(
        backgroundColor: AppColor.btncolor,
        automaticallyImplyLeading: false, // Hides the back button
        bottom: PreferredSize(
          preferredSize: Size.fromHeight(120.h),
          // Increased height for more space
          child: Container(
            color: AppColor.btncolor,
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 20.h),
                  Container(
                    width: double.infinity,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10.r),
                      color: AppColor.whiteColor,
                    ),
                    child: TextFormField(
                      decoration: InputDecoration(
                        prefixIcon: Container(
                          padding: EdgeInsets.all(8.0),
                          child: Image.asset(
                            'assets/icons/search-icon.png',
                            color: AppColor.textcolorSilver,
                            height: 24.h,
                            width: 24.w,
                          ),
                        ),
                        hintText: 'Search...',
                        hintStyle: LexendtextFont300.copyWith(
                          color: AppColor.textcolorSilver,
                          fontSize: 14.sp,
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8.r),
                          borderSide: BorderSide(
                            color: AppColor.textcolorSilver,
                            width: 1.w,
                          ),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8.r),
                          borderSide: BorderSide(
                            color: AppColor.textcolorSilver,
                            width: 1.w,
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 15.h), // Space between input fields
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: GestureDetector(
                          onTap: () => _selectDate(context, true),
                          child: Container(
                            height: 50.h, // Ensure consistent height
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10.r),
                              color: AppColor.whiteColor,
                            ),
                            alignment: Alignment.centerLeft,
                            padding: EdgeInsets.symmetric(horizontal: 12.w), // Ensure padding is consistent
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Image.asset(
                                  'assets/icons/cal-icon.png',
                                  color: AppColor.btncolor,
                                  height: 18.h,
                                  width: 19.w,
                                ),
                                SizedBox(width: 8.w), // Spacing between icon and text
                                Expanded(
                                  child: Text(
                                    _startDate,
                                    style: LexendtextFont300.copyWith(
                                      color: AppColor.textcolorSilver,
                                      fontSize: 13.sp,
                                    ),
                                    overflow: TextOverflow.ellipsis, // Handle text overflow
                                  ),
                                ),
                                Icon(
                                  Icons.arrow_drop_down,
                                  color: AppColor.textcolorSilver,
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      SizedBox(width: 6.w), // Spacing between fields
                      Text(
                        'TO',
                        style: LexendtextFont500.copyWith(
                          color: AppColor.whiteColor,
                          fontSize: 12.sp,
                        ),
                      ),
                      SizedBox(width: 6.w), // Spacing between fields
                      Expanded(
                        child: GestureDetector(
                          onTap: () => _selectDate(context, false),
                          child: Container(
                            height: 50.h, // Ensure consistent height
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10.r),
                              color: AppColor.whiteColor,
                            ),
                            alignment: Alignment.centerLeft,
                            padding: EdgeInsets.symmetric(horizontal: 12.w), // Ensure padding is consistent
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Image.asset(
                                  'assets/icons/cal-icon.png',
                                  color: AppColor.btncolor,
                                  height: 18.h,
                                  width: 19.w,
                                ),
                                SizedBox(width: 8.w), // Space between icon and text
                                Expanded(
                                  child: Text(
                                    _endDate,
                                    style: LexendtextFont300.copyWith(
                                      color: AppColor.textcolorSilver,
                                      fontSize: 13.sp,
                                    ),
                                    overflow: TextOverflow.ellipsis, // Handle text overflow
                                  ),
                                ),
                                Icon(
                                  Icons.arrow_drop_down,
                                  color: AppColor.textcolorSilver,
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),

                  SizedBox(height: 20.h),
                ],
              ),
            ),
          ),
        ),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
        child: Consumer<StudentReportViewModel>(
          builder: (context, viewModel, child) {
            if (viewModel.isLoading) {
              return Center(child: CircularProgressIndicator());
            }

            if (viewModel.error.isNotEmpty) {
              return Center(child: Text('Error: ${viewModel.error}'));
            }

            return ListView.builder(
              itemCount: viewModel.reports.length,
              itemBuilder: (context, index) {
                final report = viewModel.reports[index];
                return InkWell(
                  onTap: () {
                    // Handle tap
                    _handleTap(report.studentId);
                    Navigator.pushNamed(context, AppRoutes.studentsdetails);
                  },
                  child: Container(
                    margin: EdgeInsets.all(5.r),
                    padding: EdgeInsets.all(16.w),
                    decoration: BoxDecoration(
                      color: AppColor.bglightgray,
                      borderRadius: BorderRadius.circular(12.0),
                    ),
                    width: double.infinity,
                    height: 70.h,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              report.studentName,
                              style: LexendtextFont500.copyWith(
                                color: AppColor.textcolorBlack,
                                fontSize: 14.sp,
                              ),
                            ),
                            Text(
                              "Subscription End : ${report.endDate}",
                              style: PoppinstextFont400.copyWith(
                                color: AppColor.textcolorBlack,
                                fontSize: 10.sp,
                              ),
                            ),
                          ],
                        ),
                        Image.asset(
                          "assets/icons/right-icon.png",
                        ),
                      ],
                    ),
                  ),
                );
              },
            );
          },
        ),
      ),
    );
  }
}
