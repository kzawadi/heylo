import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:zawadi/application/auth/auth_bloc.dart';
import 'package:zawadi/presentation/routes/router.gr.dart';

class SplashPage extends StatelessWidget {
  const SplashPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return
        //  Container(
        //   height: 200,
        //   color: Colors.amber,
        // );
        BlocListener<AuthBloc, AuthState>(
      listener: (context, state) {
        state.map(
          initial: (_) {},
          authenticated: (_) =>
              AutoRouter.of(context).replace(const SplashPage2Route()),
          unauthenticated: (_) =>
              AutoRouter.of(context).replace(const SignInPageRoute()),
          unAuthenticatingFailure: (UnAuthenticatingFailure value) {},
        );
      },
      child: const Scaffold(
        body: Center(
          child: CircularProgressIndicator(),
        ),
      ),
    );
  }
}
