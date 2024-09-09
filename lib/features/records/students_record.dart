import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../res/colors/app_color.dart';
import '../../res/fonts/text_style.dart';
import '../../res/routes/app_routes.dart';

class StudentsRecord extends StatefulWidget {
  const StudentsRecord({super.key});

  @override
  State<StudentsRecord> createState() => _StudentsRecordState();
}

class _StudentsRecordState extends State<StudentsRecord> {
  DateTime? _selectedDate;

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: _selectedDate ?? DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );

    if (pickedDate != null && pickedDate != _selectedDate) {
      setState(() {
        _selectedDate = pickedDate;
      });
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
                color: Colors.black12.withOpacity(0.02), // Shadow color
                spreadRadius: 1, // Spread radius
                blurRadius: 4, // Blur radius
                offset: Offset(0, 4), // Shadow offset (bottom side)
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
                  // Redirect to Home page
                  Navigator.pushNamed(context, AppRoutes.home);
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
            automaticallyImplyLeading: false, // Hides the back button
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
                            // Change this to your desired color
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
                          // color: AppColor.whiteColor,
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

              InkWell(
                onTap: () {
                  // Redirect to studentsdetails page
                  Navigator.pushNamed(context, AppRoutes.studentsdetails);
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

              InkWell(
                onTap: () {
                  // Redirect to studentsdetails page
                  Navigator.pushNamed(context, AppRoutes.studentsdetails);
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
              InkWell(
                onTap: () {
                  // Redirect to studentsdetails page
                  Navigator.pushNamed(context, AppRoutes.studentsdetails);
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
