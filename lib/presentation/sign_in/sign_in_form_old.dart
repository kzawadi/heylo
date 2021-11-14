// import 'package:auto_route/auto_route.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:zawadi/application/auth/auth_bloc.dart';
// import 'package:zawadi/application/auth/sign_in_form/sign_in_form_bloc.dart';
// import 'package:zawadi/domain/auth/value_objects.dart';
// import 'package:zawadi/presentation/routes/router.gr.dart';

// ///This is a form widget which handle inputs of [EmailAddress] and [Password]
// ///and listerns the [SignInFormBloc] , shows errors in sign/register inputs if any
// ///after a very succesful procedure it navigate to success route.
// class SignInForm extends StatelessWidget {
//   const SignInForm({Key? key}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return BlocConsumer<SignInFormBloc, SignInFormState>(
//       listener: (context, state) {
//         state.authFailureOrSuccessOption.fold(
//           () {},
//           (either) => either.fold(
//             (failure) {
//               final snackBar = SnackBar(
//                 behavior: SnackBarBehavior.floating,
//                 content: Text(
//                   failure.map(
//                     cancelledByUser: (_) => 'You have Cancelled 
//the login in',
//                     serverError: (_) => 'Server error',
//                     emailAlreadyInUse: (_) => 'Email already in use',
//                     invalidEmailAndPasswordCombination: (_) =>
//                         'Invalid email and password combination',
//                   ),
//                 ),
//                 action: SnackBarAction(
//                   label: 'Action',
//                   onPressed: () {},
//                 ),
//               );

//               ScaffoldMessenger.of(context).showSnackBar(snackBar);
//             },
//             (_) {
//               context
//                   .read<AuthBloc>()
//                   .add(const AuthEvent.authCheckRequested());
//               AutoRouter.of(context).replace(const SplashPage2Route());
//             },
//           ),
//         );
//       },
//       builder: (context, state) {
//         return Form(
//           autovalidateMode: state.showErrorMessages
//               ? AutovalidateMode.always
//               : AutovalidateMode.disabled,
//           child: ListView(
//             padding: const EdgeInsets.all(8),
//             children: [
//               const Text(
//                 '📝',
//                 textAlign: TextAlign.center,
//                 style: TextStyle(fontSize: 130),
//               ),
//               const SizedBox(height: 8),
//               TextFormField(
//                 decoration: const InputDecoration(
//                   prefixIcon: Icon(Icons.email),
//                   labelText: 'Email',
//                 ),
//                 autocorrect: false,
//                 onChanged: (value) => context
//                     .read<SignInFormBloc>()
//                     .add(SignInFormEvent.emailChanged(value)),
//                 validator: (_) => context
//                     .read<SignInFormBloc>()
//                     .state
//                     .emailAddress
//                     .value
//                     .fold(
//                       (f) => f.maybeMap(
//                         invalidEmail: (_) => 'Invalid Email',
//                         orElse: () => null,
//                       ),
//                       (_) => null,
//                     ),
//               ),
//               const SizedBox(height: 8),
//               TextFormField(
//                 decoration: const InputDecoration(
//                   prefixIcon: Icon(Icons.lock),
//                   labelText: 'Password',
//                 ),
//                 autocorrect: false,
//                 obscureText: true,
//                 onChanged: (value) => context
//                     .read<SignInFormBloc>()
//                     .add(SignInFormEvent.passwordChanged(value)),
//                 validator: (_) =>
//                     context.read<SignInFormBloc>().state.password.value.fold(
//                           (f) => f.maybeMap(
//                             shortPassword: (_) => 'Short Password',
//                             orElse: () => null,
//                           ),
//                           (_) => null,
//                         ),
//               ),
//               const SizedBox(height: 8),
//               Row(
//                 children: [
//                   Expanded(
//                     child: TextButton(
//                       onPressed: () {
//                         context.read<SignInFormBloc>().add(
//                               const SignInFormEvent
//                                   .signInWithEmailAndPasswordPressed(),
//                             );
//                       },
//                       child: const Text('SIGN IN'),
//                     ),
//                   ),
//                   Expanded(
//                     child: TextButton(
//                       onPressed: () {
//                         context.read<SignInFormBloc>().add(
//                               const SignInFormEvent
//                                   .registerWithEmailAndPasswordPressed(),
//                             );
//                       },
//                       child: const Text('REGISTER'),
//                     ),
//                   ),
//                 ],
//               ),
//               ElevatedButton(
//                 onPressed: () {
//                   context
//                       .read<SignInFormBloc>()
//                       .add(const SignInFormEvent.signInWithGooglePressed());
//                 },
//                 style: ElevatedButton.styleFrom(
//                   primary: Colors.lightBlue, // background
//                   onPrimary: Colors.white, // foreground
//                 ),
//                 child: const Text(
//                   'SIGN IN WITH GOOGLE',
//                   style: TextStyle(
//                     color: Colors.white,
//                     fontWeight: FontWeight.bold,
//                   ),
//                 ),
//               ),
//               if (state.isSubmitting) ...[
//                 const SizedBox(height: 8),
//                 const LinearProgressIndicator(),
//               ]
//             ],
//           ),
//         );
//       },
//     );
//   }
// }
