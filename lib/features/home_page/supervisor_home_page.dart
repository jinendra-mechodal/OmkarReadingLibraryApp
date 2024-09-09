import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../res/colors/app_color.dart';
import '../../../../res/fonts/text_style.dart';

class SupervisorHomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.whiteColor,
      appBar: AppBar(
        title: Text('Supervisor Home', style: LexendtextFont500),
      ),
      body: Center(
        child: Text(
          'Welcome Supervisor!',
          style: LexendtextFont500.copyWith(fontSize: 24.sp),
        ),
      ),
    );
  }
}
