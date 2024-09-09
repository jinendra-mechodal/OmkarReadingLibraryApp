import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';

import '../../../../res/colors/app_color.dart';
import '../../../../res/fonts/text_style.dart';
import '../../../../res/routes/app_routes.dart';

class StudentReportScreen extends StatefulWidget {
  const StudentReportScreen({super.key});

  @override
  State<StudentReportScreen> createState() => _StudentReportScreenState();
}

class _StudentReportScreenState extends State<StudentReportScreen> {
  // Variables to store selected dates
  String _startDate = 'Start Date';
  String _endDate = 'End Date';

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
        final formattedDate =
            DateFormat('dd-MM-yyyy').format(selectedDate); // Corrected format
        if (isStartDate) {
          _startDate = formattedDate;
        } else {
          _endDate = formattedDate;
        }
      });
    }
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
        padding: EdgeInsets.symmetric(
          horizontal: 16.w,
          vertical: 16.h,
        ),
        child: SingleChildScrollView(
          child: Column(
            children: [
              InkWell(
                onTap: () {
                  // Redirect to studentsdetails page
                  //Navigator.pushNamed(context, AppRoutes.studentsdetails);
                },
                child: Container(
                  padding: EdgeInsets.all(16.w),
                  decoration: BoxDecoration(
                    color: AppColor.bglightgray,
                    // color: Color(0xffF5F5F5F5).withOpacity(0.80),
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
                            // "$name’s ",
                            'Chetan Parmar',
                            style: LexendtextFont500.copyWith(
                              color: AppColor.textcolorBlack,
                              fontSize: 14.sp,
                            ),
                          ),
                          Text(
                            "Subscription End : 22/12/2025",
                            // "Subscription End : $endDate",
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
              ),

              SizedBox(height: 10.h),

              Container(
                padding: EdgeInsets.all(16.w),
                decoration: BoxDecoration(
                  color: Color(0xffF5F5F5F5).withOpacity(0.80),
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
                          // "$name’s ",
                          'Chetan Parmar',
                          style: LexendtextFont500.copyWith(
                            color: AppColor.textcolorBlack,
                            fontSize: 14.sp,
                          ),
                        ),
                        Text(
                          "Subscription End : 22/12/2025",
                          // "Subscription End : $endDate",
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
              SizedBox(height: 10.h),
              Container(
                padding: EdgeInsets.all(16.w),
                decoration: BoxDecoration(
                  color: Color(0xffF5F5F5F5).withOpacity(0.80),
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
                          // "$name’s ",
                          'Chetan Parmar',
                          style: LexendtextFont500.copyWith(
                            color: AppColor.textcolorBlack,
                            fontSize: 14.sp,
                          ),
                        ),
                        Text(
                          "Subscription End : 22/12/2025",
                          // "Subscription End : $endDate",
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
              SizedBox(height: 10.h),
              Container(
                padding: EdgeInsets.all(16.w),
                decoration: BoxDecoration(
                  color: Color(0xffF5F5F5F5).withOpacity(0.80),
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
                          // "$name’s ",
                          'Chetan Parmar',
                          style: LexendtextFont500.copyWith(
                            color: AppColor.textcolorBlack,
                            fontSize: 14.sp,
                          ),
                        ),
                        Text(
                          "Subscription End : 22/12/2025",
                          // "Subscription End : $endDate",
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
              SizedBox(height: 10.h),
              Container(
                padding: EdgeInsets.all(16.w),
                decoration: BoxDecoration(
                  color: Color(0xffF5F5F5F5).withOpacity(0.80),
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
                          // "$name’s ",
                          'Chetan Parmar',
                          style: LexendtextFont500.copyWith(
                            color: AppColor.textcolorBlack,
                            fontSize: 14.sp,
                          ),
                        ),
                        Text(
                          "Subscription End : 22/12/2025",
                          // "Subscription End : $endDate",
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
              SizedBox(height: 10.h),
              Container(
                padding: EdgeInsets.all(16.w),
                decoration: BoxDecoration(
                  color: Color(0xffF5F5F5F5).withOpacity(0.80),
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
                          // "$name’s ",
                          'Chetan Parmar',
                          style: LexendtextFont500.copyWith(
                            color: AppColor.textcolorBlack,
                            fontSize: 14.sp,
                          ),
                        ),
                        Text(
                          "Subscription End : 22/12/2025",
                          // "Subscription End : $endDate",
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
              SizedBox(height: 10.h),
              Container(
                padding: EdgeInsets.all(16.w),
                decoration: BoxDecoration(
                  color: Color(0xffF5F5F5F5).withOpacity(0.80),
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
                          // "$name’s ",
                          'Chetan Parmar',
                          style: LexendtextFont500.copyWith(
                            color: AppColor.textcolorBlack,
                            fontSize: 14.sp,
                          ),
                        ),
                        Text(
                          "Subscription End : 22/12/2025",
                          // "Subscription End : $endDate",
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
              SizedBox(height: 10.h),
              Container(
                padding: EdgeInsets.all(16.w),
                decoration: BoxDecoration(
                  color: Color(0xffF5F5F5F5).withOpacity(0.80),
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
                          // "$name’s ",
                          'Chetan Parmar',
                          style: LexendtextFont500.copyWith(
                            color: AppColor.textcolorBlack,
                            fontSize: 14.sp,
                          ),
                        ),
                        Text(
                          "Subscription End : 22/12/2025",
                          // "Subscription End : $endDate",
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
              SizedBox(height: 10.h),
              Container(
                padding: EdgeInsets.all(16.w),
                decoration: BoxDecoration(
                  color: Color(0xffF5F5F5F5).withOpacity(0.80),
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
                          // "$name’s ",
                          'Chetan Parmar',
                          style: LexendtextFont500.copyWith(
                            color: AppColor.textcolorBlack,
                            fontSize: 14.sp,
                          ),
                        ),
                        Text(
                          "Subscription End : 22/12/2025",
                          // "Subscription End : $endDate",
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
              SizedBox(height: 10.h),
              Container(
                padding: EdgeInsets.all(16.w),
                decoration: BoxDecoration(
                  color: Color(0xffF5F5F5F5).withOpacity(0.80),
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
                          // "$name’s ",
                          'Chetan Parmar',
                          style: LexendtextFont500.copyWith(
                            color: AppColor.textcolorBlack,
                            fontSize: 14.sp,
                          ),
                        ),
                        Text(
                          "Subscription End : 22/12/2025",
                          // "Subscription End : $endDate",
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
              SizedBox(height: 10.h),
              Container(
                padding: EdgeInsets.all(16.w),
                decoration: BoxDecoration(
                  color: Color(0xffF5F5F5F5).withOpacity(0.80),
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
                          // "$name’s ",
                          'Chetan Parmar',
                          style: LexendtextFont500.copyWith(
                            color: AppColor.textcolorBlack,
                            fontSize: 14.sp,
                          ),
                        ),
                        Text(
                          "Subscription End : 22/12/2025",
                          // "Subscription End : $endDate",
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
              SizedBox(height: 10.h),
              Container(
                padding: EdgeInsets.all(16.w),
                decoration: BoxDecoration(
                  color: Color(0xffF5F5F5F5).withOpacity(0.80),
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
                          // "$name’s ",
                          'Chetan Parmar',
                          style: LexendtextFont500.copyWith(
                            color: AppColor.textcolorBlack,
                            fontSize: 14.sp,
                          ),
                        ),
                        Text(
                          "Subscription End : 22/12/2025",
                          // "Subscription End : $endDate",
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
              SizedBox(height: 20.h),
            ],
          ),
        ),
      ),
    );
  }
}
