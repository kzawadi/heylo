import 'package:auto_route/annotations.dart';
import 'package:zawadi/counter/view/counter_page.dart';
import 'package:zawadi/presentation/splash/splash_page.dart';

// ignore_for_file: implicit_dynamic_type
@MaterialAutoRouter(
  routes: <AutoRoute>[
    MaterialRoute(page: SplashPage),
    MaterialRoute(page: CounterPage, initial: true),
    // MaterialRoute(page: SplashPage2),
    // MaterialRoute(page: NotesOverviewPage),
    // MaterialRoute(page: NoteFormPage, fullscreenDialog: true),
  ],
)
class $Router {}
