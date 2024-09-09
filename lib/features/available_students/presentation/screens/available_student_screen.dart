import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../res/colors/app_color.dart';
import '../../../../res/fonts/text_style.dart';
import '../../../../res/routes/app_routes.dart';

class AvailableStudentScreen extends StatefulWidget {
  const AvailableStudentScreen({super.key});

  @override
  State<AvailableStudentScreen> createState() => _AvailableStudentScreenState();
}

class _AvailableStudentScreenState extends State<AvailableStudentScreen> {
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
            title: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
             // mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Text(
                  'Available Students',
                  style: LexendtextFont500.copyWith(
                    fontSize: 16.sp,
                    color: AppColor.textcolorBlack,
                  ),
                ),
                SizedBox(width: 20.w,),
                CircleAvatar(
                  backgroundColor: AppColor.btncolor,
                  radius: 15.r,
                  child: Center(
                    child: Text(
                      "25",
                      style: TextStyle(color: AppColor.whiteColor),
                    ),
                  ),
                ),
              ],
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
         // vertical: 16.h,
        ),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Container(
               // width: 260.w,
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
              SizedBox(height: 10.h),

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
                   // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      SizedBox(width: 30.w,),
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
                            "In Time : 10:30 AM",
                            // "Subscription End : $endDate",
                            style: PoppinstextFont400.copyWith(
                              color: AppColor.textcolorBlack,
                              fontSize: 10.sp,
                            ),
                          ),
                        ],
                      ),

                    ],
                  ),
                ),
              ),

              SizedBox(height: 10.h),
              Container(
                padding: EdgeInsets.all(16.w),
                decoration: BoxDecoration(
                  color: AppColor.bglightgray,
                  // color: Color(0xffF5F5F5F5).withOpacity(0.80),
                  borderRadius: BorderRadius.circular(12.0),
                ),
                width: double.infinity,
                height: 70.h,
                child: Row(
                  // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SizedBox(width: 30.w,),
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
                          "In Time : 10:30 AM",
                          // "Subscription End : $endDate",
                          style: PoppinstextFont400.copyWith(
                            color: AppColor.textcolorBlack,
                            fontSize: 10.sp,
                          ),
                        ),
                      ],
                    ),

                  ],
                ),
              ),
              SizedBox(height: 10.h),
              Container(
                padding: EdgeInsets.all(16.w),
                decoration: BoxDecoration(
                  color: AppColor.bglightgray,
                  // color: Color(0xffF5F5F5F5).withOpacity(0.80),
                  borderRadius: BorderRadius.circular(12.0),
                ),
                width: double.infinity,
                height: 70.h,
                child: Row(
                  // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SizedBox(width: 30.w,),
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
                          "In Time : 10:30 AM",
                          // "Subscription End : $endDate",
                          style: PoppinstextFont400.copyWith(
                            color: AppColor.textcolorBlack,
                            fontSize: 10.sp,
                          ),
                        ),
                      ],
                    ),

                  ],
                ),
              ),
              SizedBox(height: 10.h),
              Container(
                padding: EdgeInsets.all(16.w),
                decoration: BoxDecoration(
                  color: AppColor.bglightgray,
                  // color: Color(0xffF5F5F5F5).withOpacity(0.80),
                  borderRadius: BorderRadius.circular(12.0),
                ),
                width: double.infinity,
                height: 70.h,
                child: Row(
                  // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SizedBox(width: 30.w,),
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
                          "In Time : 10:30 AM",
                          // "Subscription End : $endDate",
                          style: PoppinstextFont400.copyWith(
                            color: AppColor.textcolorBlack,
                            fontSize: 10.sp,
                          ),
                        ),
                      ],
                    ),

                  ],
                ),
              ),
              SizedBox(height: 10.h),
              Container(
                padding: EdgeInsets.all(16.w),
                decoration: BoxDecoration(
                  color: AppColor.bglightgray,
                  // color: Color(0xffF5F5F5F5).withOpacity(0.80),
                  borderRadius: BorderRadius.circular(12.0),
                ),
                width: double.infinity,
                height: 70.h,
                child: Row(
                  // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SizedBox(width: 30.w,),
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
                          "In Time : 10:30 AM",
                          // "Subscription End : $endDate",
                          style: PoppinstextFont400.copyWith(
                            color: AppColor.textcolorBlack,
                            fontSize: 10.sp,
                          ),
                        ),
                      ],
                    ),

                  ],
                ),
              ),
              SizedBox(height: 10.h),
              Container(
                padding: EdgeInsets.all(16.w),
                decoration: BoxDecoration(
                  color: AppColor.bglightgray,
                  // color: Color(0xffF5F5F5F5).withOpacity(0.80),
                  borderRadius: BorderRadius.circular(12.0),
                ),
                width: double.infinity,
                height: 70.h,
                child: Row(
                  // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SizedBox(width: 30.w,),
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
                          "In Time : 10:30 AM",
                          // "Subscription End : $endDate",
                          style: PoppinstextFont400.copyWith(
                            color: AppColor.textcolorBlack,
                            fontSize: 10.sp,
                          ),
                        ),
                      ],
                    ),

                  ],
                ),
              ),
              SizedBox(height: 10.h),
              Container(
                padding: EdgeInsets.all(16.w),
                decoration: BoxDecoration(
                  color: AppColor.bglightgray,
                  // color: Color(0xffF5F5F5F5).withOpacity(0.80),
                  borderRadius: BorderRadius.circular(12.0),
                ),
                width: double.infinity,
                height: 70.h,
                child: Row(
                  // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SizedBox(width: 30.w,),
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
                          "In Time : 10:30 AM",
                          // "Subscription End : $endDate",
                          style: PoppinstextFont400.copyWith(
                            color: AppColor.textcolorBlack,
                            fontSize: 10.sp,
                          ),
                        ),
                      ],
                    ),

                  ],
                ),
              ),
              SizedBox(height: 10.h),
              Container(
                padding: EdgeInsets.all(16.w),
                decoration: BoxDecoration(
                  color: AppColor.bglightgray,
                  // color: Color(0xffF5F5F5F5).withOpacity(0.80),
                  borderRadius: BorderRadius.circular(12.0),
                ),
                width: double.infinity,
                height: 70.h,
                child: Row(
                  // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SizedBox(width: 30.w,),
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
                          "In Time : 10:30 AM",
                          // "Subscription End : $endDate",
                          style: PoppinstextFont400.copyWith(
                            color: AppColor.textcolorBlack,
                            fontSize: 10.sp,
                          ),
                        ),
                      ],
                    ),

                  ],
                ),
              ),
              SizedBox(height: 10.h),
              Container(
                padding: EdgeInsets.all(16.w),
                decoration: BoxDecoration(
                  color: AppColor.bglightgray,
                  // color: Color(0xffF5F5F5F5).withOpacity(0.80),
                  borderRadius: BorderRadius.circular(12.0),
                ),
                width: double.infinity,
                height: 70.h,
                child: Row(
                  // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SizedBox(width: 30.w,),
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
                          "In Time : 10:30 AM",
                          // "Subscription End : $endDate",
                          style: PoppinstextFont400.copyWith(
                            color: AppColor.textcolorBlack,
                            fontSize: 10.sp,
                          ),
                        ),
                      ],
                    ),

                  ],
                ),
              ),
              SizedBox(height: 10.h),
              Container(
                padding: EdgeInsets.all(16.w),
                decoration: BoxDecoration(
                  color: AppColor.bglightgray,
                  // color: Color(0xffF5F5F5F5).withOpacity(0.80),
                  borderRadius: BorderRadius.circular(12.0),
                ),
                width: double.infinity,
                height: 70.h,
                child: Row(
                  // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SizedBox(width: 30.w,),
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
                          "In Time : 10:30 AM",
                          // "Subscription End : $endDate",
                          style: PoppinstextFont400.copyWith(
                            color: AppColor.textcolorBlack,
                            fontSize: 10.sp,
                          ),
                        ),
                      ],
                    ),

                  ],
                ),
              ),
              SizedBox(height: 10.h),
              Container(
                padding: EdgeInsets.all(16.w),
                decoration: BoxDecoration(
                  color: AppColor.bglightgray,
                  // color: Color(0xffF5F5F5F5).withOpacity(0.80),
                  borderRadius: BorderRadius.circular(12.0),
                ),
                width: double.infinity,
                height: 70.h,
                child: Row(
                  // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SizedBox(width: 30.w,),
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
                          "In Time : 10:30 AM",
                          // "Subscription End : $endDate",
                          style: PoppinstextFont400.copyWith(
                            color: AppColor.textcolorBlack,
                            fontSize: 10.sp,
                          ),
                        ),
                      ],
                    ),

                  ],
                ),
              ),
              SizedBox(height: 10.h),
              Container(
                padding: EdgeInsets.all(16.w),
                decoration: BoxDecoration(
                  color: AppColor.bglightgray,
                  // color: Color(0xffF5F5F5F5).withOpacity(0.80),
                  borderRadius: BorderRadius.circular(12.0),
                ),
                width: double.infinity,
                height: 70.h,
                child: Row(
                  // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SizedBox(width: 30.w,),
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
                          "In Time : 10:30 AM",
                          // "Subscription End : $endDate",
                          style: PoppinstextFont400.copyWith(
                            color: AppColor.textcolorBlack,
                            fontSize: 10.sp,
                          ),
                        ),
                      ],
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
