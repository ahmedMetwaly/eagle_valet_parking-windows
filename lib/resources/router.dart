import 'package:eagle_valet_parking/generated/l10n.dart';
import 'package:eagle_valet_parking/resources/routes.dart';
import 'package:eagle_valet_parking/view/authentication/screens/signup/screens/verfy_email.dart';
import 'package:eagle_valet_parking/view/calculate_duration/calculate_duaration.dart';
import 'package:flutter/material.dart';

import '../view/authentication/screens/first_time_opened/first_time_opened.dart';
import '../view/authentication/screens/login/login.dart';
import '../view/authentication/screens/login/widgets/forget_password.dart';
import '../view/authentication/screens/login/widgets/reset_email.dart';
import '../view/home/home.dart';
import '../view/onboarding/onboarding.dart';
import '../view/profile/profile.dart';
import '../view/splash_screen/splash_screen.dart';

class RoutesGeneratour {
  static Route<dynamic> getRoute(RouteSettings route) {
    switch (route.name) {
      case Routes.splashScreen:
        return MaterialPageRoute(builder: (_) => const SplashScreen());
      case Routes.appStarts:
        return MaterialPageRoute(builder: (_) => const AppStarts());
      case Routes.onBoarding:
        return MaterialPageRoute(builder: (_) => const OnBoarding());
      case Routes.resetEmail:
        return MaterialPageRoute(builder: (_) => const ResetEmail());
      case Routes.forgetPassword:
        return MaterialPageRoute(builder: (_) => const ForgetPassword());
      case Routes.verifyEmail:
        return MaterialPageRoute(builder: (_) => const VerifyEmail());
      case Routes.logIn:
        return MaterialPageRoute(builder: (_) => const LogIn());
      case Routes.home:
        return MaterialPageRoute(builder: (_) => const Home());
      case Routes.calculateDuaration:
        return MaterialPageRoute(builder: (_) => const CalculateDuaration());
      case Routes.profile:
        return MaterialPageRoute(
            builder: (_) => const Profile(), settings: route);

      default:
        return unFoundedRoute();
    }
  }

  static Route<dynamic> unFoundedRoute() {
    return MaterialPageRoute(
        builder: (_) => Scaffold(
              appBar: AppBar(title: Text(S.current.error)),
              body: Center(child: Text(S.current.error)),
            ));
  }
}
