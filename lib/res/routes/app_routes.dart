import 'package:flutter/material.dart';

import '../../features/available_students/presentation/screens/available_student_screen.dart';
import '../../features/home_page/accountant_home_page.dart';
import '../../features/home_page/home_page.dart';
import '../../features/home_page/super_admin_home_page.dart';
import '../../features/home_page/supervisor_home_page.dart';
import '../../features/login/presentation/screens/login_screen.dart';
import '../../features/notification/notification.dart';
import '../../features/payment/presentation/screens/print_payment_screen.dart';
import '../../features/records/student_details_page.dart';
import '../../features/records/student_record_edit.dart';
import '../../features/records/students_record.dart';
import '../../features/registration/presentation/screens/registration_screen.dart';
import '../../features/report/presentation/screens/student_report_screen.dart';
import '../../features/splash/presentation/screens/splash_screen.dart';
import '../../features/success/success_registration_screen.dart';
import '../../features/success/success_student_details_screen.dart';

class AppRoutes {
  static const String splash = '/splash';
  static const String login = '/login';
  static const String home = '/home';
  static const String registration = '/registration';
  static const String printPaymentScreen = '/printPaymentScreen';
  static const String studentReportScreen = '/studentReportScreen';
  static const String studentRecordScreen = '/studentRecordScreen';
  static const String registrationSuccess = '/registrationSuccess ';
  static const String studentDetailsSuccess = '/studentDetailsSuccess ';
  static const String studentsdetails = '/studentsdetails ';
  static const String studentDetailsEdit = '/studentDetailsEdit ';
  static const String availableStudents = '/available_students';
  static const String notification = '/Notification';

  static const String superAdminHome = '/super_admin_home';
  static const String supervisorHome = '/supervisor_home';
  static const String accountantHome = '/accountant_home';

  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case splash:
        return MaterialPageRoute(builder: (_) => SplashScreen());
      case login:
        return MaterialPageRoute(builder: (_) => LoginScreen());
      case home:
        return MaterialPageRoute(builder: (_) => HomePage());
      case superAdminHome:
        return MaterialPageRoute(builder: (_) => SuperAdminHomePage());
      case supervisorHome:
        return MaterialPageRoute(builder: (_) => SupervisorHomePage());
      case accountantHome:
        return MaterialPageRoute(builder: (_) => AccountantHomePage());
      case notification:
        return MaterialPageRoute(builder: (_) => NotificationPage());
      case registration:
        return MaterialPageRoute(builder: (_) => RegistrationScreen());
      case registrationSuccess:
        return MaterialPageRoute(builder: (_) => SuccessRegistrationScreen());
      case availableStudents:
        return MaterialPageRoute(builder: (_) => AvailableStudentScreen());
      case studentDetailsEdit:
        return MaterialPageRoute(builder: (_) => StudentRecordEdit());
      case studentsdetails:
        return MaterialPageRoute(builder: (_) => StudentDetailsPage());
      case studentDetailsSuccess:
        return MaterialPageRoute(builder: (_) => SuccessStudentDetailsScreen());

      case printPaymentScreen:
        return MaterialPageRoute(builder: (_) => PrintPaymentScreen());
      case studentReportScreen:
        return MaterialPageRoute(builder: (_) => StudentReportScreen());
        case studentRecordScreen:
        return MaterialPageRoute(builder: (_) => StudentsRecord());

      default:
        return _errorRoute();
    }
  }

  static Route<dynamic> _errorRoute() {
    return MaterialPageRoute(
      builder: (_) => Scaffold(
        appBar: AppBar(
          title: Text('Error'),
        ),
        body: Center(
          child: Text('Page not found'),
        ),
      ),
    );
  }
}
