import 'package:flutter/material.dart';
import 'package:sync_classroom/screens/auth/login/login_screen.dart';
import 'package:sync_classroom/screens/auth/register/register_screen.dart';
import 'package:sync_classroom/screens/home/home_screen.dart';
import 'package:sync_classroom/screens/live_class/class/class_screen.dart';
import 'package:sync_classroom/screens/live_class/class_search/class_search_screen.dart';
import 'package:sync_classroom/screens/profile/create_profile_info.dart';
import 'package:sync_classroom/screens/profile/show_profile.dart';
import 'package:sync_classroom/styles/app_texts.dart';

class RouteGenerator {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    final args = settings.arguments;

    switch (settings.name) {
      case AppTexts.homeRoute:
        return MaterialPageRoute(
          builder: (_) => const HomeScreen(),
          settings: settings,
        );
      case AppTexts.loginRoute:
        return MaterialPageRoute(
          builder: (_) => const LoginScreen(),
          settings: settings,
        );
      case AppTexts.registerRoute:
        return MaterialPageRoute(
          builder: (_) => const RegisterScreen(),
          settings: settings,
        );
      case AppTexts.teacherListRoute:
        return MaterialPageRoute(
          builder: (_) => const HomeScreen(),
          settings: settings,
        );
      case AppTexts.classDetailRoute:
        return MaterialPageRoute(
          builder: (_) => const ClassDetailsScreen(),
          settings: settings,
        );
      case AppTexts.profileInfoRoute:
        if (args is List<String>) {
          return MaterialPageRoute(
            builder: (_) => ProfileInfoScreen(interests: args),
            settings: settings,
          );
        }
        return _errorRoute();
      case AppTexts.showProfileRoute:
        return MaterialPageRoute(
          builder: (_) => const ShowProfile(),
          settings: settings,
        );
      case AppTexts.classScreenRoute:
        return MaterialPageRoute(
          builder: (_) =>  ClassScreen(),
          settings: settings,
        );
      default:
        return _errorRoute();
    }
  }

  static Route<dynamic> _errorRoute() {
    return MaterialPageRoute(
      builder: (_) => Scaffold(
        appBar: AppBar(
          title: const Text('Error'),
        ),
        body: const Center(
          child: Text('ERROR'),
        ),
      ),
    );
  }
}
