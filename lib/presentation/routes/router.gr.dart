// **************************************************************************
// AutoRouteGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouteGenerator
// **************************************************************************

import 'package:auto_route/auto_route.dart' as _i6;
import 'package:flutter/material.dart' as _i7;

import '../sign_in/sign_in_page.dart' as _i3;
import '../sign_in/sign_up_page.dart' as _i4;
import '../splash/onboarding_page.dart' as _i5;
import '../splash/splash_page.dart' as _i1;
import '../splash/splash_page2.dart' as _i2;

class Router extends _i6.RootStackRouter {
  Router([_i7.GlobalKey<_i7.NavigatorState>? navigatorKey])
      : super(navigatorKey);

  @override
  final Map<String, _i6.PageFactory> pagesMap = {
    SplashPageRoute.name: (routeData) {
      return _i6.MaterialPageX<dynamic>(
          routeData: routeData, child: const _i1.SplashPage());
    },
    SplashPage2Route.name: (routeData) {
      return _i6.MaterialPageX<dynamic>(
          routeData: routeData, child: const _i2.SplashPage2());
    },
    SignInPageRoute.name: (routeData) {
      return _i6.MaterialPageX<dynamic>(
          routeData: routeData, child: const _i3.SignInPage());
    },
    SigningUpPageRoute.name: (routeData) {
      return _i6.MaterialPageX<dynamic>(
          routeData: routeData, child: const _i4.SigningUpPage());
    },
    OnBoardingPageRoute.name: (routeData) {
      return _i6.MaterialPageX<dynamic>(
          routeData: routeData, child: const _i5.OnBoardingPage());
    }
  };

  @override
  List<_i6.RouteConfig> get routes => [
        _i6.RouteConfig(SplashPageRoute.name, path: '/splash-page'),
        _i6.RouteConfig(SplashPage2Route.name, path: '/splash-page2'),
        _i6.RouteConfig(SignInPageRoute.name, path: '/sign-in-page'),
        _i6.RouteConfig(SigningUpPageRoute.name, path: '/signing-up-page'),
        _i6.RouteConfig(OnBoardingPageRoute.name, path: '/')
      ];
}

/// generated route for [_i1.SplashPage]
class SplashPageRoute extends _i6.PageRouteInfo<void> {
  const SplashPageRoute() : super(name, path: '/splash-page');

  static const String name = 'SplashPageRoute';
}

/// generated route for [_i2.SplashPage2]
class SplashPage2Route extends _i6.PageRouteInfo<void> {
  const SplashPage2Route() : super(name, path: '/splash-page2');

  static const String name = 'SplashPage2Route';
}

/// generated route for [_i3.SignInPage]
class SignInPageRoute extends _i6.PageRouteInfo<void> {
  const SignInPageRoute() : super(name, path: '/sign-in-page');

  static const String name = 'SignInPageRoute';
}

/// generated route for [_i4.SigningUpPage]
class SigningUpPageRoute extends _i6.PageRouteInfo<void> {
  const SigningUpPageRoute() : super(name, path: '/signing-up-page');

  static const String name = 'SigningUpPageRoute';
}

/// generated route for [_i5.OnBoardingPage]
class OnBoardingPageRoute extends _i6.PageRouteInfo<void> {
  const OnBoardingPageRoute() : super(name, path: '/');

  static const String name = 'OnBoardingPageRoute';
}
