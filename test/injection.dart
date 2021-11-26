// test/test_injection.dart
import 'package:bloc_test/bloc_test.dart';
import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';
import 'package:zawadi/application/auth/auth_bloc.dart';

import 'injection.config.dart';

final GetIt getItTestInjection = GetIt.I;
@InjectableInit(generateForDir: [Environment.test])
Future<void> configureTestInjection() async => $initGetIt(getItTestInjection);

@Environment(Environment.test)
@test
@LazySingleton(as: AuthBloc)
class MockAuthBloc extends MockBloc<AuthEvent, AuthState> implements AuthBloc {}
