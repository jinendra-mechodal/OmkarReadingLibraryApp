import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart'; // Ensure provider is added to your dependencies

import '../../../res/colors/app_color.dart';
import '../../../res/fonts/text_style.dart';
import '../../../res/routes/app_routes.dart';
import '../../../utils/logger.dart';
import '../student_record_edit/data/student_service.dart';
import 'Widgets/CustomSubscriptionDialog.dart';
import 'student_details_view_model/student_details_view_model.dart';

class StudentDetailsPage extends StatefulWidget {
  final int studentId;

  StudentDetailsPage({required this.studentId});

  @override
  State<StudentDetailsPage> createState() => _StudentDetailsPageState();
}

class _StudentDetailsPageState extends State<StudentDetailsPage> {

  @override
  void initState() {
    super.initState();
    // Schedule fetchStudentDetails after the current frame has been rendered
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _fetchStudentDetails();
      _fetchSubscriptionDetails();
    });
  }

  Future<void> _fetchStudentDetails() async {
    final viewModel = Provider.of<StudentDetailsViewModel>(context, listen: false);

    print('Fetching details for student ID: ${widget.studentId}');
    try {
      await viewModel.fetchStudentDetails(widget.studentId);
      print('Student details fetched successfully for ID: ${widget.studentId}');
      print('Student: ${viewModel.student}');
      print('Subscriptions: ${viewModel.subscriptions}');
    } catch (e) {
      print('Error fetching student details for ID: ${widget.studentId}, Error: $e');
    }
  }

  Future<void> _fetchSubscriptionDetails() async {
    try {
      final viewModel = Provider.of<StudentDetailsViewModel>(context, listen: false);
      await viewModel.fetchSubscriptionDetails(widget.studentId);
      print('Subscription details fetched successfully for ID: ${widget.studentId}');
    } catch (e) {
      print('Error fetching subscription details for ID: ${widget.studentId}, Error: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      backgroundColor: AppColor.whiteColor,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(kToolbarHeight),
        child: Container(
          decoration: BoxDecoration(
            color: AppColor.whiteColor,
            boxShadow: [
              BoxShadow(
                color: Colors.black12.withOpacity(0.02),
                spreadRadius: 1,
                blurRadius: 4,
                offset: Offset(0, 4),
              ),
            ],
          ),
          child: AppBar(
            backgroundColor: AppColor.whiteColor,
            title: Text(
              'Student Registration',
              style: LexendtextFont500.copyWith(
                fontSize: 16.sp,
                color: AppColor.textcolorBlack,
              ),
            ),
            actions: [
              InkWell(
                onTap: () {
                  Navigator.pop(context);
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
      body: Consumer<StudentDetailsViewModel>(
        builder: (context, viewModel, child) {
          if (viewModel.isLoading) {
            return Center(child: CircularProgressIndicator(
              color: AppColor.btncolor,
            ));
          }

          if (viewModel.errorMessage != null) {
            return Center(child: Text('Error: ${viewModel.errorMessage}'));
          }

          final student = viewModel.student;
          final subscriptions = viewModel.subscriptions;

          if (student == null) {
            return Center(child: Text('No student data available'));
          }

          return SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  height: 50.h,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: Colors.black.withOpacity(0.05),
                      width: 1.0,
                    ),
                    borderRadius: BorderRadius.circular(4.0),
                  ),
                  child: Padding(
                    padding: EdgeInsets.only(
                      right: 20.w,
                      left: 30.w,
                    ),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              student.name,
                              style: LexendtextFont500.copyWith(
                                color: AppColor.textcolor_blue,
                                fontSize: 14.sp,
                              ),
                            ),
                            Text(
                              "Register At ${student.date}",
                              style: mulishRegularFont300.copyWith(
                                color: AppColor.textcolor_gray,
                                fontSize: 10.sp,
                              ),
                            ),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            InkWell(
                              onTap: () async {
                                print('Delete icon tapped');
                                bool? shouldDelete = await _showDeleteConfirmationDialog();
                                if (shouldDelete ?? false) {
                                  try {
                                    // Implement deletion logic
                                    print('Delete confirmed for student ID: ${widget.studentId}');
                                    final studentService = StudentService();
                                    await studentService.deleteStudent(widget.studentId!);

                                    // Show success message
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(content: Text('Student deleted successfully')),
                                    );

                                    // Optionally, navigate back or refresh the list
                                   // Navigator.pop(context);
                                    Navigator.pushNamed(
                                      context,
                                      AppRoutes.studentRecordScreen,
                                      arguments: widget.studentId, // Pass student ID as argument
                                    );

                                  } catch (e) {
                                    print('Error deleting student: $e');
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(content: Text('Error deleting student: $e')),
                                    );
                                  }
                                }
                              },

                              child: Image.asset(
                                "assets/icons/dlt-icon.png",
                                height: 25.h,
                                width: 25.w,
                              ),
                            ),
                            SizedBox(
                              width: 10.w,
                            ),
                            InkWell(
                              onTap: () {
                                Navigator.pushNamed(
                                  context,
                                  AppRoutes.studentDetailsEdit,
                                  arguments: widget.studentId, // Pass student ID as argument
                                );
                                print('Edit icon tapped');
                                logDebug('Navigating to student details to edit ${widget.studentId}');
                               // Navigator.pushNamed(context, AppRoutes.studentDetailsEdit);
                              },
                              child: Image.asset(
                                "assets/icons/edit-icon.png",
                                height: 25.h,
                                width: 25.w,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
                Container(
                  height: 165.h,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: Colors.black.withOpacity(0.05),
                      width: 1.0,
                    ),
                    borderRadius: BorderRadius.circular(4.0),
                  ),
                  child: Padding(
                    padding: EdgeInsets.only(
                      left: 30.w,
                      right: 20.w,
                    ),
                    child: Column(
                      children: [
                        SizedBox(
                          height: 10.h,
                        ),
                        Row(
                          children: [
                            Text(
                              "Student Name : ",
                              style: LexendtextFont500.copyWith(
                                color: AppColor.textcolor_gray,
                                fontSize: 12.sp,
                              ),
                            ),
                            Text(
                              student.name,
                              style: LexendtextFont400.copyWith(
                                color: AppColor.textcolor_gray,
                                fontSize: 12.sp,
                              ),
                            )
                          ],
                        ),
                        SizedBox(
                          height: 10.h,
                        ),
                        Row(
                          children: [
                            Text(
                              "Serial Number : ",
                              style: LexendtextFont500.copyWith(
                                color: AppColor.textcolor_gray,
                                fontSize: 12.sp,
                              ),
                            ),
                            Text(
                              student.serialNo,
                              style: LexendtextFont400.copyWith(
                                color: AppColor.textcolor_gray,
                                fontSize: 12.sp,
                              ),
                            )
                          ],
                        ),
                        SizedBox(
                          height: 10.h,
                        ),
                        Row(
                          children: [
                            Text(
                              "Contact Details: ",
                              style: LexendtextFont500.copyWith(
                                color: AppColor.textcolor_gray,
                                fontSize: 12.sp,
                              ),
                            ),
                            Text(
                              student.contact,
                              style: LexendtextFont400.copyWith(
                                color: AppColor.textcolor_gray,
                                fontSize: 12.sp,
                              ),
                            )
                          ],
                        ),
                        SizedBox(
                          height: 10.h,
                        ),
                        Row(
                          children: [
                            Text(
                              "Aadhar number : ",
                              style: LexendtextFont500.copyWith(
                                color: AppColor.textcolor_gray,
                                fontSize: 12.sp,
                              ),
                            ),
                            Text(
                              student.aadharNo,
                              style: LexendtextFont400.copyWith(
                                color: AppColor.textcolor_gray,
                                fontSize: 12.sp,
                              ),
                            )
                          ],
                        ),
                        SizedBox(
                          height: 10.h,
                        ),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Address : ",
                              style: LexendtextFont500.copyWith(
                                color: AppColor.textcolor_gray,
                                fontSize: 12.sp,
                              ),
                            ),
                            Container(
                              width: 210.w,
                              child: Text(
                                student.address,
                                style: LexendtextFont400.copyWith(
                                  color: AppColor.textcolor_gray,
                                  fontSize: 12.sp,
                                ),
                              ),
                            )
                          ],
                        ),
                        SizedBox(
                          height: 10.h,
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  height: 30.h,
                ),
                // Subscription records section
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16),
                  child: Text(
                    "Records",
                    style: LexendtextFont500.copyWith(
                      color: AppColor.textcolor_blue,
                      fontSize: 14.sp,
                    ),
                  ),
                ),
                SizedBox(
                  height: 18.h,
                ),
                subscriptions.isEmpty
                    ? Center(child: Text('No subscription records available'))
                    : Padding(
                  padding: EdgeInsets.only(left: 16.w, right: 22.w),
                  child: SingleChildScrollView(
                    child: Column(
                      children: subscriptions.map((subscription) {
                        return InkWell(
                          onTap: () {
                            // Implement navigation or actions here
                            print('Subscription tapped: ${subscription.startDate} To ${subscription.endDate}');
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
                                      '${subscription.startDate} To ${subscription.endDate}',
                                      style: LexendtextFont500.copyWith(
                                        color: AppColor.textcolorBlack,
                                        fontSize: 14.sp,
                                      ),
                                    ),
                                    Text(
                                      "Upgraded At ${subscription.createdAt}",
                                      style: mulishRegularFont300.copyWith(
                                        color: AppColor.textcolor_gray,
                                        fontSize: 10.sp,
                                      ),
                                    ),
                                  ],
                                ),
                                Text(
                                  "₹${subscription.fee}",
                                  style: LexendtextFont500.copyWith(
                                    color: AppColor.textcolorBlack,
                                    fontSize: 14.sp,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      }).toList(),
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
      bottomSheet: Container(
        width: double.infinity,
        padding: EdgeInsets.all(16.0),
        color: Colors.white,
        child: ElevatedButton(
          onPressed: () {
            _showCustomDialog(context);
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: AppColor.btncolor,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12.0),
            ),
            padding: EdgeInsets.symmetric(vertical: 14.0),
          ),
          child: Text(
            'Add New Subscription',
            style: TextStyle(
              color: Colors.white,
              fontSize: 16.0,
            ),
          ),
        ),
      ),
    );
  }

  Future<bool?> _showDeleteConfirmationDialog() async {
    return showDialog<bool>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Confirm Deletion'),
          content: Text('Are you sure you want to delete this student?'),
          actions: [
            // TextButton(
            //   onPressed: () {
            //     Navigator.of(context).pop(false);
            //   },
            //   child: Text('Cancel'),
            // ),
            // TextButton(
            //   onPressed: () {
            //     Navigator.of(context).pop(true);
            //   },
            //   child: Text('Delete'),
            // ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                InkWell(
                  onTap: () => Navigator.of(context).pop(false),
                  child: Container(
                    width: 100.w,
                    // width: double.infinity,
                    height: 40.h, // Adjust height as needed
                    decoration: BoxDecoration(
                      color: AppColor.btncolor,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Center(
                      child: Text(
                        'Cancel',
                        style: LexendtextFont300.copyWith(
                          color: AppColor.whiteColor,
                          fontSize: 14.sp,
                        ),
                      ),
                    ),
                  ),
                ),
                InkWell(
                  onTap: () => Navigator.of(context).pop(true),
                  child: Container(
                    // width: double.infinity,
                    width: 100.w,
                    height: 40.h, // Adjust height as needed
                    decoration: BoxDecoration(
                      color: AppColor.btncolor,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Center(
                      child: Text(
                        'Delete',
                        style: LexendtextFont300.copyWith(
                          color: AppColor.whiteColor,
                          fontSize: 14.sp,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        );
      },
    );
  }

  void _showCustomDialog(BuildContext context) {
    final TextEditingController _startDateController = TextEditingController();
    final TextEditingController _endDateController = TextEditingController();
    final TextEditingController _feesController = TextEditingController();

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return CustomSubscriptionDialog(
          startDateController: _startDateController,
          endDateController: _endDateController,
          feesController: _feesController,
          studentId: widget.studentId,
        );
      },
    );
  }
}
