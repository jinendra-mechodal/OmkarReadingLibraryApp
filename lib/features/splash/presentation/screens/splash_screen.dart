import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:library_app/res/colors/app_color.dart';

import '../../../../res/routes/app_routes.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    // Navigate to the login screen after a delay
    SchedulerBinding.instance.addPostFrameCallback((_) {
      Future.delayed(Duration(seconds: 3), () {
        Navigator.pushReplacementNamed(context, AppRoutes.login);
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.whiteColor,
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 56,
          ),
          child: Image.asset(
            'assets/images/welcom-logo.png',
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
  }
}
