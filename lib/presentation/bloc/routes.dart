import 'package:flutter/material.dart';
import '../../features_page.dart';
import '../pages/auth/auth_page.dart';
import '../pages/home/home_page.dart';
import '../pages/investments/invest_page.dart';
import '../widgets/howitworks_page.dart';
import '../widgets/learn_more_page.dart';


class AppRoutes {
  static const String home = '/';
  static const String auth = '/auth';
  static const String features = '/features';
  static const String howItWorks = '/how-it-works';
  static const String invest = '/invest';
  static const String learnMore = '/learn-more';

  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case home:
        return MaterialPageRoute(builder: (_) => HomePage());
      case auth:
        return MaterialPageRoute(builder: (_) => AuthPage());
      case features:
        return MaterialPageRoute(builder: (_) => FeaturesPage());
      case howItWorks:
        return MaterialPageRoute(builder: (_) => HowItWorksPage());
      case invest:
        return MaterialPageRoute(builder: (_) => InvestPage());
      case learnMore:
        return MaterialPageRoute(builder: (_) => LearnMorePage());
      default:
        return MaterialPageRoute(
          builder: (_) => Scaffold(
            body: Center(
              child: Text('No route defined for ${settings.name}'),
            ),
          ),
        );
    }
  }
}