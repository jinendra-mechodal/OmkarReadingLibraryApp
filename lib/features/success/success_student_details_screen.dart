
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../res/colors/app_color.dart';
import '../../res/fonts/text_style.dart';
import '../../../../res/routes/app_routes.dart';

class SuccessStudentDetailsScreen extends StatelessWidget {
  const SuccessStudentDetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.whiteColor,
      body: Center(
        child: Padding(
          padding: EdgeInsets.all(16.w),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Image.asset(
                "assets/icons/success-icon.png",
                height: 84.h,
                width: 84.w,
              ),
              SizedBox(height: 20.h),
              Text(
                'Subscription updated \nsuccessfully',
                style: LexendtextFont500.copyWith(
                  fontSize: 20.sp,
                  color: AppColor.textcolorBlack,
                ),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 20.h),

              InkWell(
                onTap: (){
                  // Redirect to Home page
                 // Navigator.pushNamed(context, AppRoutes.availableStudents);
                  Navigator.pop(context);
                  Navigator.pop(context);

                },
                child: Container(
                  width: double.infinity,
                  height: 60.h,
                  decoration: ShapeDecoration(
                    shape: RoundedRectangleBorder(),
                    color: Colors.transparent,
                  ),
                  child: DecoratedBox(
                    child: Center(
                      child: Text(
                          'Print Payment Slip',
                          style:LexendtextFont700.copyWith(
                            fontSize: 16.sp,
                            color: AppColor.whiteColor,
                          )

                      ),
                    ),
                    decoration: ShapeDecoration(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      color:AppColor.textcolor_gold,
                    ),
                  ),
                ),
              ),
              SizedBox(height: 20.h),

              InkWell(
                onTap: (){
                  // Redirect to Home page
                 // Navigator.pushNamed(context, AppRoutes.home);
                  Navigator.pop(context);
                  Navigator.pop(context);
                  Navigator.pop(context);
                  Navigator.pop(context);


                  // Navigator.pushNamed(
                  //   context,
                  //   AppRoutes.studentsdetails,
                  //   arguments: record.id, // Pass the student ID as an argument
                  // );
                  // Future.microtask(() {
                  //   Navigator.pop(context); // Close the current dialog or page
                  //   Navigator.pop(context); // Navigate back to the previous page
                  // });

                },
                child: Container(
                  width: double.infinity,
                  height: 60.h,
                  decoration: ShapeDecoration(
                    shape: RoundedRectangleBorder(),
                    color: Colors.transparent,
                  ),
                  child: DecoratedBox(
                    child: Center(
                      child: Text(
                          'Go To Dashbord',
                          style:LexendtextFont700.copyWith(
                            fontSize: 16.sp,
                            color: AppColor.whiteColor,
                          )

                      ),
                    ),
                    decoration: ShapeDecoration(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      color:AppColor.btncolor,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
