import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SplashPage extends StatelessWidget {
  const SplashPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 200,
      color: Colors.amber,
    );
    // BlocListener<AuthBloc, AuthState>(
    //   listener: (context, state) {
    //     state.map(
    //       initial: (_) {},
    //       authenticated: (_) =>
    //           AutoRouter.of(context).replace(const NotesOverviewPageRoute()),
    //       unauthenticated: (_) =>
    //           AutoRouter.of(context).replace(const SignInPageRoute()),
    //     );
    //   },
    //   child: const Scaffold(
    //     body: Center(
    //       child: CircularProgressIndicator(),
    //     ),
    //   ),
    // );
  }
}
