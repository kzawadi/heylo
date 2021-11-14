// **************************************************************************
// AutoRouteGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouteGenerator
// **************************************************************************

import 'package:auto_route/auto_route.dart' as _i7;
import 'package:flutter/material.dart' as _i8;

import '../sign_in/forgot_password_page.dart' as _i5;
import '../sign_in/sign_in_page.dart' as _i3;
import '../sign_in/sign_up_page.dart' as _i4;
import '../splash/onboarding_page.dart' as _i6;
import '../splash/splash_page.dart' as _i1;
import '../splash/splash_page2.dart' as _i2;

class Router extends _i7.RootStackRouter {
  Router([_i8.GlobalKey<_i8.NavigatorState>? navigatorKey])
      : super(navigatorKey);

  @override
  final Map<String, _i7.PageFactory> pagesMap = {
    SplashPageRoute.name: (routeData) {
      return _i7.CupertinoPageX<dynamic>(
          routeData: routeData, child: const _i1.SplashPage());
    },
    SplashPage2Route.name: (routeData) {
      return _i7.CupertinoPageX<dynamic>(
          routeData: routeData, child: const _i2.SplashPage2());
    },
    SignInPageRoute.name: (routeData) {
      return _i7.CupertinoPageX<dynamic>(
          routeData: routeData, child: const _i3.SignInPage());
    },
    SignUpPageRoute.name: (routeData) {
      return _i7.CupertinoPageX<dynamic>(
          routeData: routeData, child: const _i4.SignUpPage());
    },
    ForgotPasswordPageRoute.name: (routeData) {
      return _i7.CupertinoPageX<dynamic>(
          routeData: routeData, child: const _i5.ForgotPasswordPage());
    },
    OnBoardingPageRoute.name: (routeData) {
      return _i7.CupertinoPageX<dynamic>(
          routeData: routeData, child: const _i6.OnBoardingPage());
    }
  };

  @override
  List<_i7.RouteConfig> get routes => [
        _i7.RouteConfig(SplashPageRoute.name, path: '/splash-page'),
        _i7.RouteConfig(SplashPage2Route.name, path: '/splash-page2'),
        _i7.RouteConfig(SignInPageRoute.name, path: '/sign-in-page'),
        _i7.RouteConfig(SignUpPageRoute.name, path: '/sign-up-page'),
        _i7.RouteConfig(ForgotPasswordPageRoute.name,
            path: '/forgot-password-page'),
        _i7.RouteConfig(OnBoardingPageRoute.name, path: '/')
      ];
}

/// generated route for [_i1.SplashPage]
class SplashPageRoute extends _i7.PageRouteInfo<void> {
  const SplashPageRoute() : super(name, path: '/splash-page');

  static const String name = 'SplashPageRoute';
}

/// generated route for [_i2.SplashPage2]
class SplashPage2Route extends _i7.PageRouteInfo<void> {
  const SplashPage2Route() : super(name, path: '/splash-page2');

  static const String name = 'SplashPage2Route';
}

/// generated route for [_i3.SignInPage]
class SignInPageRoute extends _i7.PageRouteInfo<void> {
  const SignInPageRoute() : super(name, path: '/sign-in-page');

  static const String name = 'SignInPageRoute';
}

/// generated route for [_i4.SignUpPage]
class SignUpPageRoute extends _i7.PageRouteInfo<void> {
  const SignUpPageRoute() : super(name, path: '/sign-up-page');

  static const String name = 'SignUpPageRoute';
}

/// generated route for [_i5.ForgotPasswordPage]
class ForgotPasswordPageRoute extends _i7.PageRouteInfo<void> {
  const ForgotPasswordPageRoute() : super(name, path: '/forgot-password-page');

  static const String name = 'ForgotPasswordPageRoute';
}

/// generated route for [_i6.OnBoardingPage]
class OnBoardingPageRoute extends _i7.PageRouteInfo<void> {
  const OnBoardingPageRoute() : super(name, path: '/');

  static const String name = 'OnBoardingPageRoute';
}
