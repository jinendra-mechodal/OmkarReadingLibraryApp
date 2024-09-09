
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:library_app/res/routes/app_routes.dart';import 'package:provider/provider.dart';

import 'features/login/data/login_repository.dart';
import 'features/login/view_models/login_usecase.dart';


void main() {
   runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    return MultiProvider(
        providers: [
        ChangeNotifierProvider(
        create: (context) => LoginViewModel(AuthRepository()),
    ),
    // Add other providers if needed
    ],
    child : ScreenUtilInit(
      designSize: const Size(360, 690),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) {
        return const MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Library App',
           initialRoute: AppRoutes.splash,
           onGenerateRoute: AppRoutes.generateRoute,
          //home: StudentDetailsPage(),
        );
      },
    ));
  }
}

