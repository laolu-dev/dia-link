import 'package:dialink/src/config/router/route_names.dart';
import 'package:dialink/src/features/authentication/presentation/controller/authentication_controller.dart';
import 'package:dialink/src/features/authentication/presentation/views/login_screen.dart';
import 'package:dialink/src/features/authentication/presentation/views/signup_screen.dart';
import 'package:dialink/src/features/authentication/presentation/views/verify_email_screen.dart';
import 'package:dialink/src/features/book-appointment/presentation/views/home_screen.dart';
import 'package:dialink/src/features/landing/landing_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AppRouter {
  AppRouter._();
  static final AppRouter _instance = AppRouter._();
  final GlobalKey<NavigatorState> _routerKey = GlobalKey<NavigatorState>();

  static AppRouter get instance => _instance;
  GlobalKey<NavigatorState> get routerKey => _routerKey;

  Route<dynamic>? routes(RouteSettings settings) {
    final arg = settings.arguments;
    final AuthenticationNotifier authController = AuthenticationNotifier();

    switch (settings.name) {
      case RouteName.landing:
        return MaterialPageRoute(builder: (context) => LandingScreen());

      case RouteName.signup:
        return MaterialPageRoute(
          builder: (context) => ChangeNotifierProvider.value(
            value: authController,
            child: SignupScreen(),
          ),
        );

      case RouteName.login:
        return MaterialPageRoute(
          builder: (context) => ChangeNotifierProvider.value(
            value: authController,
            child: LoginScreen(),
          ),
        );

      case RouteName.verify:
        return MaterialPageRoute(
          builder: (context) => ChangeNotifierProvider.value(
            value: authController,
            child: VerifyEmailScreen(email: arg as String),
          ),
        );

      case RouteName.home:
        return MaterialPageRoute(builder: (context) => HomeScreen());

      default:
        return _unknownRoute();
    }
  }

  Route<dynamic> _unknownRoute() {
    return MaterialPageRoute(
      builder: (context) {
        return Scaffold(
          appBar: AppBar(
            centerTitle: true,
            title: Text("Router Error"),
          ),
          body: Center(
            child: Text("Screen does not exist"),
          ),
        );
      },
    );
  }
}
