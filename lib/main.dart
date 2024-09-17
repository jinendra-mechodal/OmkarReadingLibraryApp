import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:library_app/res/app_url/app_url.dart';
import 'package:library_app/res/routes/app_routes.dart';
import 'package:provider/provider.dart';

import 'features/available_students/data/student_repository.dart';
import 'features/available_students/domain/student_view_model.dart';
import 'features/home_page/Superadmin/ViewModel/student_dashboard_viewmodel.dart';
import 'features/home_page/Superadmin/data/student_dashboard_repository.dart';
import 'features/home_page/Superwiser/ViewModel/superwiser_student_dashboard_viewmodel.dart';
import 'features/home_page/Superwiser/data/SuperwiserStudentDashboardRepository.dart';
import 'features/login/data/login_repository.dart';
import 'features/login/view_models/login_usecase.dart';

import 'features/notification/ViewModel/NotificationViewModel.dart';
import 'features/notification/ViewModel/home_notification_viewmodel.dart';
import 'features/payment/ViewModal/PrintPaymentViewModel.dart';
import 'features/records/student_record/view_modal_studentrecord/student_record_view_model.dart';
import 'features/records/student_record_details/Widgets/data/subscription_repository.dart';
import 'features/records/student_record_details/Widgets/ViewModel/subscription_view_model.dart';
import 'features/records/student_record_details/student_details_view_model/student_details_view_model.dart';
import 'features/registration/data/registration_repository.dart';
import 'features/registration/presentation/viewmodels/registration_view_model.dart';
import 'features/report/domain/student_report_view_model.dart';

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
          create: (context) => LoginViewModel(
              AuthRepository()), // Ensure AuthRepository is correctly implemented
        ),
        ChangeNotifierProvider(
          create: (context) => RegistrationViewModel(
              RegistrationRepository()), // Ensure RegistrationRepository is correctly implemented
        ),
        ChangeNotifierProvider(
          create: (context) =>
              StudentReportViewModel(), // Ensure StudentReportViewModel is correctly implemented
        ),
        ChangeNotifierProvider(
          create: (context) =>
              StudentRecordViewModel(), // Ensure StudentRecordViewModel is correctly implemented
        ),
        ChangeNotifierProvider(
          create: (context) =>
              NotificationViewModel(), // Ensure NotificationViewModel is correctly implemented
        ),
        ChangeNotifierProvider(
          create: (context) =>
              HomeNotificationViewModel(), // Ensure NotificationViewModel is correctly implemented
        ),
        ChangeNotifierProvider(
          create: (context) => StudentViewModel(context.read<
              StudentRepository>()), // Ensure StudentViewModel is correctly implemented
        ),
        Provider(
          create: (_) =>
              StudentRepository(), // Ensure StudentRepository is correctly implemented
        ),
        ChangeNotifierProvider(
          create: (context) => StudentViewModel(context.read<
              StudentRepository>()), // Ensure StudentViewModel is correctly implemented
        ),
        ChangeNotifierProvider(
          create: (context) => StudentDashboardViewModel(),
        ),
        Provider<SupervisorStudentDashboardRepository>(
          create: (_) => SupervisorStudentDashboardRepository(),
        ),
        ChangeNotifierProvider<SupervisorStudentDashboardViewModel>(
          create: (context) => SupervisorStudentDashboardViewModel(
            Provider.of<SupervisorStudentDashboardRepository>(context,
                listen: false),
          ),
        ),

        ChangeNotifierProvider(create: (_) => StudentDetailsViewModel()),
        ChangeNotifierProvider(
          create: (context) => SubscriptionViewModel(
            SubscriptionRepository(),
          ),
        ),

        ChangeNotifierProvider(create: (_) => PrintPaymentViewModel()),

        ChangeNotifierProvider(create: (_) => NotificationViewModel()),
      ],
      child: ScreenUtilInit(
        designSize: const Size(360, 690),
        minTextAdapt: true,
        splitScreenMode: true,
        builder: (context, child) {
          return const MaterialApp(
            debugShowCheckedModeBanner: false,
            title: 'Library App',
            initialRoute: AppRoutes.splash,
            onGenerateRoute: AppRoutes.generateRoute,
          );
        },
      ),
    );
  }
}
