import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:injectable/injectable.dart';
import 'package:mockito/annotations.dart';
import 'package:mocktail/mocktail.dart';
import 'package:zawadi/application/auth/auth_bloc.dart';
import 'package:zawadi/domain/auth/i_auth_facade.dart';
import 'package:zawadi/injection.dart';

@Environment(Environment.test)
@injectable
class MockAuthBloc extends MockBloc<AuthEvent, AuthState> implements AuthBloc {}

// class MockAuthBloc extends MockBloc<AuthEvent, AuthState> implements AuthBloc {}
@Environment(Environment.test)
@LazySingleton(as: IAuthFacade)
@GenerateMocks([IAuthFacade])
class MockIAuthRepository extends Mock implements IAuthFacade {}

// class MockIAuthFacade extends Mock implements IAuthFacade {}

void main() {
  // MockIAuthFacade? mockIAuthFacade;
  MockAuthBloc mockAuthBloc;
  // AuthBloc authBloc;
  setUpAll(() async {
    configureInjection(Environment.test);

    // mockIAuthFacade = MockIAuthFacade();
    // authBloc = AuthBloc(mockIAuthFacade!);
    mockAuthBloc = MockAuthBloc();
  });

  // Setup the application services
  authTest();

  group('AuthRequested', () {
    blocTest<MockAuthBloc, AuthState>(
      'emits [AuthState.Initial] when AuthBloc get created for the first time',
      build: () => getIt<MockAuthBloc>(),
      act: (_) {},
      expect: () => const AuthState.initial(),
    );
  });
}
// );
// }

void authTest() {
  // group('whenListen', () {
  //   test("Let's mock the CounterBloc's stream!", () {
  //     // Create Mock CounterBloc Instance
  //     final bloc = MockAuthBloc();

  //     // Stub the listen with a fake Stream
  //     whenListen(bloc, Stream.fromIterable([0, 1, 2, 3]));

  //     // Expect that the CounterBloc instance emitted the stubbed Stream of
  //     // states
  //     expectLater(bloc.stream, emitsInOrder(<int>[0, 1, 2, 3]));
  //   });
  // });

  // group('AuthBloc', () {
  // blocTest<AuthBloc, AuthState>(
  //   'emits [AuthState.initial()] when starting.',
  //   build: () => AuthBloc(mockIAuthFacade),
  //   expect: () => const AuthState.initial(),
  // );

  // blocTest<CounterBloc, int>(
  //   'emits [1] when Increment is added',
  //   build: () => CounterBloc(),
  //   act: (bloc) => bloc.add(Increment()),
  //   expect: () => const <int>[1],
  // );

  // test('Example mocked BLoC test', () {
  //   whenListen<>(
  //     mockAuthBloc,
  //     Stream.fromIterable([WeatherInitial(), WeatherLoading()]),
  //   );

  //   expectLater(
  //     mockAuthBloc,
  //     emitsInOrder([WeatherInitial(), WeatherLoading()]),
  //   );
  // });
  // });
}

// void main() {
//   MockAuthBloc mockAuthBloc;
//   MockIAuthFacade mockIAuthFacade;

//   setUp(() {
//     mockAuthBloc = MockAuthBloc();
//     mockIAuthFacade = MockIAuthFacade();
//   });

//   test('Example mocked BLoC test', () {
//     whenListen<AuthState>(
//       mockAuthBloc,
//       Stream.fromIterable(
//         [const AuthState.initial(), const AuthState.authenticated()],
//       ),
//     );

//     expectLater(
//       mockAuthBloc,
//       emitsInOrder([WeatherInitial(), WeatherLoading()]),
//     );
//   });
// }
