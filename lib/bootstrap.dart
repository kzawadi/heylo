// Copyright (c) 2021, Very Good Ventures
// https://verygood.ventures
//
// Use of this source code is governed by an MIT-style
// license that can be found in the LICENSE file or at
// https://opensource.org/licenses/MIT.

import 'dart:async';
import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/widgets.dart';
import 'package:injectable/injectable.dart';
import 'package:zawadi/injection.dart';

class AppBlocObserver extends BlocObserver {
  @override
  void onChange(BlocBase bloc, Change change) {
    super.onChange(bloc, change);
    log('onChange(${bloc.runtimeType}, $change)');
  }

  @override
  void onError(BlocBase bloc, Object error, StackTrace stackTrace) {
    log('onError(${bloc.runtimeType}, $error, $stackTrace)');
    super.onError(bloc, error, stackTrace);
  }
}

Future<void> bootstrap(FutureOr<Widget> Function() builder) async {
  await BlocOverrides.runZoned(
    () async {
      // ...
      //   },
      //   blocObserver: AppBlocObserver(),
      //   // eventTransformer: customEventTransformer(),
      // );
      FlutterError.onError = (details) {
        log(details.exceptionAsString(), stackTrace: details.stack);
      };
      WidgetsFlutterBinding.ensureInitialized();
      configureInjection(Environment.prod);
      await Firebase.initializeApp();

      await runZonedGuarded(
        () async => runApp(await builder()),
        (error, stackTrace) => log(error.toString(), stackTrace: stackTrace),
      );
    },
    blocObserver: AppBlocObserver(),
    eventTransformer: sequential<dynamic>(),
  );
}
