import 'package:auto_route/annotations.dart';
import 'package:zawadi/presentation/sign_in/sign_in_page.dart';
import 'package:zawadi/presentation/splash/onboarding_page.dart';
import 'package:zawadi/presentation/splash/splash_page.dart';
import 'package:zawadi/presentation/splash/splash_page2.dart';

@MaterialAutoRouter(
  routes: <AutoRoute>[
    MaterialRoute<dynamic>(page: SplashPage),
    MaterialRoute<dynamic>(page: SplashPage2),
    MaterialRoute<dynamic>(page: SignInPage),
    MaterialRoute<dynamic>(page: OnBoardingPage, initial: true),
    // MaterialRoute(page: NoteFormPage, fullscreenDialog: true),
  ],
)
class $Router {}
