// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

import 'package:cloud_firestore/cloud_firestore.dart' as _i6;
import 'package:firebase_auth/firebase_auth.dart' as _i5;
import 'package:get_it/get_it.dart' as _i1;
import 'package:google_sign_in/google_sign_in.dart' as _i7;
import 'package:injectable/injectable.dart' as _i2;

import 'application/auth/auth_bloc.dart' as _i3;
import 'application/auth/sign_in_form/sign_in_form_bloc.dart' as _i11;
import 'application/auth/sign_up_form/sign_up_form_bloc.dart' as _i15;
import 'domain/auth/i_auth_facade.dart' as _i8;
import 'domain/auth/use_cases/auth_use_cases.dart' as _i4;
import 'domain/auth/use_cases/get_signed_in_user_use_case.dart' as _i16;
import 'domain/auth/use_cases/register_with_e_and_p_use_case.dart' as _i10;
import 'domain/auth/use_cases/sign_in_with_e_and_password_use_case.dart'
    as _i12;
import 'domain/auth/use_cases/sign_in_with_google_use_case.dart' as _i13;
import 'domain/auth/use_cases/sign_out_use_case.dart' as _i14;
import 'infrastructure/auth/firebase_auth_facade.dart' as _i9;
import 'infrastructure/core/firebase_injectable_module.dart' as _i17;

const String _prod = 'prod';
const String _test = 'test';
// ignore_for_file: unnecessary_lambdas
// ignore_for_file: lines_longer_than_80_chars
/// initializes the registration of provided dependencies inside of [GetIt]
_i1.GetIt $initGetIt(_i1.GetIt get,
    {String? environment, _i2.EnvironmentFilter? environmentFilter}) {
  final gh = _i2.GetItHelper(get, environment, environmentFilter);
  final firebaseInjectableModule = _$FirebaseInjectableModule();
  gh.lazySingleton<_i3.AuthBloc>(
      () => _i3.AuthBloc(
          get<_i4.GetSignedInUserUseCase>(), get<_i4.SignOutUseCase>()),
      registerFor: {_prod, _test});
  gh.lazySingleton<_i5.FirebaseAuth>(
      () => firebaseInjectableModule.firebaseAuth);
  gh.lazySingleton<_i6.FirebaseFirestore>(
      () => firebaseInjectableModule.firestore);
  gh.lazySingleton<_i7.GoogleSignIn>(
      () => firebaseInjectableModule.googleSignIn);
  gh.lazySingleton<_i8.IAuthFacade>(
      () => _i9.FirebaseAuthFacade(
          get<_i5.FirebaseAuth>(), get<_i7.GoogleSignIn>()),
      registerFor: {_prod});
  gh.factory<_i10.RegisterWithEmailAndPasswordUseCase>(
      () => _i10.RegisterWithEmailAndPasswordUseCase(get<_i8.IAuthFacade>()));
  gh.factory<_i11.SignInFormBloc>(
      () => _i11.SignInFormBloc(get<_i8.IAuthFacade>()));
  gh.factory<_i12.SignInWithEmailAndPasswordUseCase>(
      () => _i12.SignInWithEmailAndPasswordUseCase(get<_i8.IAuthFacade>()));
  gh.factory<_i13.SignInWithGoogleUseCase>(
      () => _i13.SignInWithGoogleUseCase(get<_i8.IAuthFacade>()));
  gh.factory<_i14.SignOutUseCase>(
      () => _i14.SignOutUseCase(get<_i8.IAuthFacade>()));
  gh.factory<_i15.SignUpFormBloc>(() => _i15.SignUpFormBloc(
      get<_i4.SignInWithGoogleUseCase>(),
      get<_i4.RegisterWithEmailAndPasswordUseCase>(),
      get<_i4.SignInWithEmailAndPasswordUseCase>()));
  gh.factory<_i16.GetSignedInUserUseCase>(
      () => _i16.GetSignedInUserUseCase(get<_i8.IAuthFacade>()));
  return get;
}

class _$FirebaseInjectableModule extends _i17.FirebaseInjectableModule {}
