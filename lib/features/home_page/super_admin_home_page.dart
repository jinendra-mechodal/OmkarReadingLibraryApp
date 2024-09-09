import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../res/colors/app_color.dart';
import '../../../../res/fonts/text_style.dart';

class SuperAdminHomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.whiteColor,
      appBar: AppBar(
        title: Text('Super Admin Home', style: LexendtextFont500),
      ),
      body: Center(
        child: Text(
          'Welcome Super Admin!',
          style: LexendtextFont500.copyWith(fontSize: 24.sp),
        ),
      ),
    );
  }
}
