import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:zawadi/application/auth/sign_up_form/sign_up_form_bloc.dart';
import 'package:zawadi/injection.dart';
import 'package:zawadi/presentation/sign_in/sign_up_form.dart';
// import 'package:zawadi/presentation/sign_in/widgets/sign_in_form.dart';

class SignUpPage extends StatelessWidget {
  const SignUpPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocProvider(
        create: (context) => getIt<SignUpFormBloc>(),
        child: const SigningUpForm(),
      ),
    );
  }
}
