
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../res/colors/app_color.dart';
import '../../res/fonts/text_style.dart';
import '../../res/routes/app_routes.dart';

class NotificationPage extends StatefulWidget {
  const NotificationPage({super.key});

  @override
  State<NotificationPage> createState() => _NotificationPageState();
}

class _NotificationPageState extends State<NotificationPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.whiteColor,
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
            automaticallyImplyLeading: false,
          ),
        ),
      ),
      body:  SingleChildScrollView(
        child: Column(
          children: [
            // Notification
            Padding(
              padding:  EdgeInsets.symmetric(
                horizontal: 16.w,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 10.h),
                  Text(
                    "Todays",
                    style: LexendtextFont500.copyWith(
                      fontSize: 14.sp,
                      color: AppColor.textcolorSilver,
                    ),
                  ),
                  SizedBox(height: 10.h),
                  GestureDetector(
                    onTap: (){
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
                        children: [
                          Image.asset(
                            "assets/icons/ball-icon.png",
                            width: 28.w,
                            height: 30.h,
                          ),
                          SizedBox(width: 10.w),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  Text(
                                    // "$name’s ",
                                    'Chetan Parmar',
                                    style: LexendtextFont400.copyWith(
                                      color: Colors.red,
                                      fontSize: 11.sp,
                                    ),
                                  ),
                                  Text(
                                    'Subscription expiring soon',
                                    style: LexendtextFont400.copyWith(
                                      color: AppColor.textcolorBlack,
                                      fontSize: 11.sp,
                                    ),
                                  ),
                                ],
                              ),
                              Text(
                                "Subscription End : 22/12/2025",
                                // "Subscription End : $endDate",
                                style: PoppinstextFont200.copyWith(
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
                  GestureDetector(
                    onTap: (){
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
                        children: [
                          Image.asset(
                            "assets/icons/ball-icon.png",
                            width: 28.w,
                            height: 30.h,
                          ),
                          SizedBox(width: 10.w),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  Text(
                                    // "$name’s ",
                                    'Chetan Parmar',
                                    style: LexendtextFont400.copyWith(
                                      color: Colors.red,
                                      fontSize: 11.sp,
                                    ),
                                  ),
                                  Text(
                                    'Subscription expiring soon',
                                    style: LexendtextFont400.copyWith(
                                      color: AppColor.textcolorBlack,
                                      fontSize: 11.sp,
                                    ),
                                  ),
                                ],
                              ),
                              Text(
                                "Subscription End : 22/12/2025",
                                // "Subscription End : $endDate",
                                style: PoppinstextFont200.copyWith(
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
                  GestureDetector(
                    onTap: (){
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
                        children: [
                          Image.asset(
                            "assets/icons/ball-icon.png",
                            width: 28.w,
                            height: 30.h,
                          ),
                          SizedBox(width: 10.w),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  Text(
                                    // "$name’s ",
                                    'Chetan Parmar',
                                    style: LexendtextFont400.copyWith(
                                      color: Colors.red,
                                      fontSize: 11.sp,
                                    ),
                                  ),
                                  Text(
                                    'Subscription expiring soon',
                                    style: LexendtextFont400.copyWith(
                                      color: AppColor.textcolorBlack,
                                      fontSize: 11.sp,
                                    ),
                                  ),
                                ],
                              ),
                              Text(
                                "Subscription End : 22/12/2025",
                                // "Subscription End : $endDate",
                                style: PoppinstextFont200.copyWith(
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
                  GestureDetector(
                    onTap: (){
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
                        children: [
                          Image.asset(
                            "assets/icons/ball-icon.png",
                            width: 28.w,
                            height: 30.h,
                          ),
                          SizedBox(width: 10.w),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  Text(
                                    // "$name’s ",
                                    'Chetan Parmar',
                                    style: LexendtextFont400.copyWith(
                                      color: Colors.red,
                                      fontSize: 11.sp,
                                    ),
                                  ),
                                  Text(
                                    'Subscription expiring soon',
                                    style: LexendtextFont400.copyWith(
                                      color: AppColor.textcolorBlack,
                                      fontSize: 11.sp,
                                    ),
                                  ),
                                ],
                              ),
                              Text(
                                "Subscription End : 22/12/2025",
                                // "Subscription End : $endDate",
                                style: PoppinstextFont200.copyWith(
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

                  Text(
                    "20 December 2024",
                    style: LexendtextFont500.copyWith(
                      fontSize: 14.sp,
                      color: AppColor.textcolorSilver,
                    ),
                  ),
                  SizedBox(height: 10.h),
                  GestureDetector(
                    onTap: (){
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
                        children: [
                          Image.asset(
                            "assets/icons/ball-icon.png",
                            width: 28.w,
                            height: 30.h,
                          ),
                          SizedBox(width: 10.w),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  Text(
                                    // "$name’s ",
                                    'Chetan Parmar',
                                    style: LexendtextFont400.copyWith(
                                      color: Colors.red,
                                      fontSize: 11.sp,
                                    ),
                                  ),
                                  Text(
                                    'Subscription expiring soon',
                                    style: LexendtextFont400.copyWith(
                                      color: AppColor.textcolorBlack,
                                      fontSize: 11.sp,
                                    ),
                                  ),
                                ],
                              ),
                              Text(
                                "Subscription End : 22/12/2025",
                                // "Subscription End : $endDate",
                                style: PoppinstextFont200.copyWith(
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
                  GestureDetector(
                    onTap: (){
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
                        children: [
                          Image.asset(
                            "assets/icons/ball-icon.png",
                            width: 28.w,
                            height: 30.h,
                          ),
                          SizedBox(width: 10.w),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  Text(
                                    // "$name’s ",
                                    'Chetan Parmar',
                                    style: LexendtextFont400.copyWith(
                                      color: Colors.red,
                                      fontSize: 11.sp,
                                    ),
                                  ),
                                  Text(
                                    'Subscription expiring soon',
                                    style: LexendtextFont400.copyWith(
                                      color: AppColor.textcolorBlack,
                                      fontSize: 11.sp,
                                    ),
                                  ),
                                ],
                              ),
                              Text(
                                "Subscription End : 22/12/2025",
                                // "Subscription End : $endDate",
                                style: PoppinstextFont200.copyWith(
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
                  GestureDetector(
                    onTap: (){
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
                        children: [
                          Image.asset(
                            "assets/icons/ball-icon.png",
                            width: 28.w,
                            height: 30.h,
                          ),
                          SizedBox(width: 10.w),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  Text(
                                    // "$name’s ",
                                    'Chetan Parmar',
                                    style: LexendtextFont400.copyWith(
                                      color: Colors.red,
                                      fontSize: 11.sp,
                                    ),
                                  ),
                                  Text(
                                    'Subscription expiring soon',
                                    style: LexendtextFont400.copyWith(
                                      color: AppColor.textcolorBlack,
                                      fontSize: 11.sp,
                                    ),
                                  ),
                                ],
                              ),
                              Text(
                                "Subscription End : 22/12/2025",
                                // "Subscription End : $endDate",
                                style: PoppinstextFont200.copyWith(
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
                  GestureDetector(
                    onTap: (){
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
                        children: [
                          Image.asset(
                            "assets/icons/ball-icon.png",
                            width: 28.w,
                            height: 30.h,
                          ),
                          SizedBox(width: 10.w),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  Text(
                                    // "$name’s ",
                                    'Chetan Parmar',
                                    style: LexendtextFont400.copyWith(
                                      color: Colors.red,
                                      fontSize: 11.sp,
                                    ),
                                  ),
                                  Text(
                                    'Subscription expiring soon',
                                    style: LexendtextFont400.copyWith(
                                      color: AppColor.textcolorBlack,
                                      fontSize: 11.sp,
                                    ),
                                  ),
                                ],
                              ),
                              Text(
                                "Subscription End : 22/12/2025",
                                // "Subscription End : $endDate",
                                style: PoppinstextFont200.copyWith(
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
                  GestureDetector(
                    onTap: (){
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
                        children: [
                          Image.asset(
                            "assets/icons/ball-icon.png",
                            width: 28.w,
                            height: 30.h,
                          ),
                          SizedBox(width: 10.w),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  Text(
                                    // "$name’s ",
                                    'Chetan Parmar',
                                    style: LexendtextFont400.copyWith(
                                      color: Colors.red,
                                      fontSize: 11.sp,
                                    ),
                                  ),
                                  Text(
                                    'Subscription expiring soon',
                                    style: LexendtextFont400.copyWith(
                                      color: AppColor.textcolorBlack,
                                      fontSize: 11.sp,
                                    ),
                                  ),
                                ],
                              ),
                              Text(
                                "Subscription End : 22/12/2025",
                                // "Subscription End : $endDate",
                                style: PoppinstextFont200.copyWith(
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
                  GestureDetector(
                    onTap: (){
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
                        children: [
                          Image.asset(
                            "assets/icons/ball-icon.png",
                            width: 28.w,
                            height: 30.h,
                          ),
                          SizedBox(width: 10.w),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  Text(
                                    // "$name’s ",
                                    'Chetan Parmar',
                                    style: LexendtextFont400.copyWith(
                                      color: Colors.red,
                                      fontSize: 11.sp,
                                    ),
                                  ),
                                  Text(
                                    'Subscription expiring soon',
                                    style: LexendtextFont400.copyWith(
                                      color: AppColor.textcolorBlack,
                                      fontSize: 11.sp,
                                    ),
                                  ),
                                ],
                              ),
                              Text(
                                "Subscription End : 22/12/2025",
                                // "Subscription End : $endDate",
                                style: PoppinstextFont200.copyWith(
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
                  SizedBox(height: 20.h),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
