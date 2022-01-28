import 'package:auto_route/annotations.dart';
import 'package:zawadi/presentation/sign_in/forgot_password_page.dart';
import 'package:zawadi/presentation/sign_in/sign_in_page.dart';
import 'package:zawadi/presentation/sign_in/sign_up_page.dart';
import 'package:zawadi/presentation/splash/on_boarding/main.dart';
// import 'package:zawadi/presentation/splash/onboarding_page.dart';
import 'package:zawadi/presentation/splash/splash_page.dart';
import 'package:zawadi/presentation/splash/splash_page2.dart';

@CupertinoAutoRouter(
  routes: <AutoRoute>[
    CupertinoRoute<dynamic>(page: SplashPage),
    CupertinoRoute<dynamic>(
      page: SplashPage2,
    ), //this is acting like a home page for now
    CupertinoRoute<dynamic>(page: SignInPage),
    CupertinoRoute<dynamic>(page: SignUpPage),
    CupertinoRoute<dynamic>(page: ForgotPasswordPage),

    // CupertinoRoute<dynamic>(page: OnBoardingPage),
    CupertinoRoute<dynamic>(page: OnBoarding, initial: true),
    // MaterialRoute(page: NoteFormPage, fullscreenDialog: true),
  ],
)
class $Router {}
