// lib/routes/app_routes.dart
import 'package:bb_sports/views/auth/login/login_screen.dart';
import 'package:bb_sports/views/instructor/home/instructor_home_screen.dart';
import 'package:bb_sports/views/instructor/main/instructor_main_screen.dart';
import 'package:bb_sports/views/instructor/profile/instructor_profile_screen.dart';
import 'package:bb_sports/views/splash/splash_screen.dart';
import 'package:bb_sports/views/students/home/student_home_screen.dart';
import 'package:bb_sports/views/students/matches/student_matches_screen.dart';
import 'package:bb_sports/views/students/profile/student_profile_screen.dart';
import 'package:get/get.dart';

class AppRoutes {
  static const String splash = '/';

  static const String login = '/login';
  static const String instructorMain = '/instructor';
  static const String instructorHome = '/instructor-home';
  static const String studentHome = '/student-home';
  static const String instructorProfile = '/instructor-profile';
  static const String studnetProfile = '/student-profile';
  static const String studentMatches = '/student-matches';

  static final routes = [
    GetPage(name: splash, page: () => const SplashScreen()),
    GetPage(name: login, page: () => const LoginScreen()),
    GetPage(name: instructorHome, page: () => const InstructorHomeScreen()),
    GetPage(name: studentHome, page: () => const StudentHomeScreen()),
    GetPage(
      name: instructorProfile,
      page: () => const InstructorProfileScreen(),
    ),
    GetPage(name: studnetProfile, page: () => const StudnetProfileScreen()),
    GetPage(name: instructorMain, page: () => const InstructorMainScreen()),
    GetPage(name: studentMatches, page: () => const StudentMatchesScreen()),
  ];
}
