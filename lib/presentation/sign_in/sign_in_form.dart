import 'package:auto_route/auto_route.dart';
import 'package:designsys/designsys.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:zawadi/application/auth/auth_bloc.dart';
import 'package:zawadi/application/auth/sign_in_form/sign_in_form_bloc.dart';
import 'package:zawadi/presentation/routes/router.gr.dart';
import 'package:zawadi/presentation/sign_in/widgets/fields/my_password_field.dart';
import 'package:zawadi/presentation/sign_in/widgets/fields/my_text_form_field.dart';
import 'package:zawadi/presentation/splash/app_styles.dart';
import 'package:zawadi/presentation/splash/widgets/buttons/large_icon_button.dart';
import 'package:zawadi/presentation/splash/widgets/buttons/my_text_button.dart';
import 'package:zawadi/presentation/splash/widgets/buttons/small_text_button.dart';

// its best practice to do relative imports

class SignInForm extends StatefulWidget {
  const SignInForm({Key? key}) : super(key: key);

  @override
  _SignInFormState createState() => _SignInFormState();
}

class _SignInFormState extends State<SignInForm> {
  final _loginKey = GlobalKey<FormState>();

  // void onSubmit() {
  //   _loginKey.currentState!.validate();
  // }

  final List<FocusNode> _singInFocusNodes = [
    FocusNode(),
    FocusNode(),
  ];

  @override
  void initState() {
    super.initState();
    for (final element in _singInFocusNodes) {
      element.addListener(() {
        setState(() {});
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final height = SizeConfig.blockSizeV!;
    return BlocConsumer<SignInFormBloc, SignInFormState>(
      listener: (context, state) {
        state.authFailureOrSuccessOption.fold(
          () {},
          (either) => either.fold(
            (failure) {
              final snackBar = SnackBar(
                backgroundColor: Colors.red,
                behavior: SnackBarBehavior.floating,
                content: Text(
                  failure.map(
                    cancelledByUser: (_) => 'You have Cancelled the login in',
                    serverError: (_) => 'Server error',
                    emailAlreadyInUse: (_) => 'Email already in use',
                    invalidEmailAndPasswordCombination: (_) =>
                        'Invalid email and password combination',
                  ),
                ),
                action: SnackBarAction(
                  label: 'Ok',
                  onPressed: () {},
                ),
              );

              ScaffoldMessenger.of(context)
                ..hideCurrentSnackBar()
                ..showSnackBar(snackBar);
            },
            (_) {
              context
                  .read<AuthBloc>()
                  .add(const AuthEvent.authCheckRequested());
              AutoRouter.of(context).replace(const SplashPage2Route());
            },
          ),
        );
      },
      builder: (context, state) {
        return
            // backgroundColor: kScaffoldBackground,
            Stack(
          children: [
            Positioned(
              bottom: height * 2,
              child: SizedBox(
                child: Image.asset('assets/images/auth/login_bg.png'),
              ),
            ),
            CustomScrollView(
              physics: const BouncingScrollPhysics(),
              // shrinkWrap: true,
              slivers: [
                SliverFillRemaining(
                  hasScrollBody: false,
                  child: Column(
                    children: [
                      Expanded(
                        flex: 2,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Text(
                              'Welcome to\nMonumental Habits',
                              style: kTitle,
                              textAlign: TextAlign.center,
                            ),
                            const SizedBox(
                              height: 16,
                            ),
                          ],
                        ),
                      ),
                      Expanded(
                        flex: 3,
                        child: Column(
                          children: [
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 16),
                              child: Column(
                                children: [
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  LargeIconButton(
                                    buttonName: 'Continue with Google',
                                    iconImage:
                                        'assets/images/auth/google_icon.png',
                                    onPressed: () {
                                      context.read<SignInFormBloc>().add(
                                            const SignInFormEvent
                                                .signInWithGooglePressed(),
                                          );
                                    },
                                  ),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  LargeIconButton(
                                    buttonName: 'Continue with Facebook',
                                    iconImage:
                                        'assets/images/auth/facebook_icon.png',
                                    onPressed: () {},
                                  )
                                ],
                              ),
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            Expanded(
                              child: Container(
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(24),
                                ),
                                child: Column(
                                  children: [
                                    const SizedBox(
                                      height: 14,
                                    ),
                                    Text(
                                      'Login with email',
                                      style: kBodyText3,
                                    ),
                                    Divider(
                                      height: 30,
                                      color: kPrimaryColor.withOpacity(0.5),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.symmetric(
                                        horizontal: 16,
                                      ),
                                      child: SignInFormWidget(
                                        loginKey: _loginKey,
                                        singInFocusNodes: _singInFocusNodes,
                                        state: state,
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 14,
                                    ),
                                    GestureDetector(
                                      onTap: () {
                                        AutoRouter.of(context).navigate(
                                          const ForgotPasswordPageRoute(),
                                        );
                                      },
                                      child: Text(
                                        'Forgot Password?',
                                        style: kBodyText3.copyWith(
                                          decoration: TextDecoration.underline,
                                        ),
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        const Text("Don't have an account? "),
                                        SmallTextButton(
                                          buttonText: 'Sign up',
                                          onTap: () {
                                            AutoRouter.of(context).navigate(
                                              const SignUpPageRoute(),
                                            );
                                          },
                                          // page: SigningUpPage(),
                                        )
                                      ],
                                    )
                                  ],
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ],
        );
      },
    );
  }
}

class SignInFormWidget extends StatelessWidget {
  const SignInFormWidget({
    Key? key,
    required GlobalKey<FormState> loginKey,
    required List<FocusNode> singInFocusNodes,
    required SignInFormState state,
  })  : _loginKey = loginKey,
        _singInFocusNodes = singInFocusNodes,
        _state = state,
        super(key: key);

  final GlobalKey<FormState> _loginKey;
  final List<FocusNode> _singInFocusNodes;
  final SignInFormState _state;

  @override
  Widget build(BuildContext context) {
    return Form(
      autovalidateMode: _state.showErrorMessages
          ? AutovalidateMode.always
          : AutovalidateMode.disabled,
      key: _loginKey,
      child: Column(
        children: [
          MyTextFormField(
            hint: 'Email',
            icon: Icons.email_outlined,
            fillColor: Colors.white,
            inputType: TextInputType.emailAddress,
            inputAction: TextInputAction.next,
            focusNode: _singInFocusNodes[0],
            onChanged: (value) => context
                .read<SignInFormBloc>()
                .add(SignInFormEvent.emailChanged(value)),
            validator: (_) =>
                context.read<SignInFormBloc>().state.emailAddress.value.fold(
                      (f) => f.maybeMap(
                        invalidEmail: (_) => 'Invalid Email',
                        orElse: () => null,
                      ),
                      (_) => null,
                    ),
          ),
          MyPasswordField(
            fillColor: Colors.white,
            focusNode: _singInFocusNodes[1],
            onChanged: (value) => context.read<SignInFormBloc>().add(
                  SignInFormEvent.passwordChanged(
                    value,
                  ),
                ),
            validator: (_) =>
                context.read<SignInFormBloc>().state.password.value.fold(
                      (f) => f.maybeMap(
                        shortPassword: (_) => 'Short Password',
                        orElse: () => null,
                      ),
                      (_) => null,
                    ),
          ),
          MyTextButton(
            buttonName: 'Login',
            onPressed: () {
              context.read<SignInFormBloc>().add(
                    const SignInFormEvent.signInWithEmailAndPasswordPressed(),
                  );
            },
            bgColor: kPrimaryColor,
          ),
        ],
      ),
    );
  }
}
