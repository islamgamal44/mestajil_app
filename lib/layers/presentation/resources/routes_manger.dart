// ignore_for_file: no_duplicate_case_values, prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:mmuussttaaeejjiill/layers/presentation/resources/strings_manger.dart';

import '../../app/di.dart';
import '../forget_password/view/forget_password_view.dart';
import '../login/view/login_view.dart';
import '../main/main_view.dart';
import '../onboarding/view/onboarding_view.dart';
import '../register/view/register_view.dart';
import '../splash/splash_view.dart';
import '../store_details/store_details_view.dart';

class Routes {
  static const String splachRoute = "/";
  static const String loginRoute = "/login";
  static const String registerRoute = "/register";
  static const String onBoardingRoute = "/onBoarding";
  static const String forgetPasswordRoute = "/forgetPassword";
  static const String mainRoute = "/main";
  static const String storeDetailsRoute = "/storeDetails";
}

class RouteGenerator {
  static Route<dynamic> getRoute(RouteSettings settings) {
    switch (settings.name) {
      case Routes.splachRoute:
        return MaterialPageRoute(builder: (_) => SplashView());
      case Routes.onBoardingRoute:
        return MaterialPageRoute(builder: (_) => OnBoardingView());
      case Routes.loginRoute:
        initLoginModule();
        return MaterialPageRoute(builder: (_) => LoginView());
      case Routes.registerRoute:
        initRegisterModule();
        return MaterialPageRoute(builder: (_) => RegisterView());
      case Routes.forgetPasswordRoute:
        initForgotPasswordModule();

        return MaterialPageRoute(builder: (_) => ForgetPasswordView());
      case Routes.mainRoute:
        initHomeModule();
        return MaterialPageRoute(builder: (_) => MainView());
      case Routes.storeDetailsRoute:
        return MaterialPageRoute(builder: (_) => StoreDetailsView());

      default:
        return unDefinedRoute();
    }
  }

  static Route<dynamic> unDefinedRoute() {
    return MaterialPageRoute(
        builder: (_) => Scaffold(
              appBar: AppBar(
                title: Text(AppStrings.noRouteFound),
              ),
              body: Center(
                child: Text(AppStrings.noRouteFound),
              ),
            ));
  }
}
