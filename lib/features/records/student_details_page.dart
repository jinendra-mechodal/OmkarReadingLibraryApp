import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../res/colors/app_color.dart';
import '../../res/fonts/text_style.dart';
import '../../res/routes/app_routes.dart';
import 'Widgets/CustomSubscriptionDialog.dart';

class StudentDetailsPage extends StatefulWidget {
  const StudentDetailsPage({super.key});

  @override
  State<StudentDetailsPage> createState() => _StudentDetailsPageState();
}

class _StudentDetailsPageState extends State<StudentDetailsPage> {
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
                 print("tap");
                 Navigator.pushNamed(context, AppRoutes.studentRecordScreen);
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
      body: SingleChildScrollView(
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
                          "Chetan Parmar",
                          style: LexendtextFont500.copyWith(
                            color: AppColor.textcolor_blue,
                            fontSize: 14.sp,
                          ),
                        ),
                        Text(
                          "Register At 28-Jul-2023",
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
                          onTap: () {
                            // Handle delete icon tap
                            print('Delete icon tapped');
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
                            // Handle edit icon tap
                            print('Edit icon tapped');
                            Navigator.pushNamed(context, AppRoutes.studentDetailsEdit);

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
                          "Chetan Parmar",
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
                          "3245",
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
                          "98765 43210",
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
                          "999 9999 9999",
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
                            "With Lorem Ipzum's tool, you can insert texts directly with the ",
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
            Padding(
              padding: EdgeInsets.symmetric(
                horizontal: 16,
              ),
              child: Text(
                "Record",
                style: LexendtextFont500.copyWith(
                  color: AppColor.textcolor_blue,
                  fontSize: 14.sp,
                ),
              ),
            ),
            SizedBox(
              height: 18.h,
            ),
            Padding(
              padding: EdgeInsets.only(
                left: 16.w,
                right: 22.w,
              ),
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
                                '22-12-2024 To 22-01-2025',
                                style: LexendtextFont500.copyWith(
                                  color: AppColor.textcolorBlack,
                                  fontSize: 14.sp,
                                ),
                              ),
                              Text(
                                "Upgraded At At 28-Jul-2023",
                                // "Subscription End : $endDate",
                                style: mulishRegularFont300.copyWith(
                                  color: AppColor.textcolor_gray,
                                  fontSize: 10.sp,
                                ),
                              ),
                            ],
                          ),
                          Text(
                            "₹1200",
                            style: LexendtextFont500.copyWith(
                              color: AppColor.textcolorBlack,
                              fontSize: 14.sp,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 10.h,
                  ),
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
                                '22-12-2024 To 22-01-2025',
                                style: LexendtextFont500.copyWith(
                                  color: AppColor.textcolorBlack,
                                  fontSize: 14.sp,
                                ),
                              ),
                              Text(
                                "Upgraded At At 28-Jul-2023",
                                // "Subscription End : $endDate",
                                style: mulishRegularFont300.copyWith(
                                  color: AppColor.textcolor_gray,
                                  fontSize: 10.sp,
                                ),
                              ),
                            ],
                          ),
                          Text(
                            "₹1200",
                            style: LexendtextFont500.copyWith(
                              color: AppColor.textcolorBlack,
                              fontSize: 14.sp,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 10.h,
                  ),
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
                                '22-12-2024 To 22-01-2025',
                                style: LexendtextFont500.copyWith(
                                  color: AppColor.textcolorBlack,
                                  fontSize: 14.sp,
                                ),
                              ),
                              Text(
                                "Upgraded At At 28-Jul-2023",
                                // "Subscription End : $endDate",
                                style: mulishRegularFont300.copyWith(
                                  color: AppColor.textcolor_gray,
                                  fontSize: 10.sp,
                                ),
                              ),
                            ],
                          ),
                          Text(
                            "₹1200",
                            style: LexendtextFont500.copyWith(
                              color: AppColor.textcolorBlack,
                              fontSize: 14.sp,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 10.h,
                  ),
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
                                '22-12-2024 To 22-01-2025',
                                style: LexendtextFont500.copyWith(
                                  color: AppColor.textcolorBlack,
                                  fontSize: 14.sp,
                                ),
                              ),
                              Text(
                                "Upgraded At At 28-Jul-2023",
                                // "Subscription End : $endDate",
                                style: mulishRegularFont300.copyWith(
                                  color: AppColor.textcolor_gray,
                                  fontSize: 10.sp,
                                ),
                              ),
                            ],
                          ),
                          Text(
                            "₹1200",
                            style: LexendtextFont500.copyWith(
                              color: AppColor.textcolorBlack,
                              fontSize: 14.sp,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 10.h,
                  ),
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
                                '22-12-2024 To 22-01-2025',
                                style: LexendtextFont500.copyWith(
                                  color: AppColor.textcolorBlack,
                                  fontSize: 14.sp,
                                ),
                              ),
                              Text(
                                "Upgraded At At 28-Jul-2023",
                                // "Subscription End : $endDate",
                                style: mulishRegularFont300.copyWith(
                                  color: AppColor.textcolor_gray,
                                  fontSize: 10.sp,
                                ),
                              ),
                            ],
                          ),
                          Text(
                            "₹1200",
                            style: LexendtextFont500.copyWith(
                              color: AppColor.textcolorBlack,
                              fontSize: 14.sp,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 10.h,
                  ),
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
                                '22-12-2024 To 22-01-2025',
                                style: LexendtextFont500.copyWith(
                                  color: AppColor.textcolorBlack,
                                  fontSize: 14.sp,
                                ),
                              ),
                              Text(
                                "Upgraded At At 28-Jul-2023",
                                // "Subscription End : $endDate",
                                style: mulishRegularFont300.copyWith(
                                  color: AppColor.textcolor_gray,
                                  fontSize: 10.sp,
                                ),
                              ),
                            ],
                          ),
                          Text(
                            "₹1200",
                            style: LexendtextFont500.copyWith(
                              color: AppColor.textcolorBlack,
                              fontSize: 14.sp,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 10.h,
                  ),
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
                                '22-12-2024 To 22-01-2025',
                                style: LexendtextFont500.copyWith(
                                  color: AppColor.textcolorBlack,
                                  fontSize: 14.sp,
                                ),
                              ),
                              Text(
                                "Upgraded At At 28-Jul-2023",
                                // "Subscription End : $endDate",
                                style: mulishRegularFont300.copyWith(
                                  color: AppColor.textcolor_gray,
                                  fontSize: 10.sp,
                                ),
                              ),
                            ],
                          ),
                          Text(
                            "₹1200",
                            style: LexendtextFont500.copyWith(
                              color: AppColor.textcolorBlack,
                              fontSize: 14.sp,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 10.h,
                  ),
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
                                '22-12-2024 To 22-01-2025',
                                style: LexendtextFont500.copyWith(
                                  color: AppColor.textcolorBlack,
                                  fontSize: 14.sp,
                                ),
                              ),
                              Text(
                                "Upgraded At At 28-Jul-2023",
                                // "Subscription End : $endDate",
                                style: mulishRegularFont300.copyWith(
                                  color: AppColor.textcolor_gray,
                                  fontSize: 10.sp,
                                ),
                              ),
                            ],
                          ),
                          Text(
                            "₹1200",
                            style: LexendtextFont500.copyWith(
                              color: AppColor.textcolorBlack,
                              fontSize: 14.sp,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 10.h,
                  ),
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
                                '22-12-2024 To 22-01-2025',
                                style: LexendtextFont500.copyWith(
                                  color: AppColor.textcolorBlack,
                                  fontSize: 14.sp,
                                ),
                              ),
                              Text(
                                "Upgraded At At 28-Jul-2023",
                                // "Subscription End : $endDate",
                                style: mulishRegularFont300.copyWith(
                                  color: AppColor.textcolor_gray,
                                  fontSize: 10.sp,
                                ),
                              ),
                            ],
                          ),
                          Text(
                            "₹1200",
                            style: LexendtextFont500.copyWith(
                              color: AppColor.textcolorBlack,
                              fontSize: 14.sp,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 10.h,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      bottomSheet: Container(
        width: double.infinity,
        padding: EdgeInsets.all(16.w),
        color: AppColor.whiteColor,
        child: ElevatedButton(
          onPressed: () {
            _showCustomDialog(context); // Call the method to show the dialog
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: AppColor.btncolor, // Button background color
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12.0),
            ),
            padding: EdgeInsets.symmetric(vertical: 14.h), // Adjust vertical padding
          ),
          child: Text(
            'Add New Subscription',
            style: LexendtextFont700.copyWith(
              color: AppColor.whiteColor,
              fontSize: 16.sp,
            ),
          ),
        ),
      ),

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
        );
      },
    );
  }

}
