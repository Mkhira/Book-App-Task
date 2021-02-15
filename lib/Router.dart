

import 'package:booktask/Navigation/Navigation.dart';
import 'package:booktask/Views/inatial/HomePage.dart';
import 'package:flutter/material.dart';

import 'Constant/RoutesConstants.dart';
import 'Views/inatial/SignIn.dart';
import 'Views/inatial/Splash.dart';
import 'Views/inatial/sign_up.dart';

class PageRouter{
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case RoutesConstants.splash:
        return PageNavigation(child: Splash(), settings: settings);
      case RoutesConstants.signIn:
        return PageNavigation(
            child: SignIn(), settings: settings);

      case RoutesConstants.signUp:
        return PageNavigation(
            child:SignUp(), settings: settings);

      case RoutesConstants.homePage:
        return PageNavigation(
            child:HomePage(), settings: settings);

    }

    }
}