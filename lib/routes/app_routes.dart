import 'package:flutter/material.dart';

import 'package:opsento_ats/features/auth/presentaion/login_page.dart';
import 'package:opsento_ats/features/bottomnavbar/recruiter/presention/recruiteer_main_layout.dart';
import 'package:opsento_ats/features/candidatefolder/candidate/presentaion/candidate_page.dart';
import 'package:opsento_ats/features/candidatefolder/candidate_screen/presentaion/candidate_page.dart';
import 'package:opsento_ats/features/candidatefolder/candidate_screen/presentaion/resume_page.dart';
import 'package:opsento_ats/features/onboard/onboard_page.dart';
import 'package:opsento_ats/features/splash_screen/splash_screen.dart';

class AppRoutes {
  static const String splashPage = '/splashPage';
  static const String onboard = '/onboard';
  static const String login = '/login';
  static const String mainlayout = '/mainlayout';
  static const String candidate = '/candidate';
  static const String candidatepage = '/candidatepage';
  static const String resume = '/resume';
  static const String recruitermainlayout = '/recruitermainlayout';

  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {

      case splashPage:
        return MaterialPageRoute(
          builder: (_) => const SplashPage(),
        );

      case onboard:
        return MaterialPageRoute(
          builder: (_) => const OnboardPage(),
        );

      case login:
        return MaterialPageRoute(
          builder: (_) => const LoginPage(),
        );

      // case mainlayout:
      //   return MaterialPageRoute(
      //     builder: (_) => const RecruiterMainLayout(),
      //   );

      case candidate:
        return MaterialPageRoute(
          builder: (_) => const CandidatePage(),
        );
        
      case candidatepage:
        return MaterialPageRoute(
          builder: (_) => const CandidateProfilePage(),
        );
        case resume:
        return MaterialPageRoute(
          builder: (_) => const ResumePage(),
        );
          case recruitermainlayout:
        return MaterialPageRoute(
          builder: (_) => const RecruiterMainLayout(),
        );
        

      default:
        return MaterialPageRoute(
          builder: (_) => const Scaffold(
            body: Center(
              child: Text("Page Not Found"),
            ),
          ),
        );
    }
  }
}