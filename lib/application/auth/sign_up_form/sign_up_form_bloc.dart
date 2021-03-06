import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter/foundation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:zawadi/domain/auth/auth_failure.dart';
import 'package:zawadi/domain/auth/use_cases/auth_use_cases.dart';
import 'package:zawadi/domain/auth/value_objects.dart';
import 'package:zawadi/domain/core/i_auth_use_cases.dart';

part 'sign_up_form_bloc.freezed.dart';
part 'sign_up_form_event.dart';
part 'sign_up_form_state.dart';

///This bloc handles all the signing procedures and initiate calls to domain
///and handles all errors functionaly
///it handles form validations and errors
@injectable
class SignUpFormBloc extends Bloc<SignUpFormEvent, SignUpFormState> {
  SignUpFormBloc(
    this._signInWithGoogleUseCase,
    this._registerWithEmailAndPasswordUseCase,
    this._signInWithEmailAndPasswordUseCase,
  ) : super(SignUpFormState.initial()) {
    on<SignUpFormEvent>(_signInFormHandler);
  }

  final SignInWithGoogleUseCase _signInWithGoogleUseCase;
  final RegisterWithEmailAndPasswordUseCase
      _registerWithEmailAndPasswordUseCase;

  final SignInWithEmailAndPasswordUseCase _signInWithEmailAndPasswordUseCase;

  ///The Bloc logic heper/handler function
  Future _signInFormHandler(
    SignUpFormEvent event,
    Emitter emit,
  ) async {
    await event.map(
      emailChanged: (e) async {
        emit(
          state.copyWith(
            emailAddress: EmailAddress(e.emailStr),
            authFailureOrSuccessOption: none(),
          ),
        );
      },
      passwordChanged: (e) async {
        emit(
          state.copyWith(
            password: Password(e.passwordStr),
            authFailureOrSuccessOption: none(),
          ),
        );
      },
      registerWithEmailAndPasswordPressed: (e) async {
        await _performActionOnAuthFacadeWithEmailAndPassword(
          _registerWithEmailAndPasswordUseCase.call,
          emit,
        );
      },
      signInWithEmailAndPasswordPressed: (e) async {
        await _performActionOnAuthFacadeWithEmailAndPassword(
          _signInWithEmailAndPasswordUseCase.call,
          emit,
        );
      },
      signInWithGooglePressed: (e) async {
        emit(
          state.copyWith(
            isSubmitting: true,
            authFailureOrSuccessOption: none(),
          ),
        );

        final failureOrSuccess =
            await _signInWithGoogleUseCase.call(NoParams());
        emit(
          state.copyWith(
            isSubmitting: false,
            authFailureOrSuccessOption: some(failureOrSuccess),
          ),
        );
      },
    );
  }

  ///This function take [EmailAddress] and [Password] and make a network call
  ///to either register or login an account
  Future _performActionOnAuthFacadeWithEmailAndPassword(
    Future<Either<AuthFailure, Unit>> Function({
      required EmailAddress emailAddress,
      required Password password,
    })
        forwardedCall,
    Emitter emit,
  ) async {
    Either<AuthFailure, Unit>? failureOrSuccess;

    final isEmailValid = state.emailAddress.isValid();
    final isPasswordValid = state.password.isValid();

    if (isEmailValid && isPasswordValid) {
      emit(
        state.copyWith(
          isSubmitting: true,
          authFailureOrSuccessOption: none(),
        ),
      );
      failureOrSuccess = await forwardedCall(
        emailAddress: state.emailAddress,
        password: state.password,
      );
    }
    emit(
      state.copyWith(
        isSubmitting: false,
        showErrorMessages: true,
        authFailureOrSuccessOption: optionOf(failureOrSuccess),
      ),
    );
  }
}
