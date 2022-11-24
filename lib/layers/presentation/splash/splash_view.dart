// ignore_for_file: prefer_const_constructors

import 'dart:async';

import 'package:flutter/material.dart';

import '../../app/app_prefs.dart';
import '../../app/di.dart';
import '../resources/assets_manger.dart';
import '../resources/color_manger.dart';
import '../resources/constants_manger.dart';
import '../resources/routes_manger.dart';

class SplashView extends StatefulWidget {
  const SplashView({Key? key}) : super(key: key);

  @override
  State<SplashView> createState() => _SplashViewState();
}

class _SplashViewState extends State<SplashView> {
  Timer? _timer;
  final AppPreferences _appPreferences = instance<AppPreferences>();

  _startDelay() {
    _timer = Timer(Duration(seconds: AppConstants.splashDelay), _goNext);
  }

  _goNext() async {
    _appPreferences.isUserLoggedIn().then((isUserLoggedIn) => {
          if (isUserLoggedIn)
            {
              // navigate to main screen
              Navigator.pushReplacementNamed(context, Routes.mainRoute)
            }
          else
            {
              _appPreferences
                  .isOnBoardingScreenViewed()
                  .then((isOnBoardingScreenViewed) => {
                        if (isOnBoardingScreenViewed)
                          {
                            // navigate to login screen

                            Navigator.pushReplacementNamed(
                                context, Routes.loginRoute)
                          }
                        else
                          {
                            // navigate to onboarding screen

                            Navigator.pushReplacementNamed(
                                context, Routes.onBoardingRoute)
                          }
                      })
            }
        });
    Navigator.pushReplacementNamed(context, Routes.onBoardingRoute);
  }

  @override
  void initState() {
    super.initState();
    _startDelay();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorManger.white,
      body: Center(
        child: Image(
          height: 250,
          width: 250,
          image: AssetImage(ImageAssets.splachLogo),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }
}
