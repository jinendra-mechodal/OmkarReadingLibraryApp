import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:library_app/utils/shared_preferences_helper.dart';
import 'package:provider/provider.dart';

import '../../../res/colors/app_color.dart';
import '../../../res/fonts/text_style.dart';
import '../../../res/routes/app_routes.dart';
import '../../../utils/constants/logger.dart';
import 'view_modal_studentrecord/student_record_view_model.dart';

class StudentsRecord extends StatefulWidget {
  const StudentsRecord({super.key});

  @override
  State<StudentsRecord> createState() => _StudentsRecordState();
}

class _StudentsRecordState extends State<StudentsRecord> {
  DateTime? _selectedDate;

  @override
  void initState() {
    super.initState();
    // Fetch initial student records
    _fetchStudentRecord();
  }

  Future<void> _fetchStudentRecord() async {
    try {
      logDebug('Fetching student records...');
      final userIdString = await SharedPreferencesHelper.getUserId();
      final userId = userIdString != null ? int.tryParse(userIdString) : null;

      if (userId != null) {
        logDebug('User ID: $userId');
        final viewModel = Provider.of<StudentRecordViewModel>(context, listen: false);
        await viewModel.fetchStudentRecord(userId);
      } else {
        logDebug('User ID is either null or not a valid integer.');
      }
    } catch (e) {
      logDebug('Failed to fetch student records: $e');
    }
  }

  Future<void> _fetchStudentRecords(DateTime date) async {
    try {
      logDebug('Fetching student records for date: ${date.toIso8601String()}');
      final userIdString = await SharedPreferencesHelper.getUserId();
      final userId = userIdString != null ? int.tryParse(userIdString) : null;

      if (userId != null) {
        final formattedDate = date.toIso8601String().split('T')[0];
        logDebug('User ID: $userId, Date: $formattedDate');
        final viewModel = Provider.of<StudentRecordViewModel>(context, listen: false);
        await viewModel.fetchStudentRecords(userId, formattedDate);
      } else {
        logDebug('User ID is either null or not a valid integer.');
      }
    } catch (e) {
      logDebug('Failed to fetch student records: $e');
    }
  }

  Future<void> _selectDate(BuildContext context) async {
    try {
      logDebug('Showing date picker...');
      final DateTime? pickedDate = await showDatePicker(
        context: context,
        initialDate: _selectedDate ?? DateTime.now(),
        firstDate: DateTime(2000),
        lastDate: DateTime(2050),
      );

      if (pickedDate != null && pickedDate != _selectedDate) {
        setState(() {
          _selectedDate = pickedDate;
        });

        logDebug('Selected date: ${pickedDate.toIso8601String()}');

        // Fetch records for the selected date
        await _fetchStudentRecords(pickedDate);
      } else {
        logDebug('No date selected or date is the same as the previous one.');
      }
    } catch (e) {
      logDebug('Failed to select date or fetch student records: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    final viewModel = Provider.of<StudentRecordViewModel>(context);

    print('Student Records Count: ${viewModel.studentRecords.length}'); // Debugging line

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
                  logDebug('Navigating back...');
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
      body: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: 16.w,
          vertical: 16.h,
        ),
        child: Column(
          children: [
            Row(
              children: [
                Container(
                  width: 260.w,
                  height: 45.h,
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
                SizedBox(width: 8.w),
                Container(
                  width: 60.w,
                  height: 45.h,
                  alignment: Alignment.center,
                  child: InkWell(
                    onTap: () => _selectDate(context),
                    child: Container(
                      width: 60.w,
                      height: 45.h,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8.r),
                        border: Border.all(color: AppColor.textcolorSilver),
                      ),
                      child: Image.asset("assets/icons/calender-icon.png"),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 10.h),
            Expanded(
              child: viewModel.isLoading
                  ? Center(child: CircularProgressIndicator())
                  : viewModel.errorMessage != null
                  ? Center(child: Text(viewModel.errorMessage!))
                  : viewModel.studentRecords.isEmpty
                  ? Center(child: Text('No student records available'))
                  : ListView.builder(
                itemCount: viewModel.studentRecords.length,
                itemBuilder: (context, index) {
                  final record = viewModel.studentRecords[index];
                  return InkWell(
                    onTap: () {
                     // logDebug('Navigating to student details for ${record.id}');
                     // Navigator.pushNamed(context, AppRoutes.studentsdetails);
                      logDebug('Navigating to student details for ${record.id}');
                      Navigator.pushNamed(
                        context,
                        AppRoutes.studentsdetails,
                        arguments: record.id, // Pass the student ID as an argument
                      );
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
                                record.name,
                                style: LexendtextFont500.copyWith(
                                  color: AppColor.textcolorBlack,
                                  fontSize: 14.sp,
                                ),
                              ),
                              Row(
                                children: [
                                  Text(
                                    "Subscription End:",
                                    style: PoppinstextFont400.copyWith(
                                      color: AppColor.textcolorBlack,
                                      fontSize: 10.sp,
                                    ),
                                  ),
                                  SizedBox(width: 2.w,),
                                  Text(
                                    "${record.endDate}",
                                    style: PoppinstextFont400.copyWith(
                                      color: AppColor.textcolor_gray,
                                      fontSize: 10.sp,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                          Image.asset("assets/icons/right-icon.png"),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
            SizedBox(height: 20.h),
          ],
        ),
      ),
    );
  }
}
