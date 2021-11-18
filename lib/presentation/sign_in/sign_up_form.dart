import 'package:auto_route/auto_route.dart';
import 'package:designsys/designsys.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:zawadi/application/auth/auth_bloc.dart';
import 'package:zawadi/application/auth/sign_up_form/sign_up_form_bloc.dart';
import 'package:zawadi/l10n/l10n.dart';
import 'package:zawadi/presentation/routes/router.gr.dart';
import 'package:zawadi/presentation/sign_in/validators.dart';
import 'package:zawadi/presentation/sign_in/widgets/fields/my_check_box.dart';
import 'package:zawadi/presentation/sign_in/widgets/fields/my_password_field.dart';
import 'package:zawadi/presentation/sign_in/widgets/fields/my_text_form_field.dart';
import 'package:zawadi/presentation/splash/app_styles.dart';
import 'package:zawadi/presentation/splash/widgets/buttons/large_icon_button.dart';
import 'package:zawadi/presentation/splash/widgets/buttons/my_text_button.dart';
import 'package:zawadi/presentation/splash/widgets/buttons/small_text_button.dart';

class SigningUpForm extends StatefulWidget {
  const SigningUpForm({Key? key}) : super(key: key);

  @override
  _SigningUpFormState createState() => _SigningUpFormState();
}

class _SigningUpFormState extends State<SigningUpForm> {
  final _signUpKey = GlobalKey<FormState>();

  // void onSubmit() {
  //   _signUpKey.currentState!.validate();
  // }

  final List<FocusNode> _signUpFocusNodes = [
    FocusNode(),
    FocusNode(),
    FocusNode(),
  ];

  @override
  void initState() {
    super.initState();
    for (final element in _signUpFocusNodes) {
      element.addListener(() {
        setState(() {});
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    SizeConfig().init(context);
    final height = SizeConfig.blockSizeV!;
    return BlocConsumer<SignUpFormBloc, SignUpFormState>(
      listener: (context, state) {
        state.authFailureOrSuccessOption.fold(
          () {},
          (either) => either.fold(
            (failure) {
              final snackBar = SnackBar(
                behavior: SnackBarBehavior.floating,
                content: Text(
                  failure.map(
                    cancelledByUser: (_) => l10n.cancelledByUser,
                    serverError: (_) => l10n.serverError,
                    emailAlreadyInUse: (_) => l10n.emailAlreadyInUse,
                    invalidEmailAndPasswordCombination: (_) =>
                        l10n.invalidEmailAndPasswordCombination,
                  ),
                ),
                action: SnackBarAction(
                  label: 'Ok',
                  onPressed: () {},
                ),
              );

              ScaffoldMessenger.of(context).showSnackBar(snackBar);
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
        return Scaffold(
          backgroundColor: kScaffoldBackground,
          body: SafeArea(
            child: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Column(
                  children: [
                    SizedBox(
                      child: Image.asset(
                        'assets/images/auth/signup_illustration.png',
                      ),
                    ),
                    SizedBox(
                      height: height * 2,
                    ),
                    Text(
                      l10n.createAccont,
                      style: kTitle2,
                    ),
                    SizedBox(
                      height: height * 2,
                    ),
                    Form(
                      autovalidateMode: state.showErrorMessages
                          ? AutovalidateMode.always
                          : AutovalidateMode.disabled,
                      key: _signUpKey,
                      child: Column(
                        children: [
                          MyTextFormField(
                            fillColor: Colors.white,
                            hint: l10n.name,
                            icon: Icons.person,
                            inputAction: TextInputAction.next,
                            inputType: TextInputType.name,
                            focusNode: _signUpFocusNodes[0],
                            validator: nameValidator,
                          ),
                          MyTextFormField(
                            hint: l10n.email,
                            icon: Icons.email_outlined,
                            fillColor: Colors.white,
                            inputType: TextInputType.emailAddress,
                            inputAction: TextInputAction.next,
                            focusNode: _signUpFocusNodes[1],
                            onChanged: (value) => context
                                .read<SignUpFormBloc>()
                                .add(SignUpFormEvent.emailChanged(value)),
                            validator: (_) => context
                                .read<SignUpFormBloc>()
                                .state
                                .emailAddress
                                .value
                                .fold(
                                  (f) => f.maybeMap(
                                    invalidEmail: (_) => l10n.invalidEmail,
                                    orElse: () => null,
                                  ),
                                  (_) => null,
                                ),
                          ),
                          MyPasswordField(
                            fillColor: Colors.white,
                            focusNode: _signUpFocusNodes[2],
                            onChanged: (value) => context
                                .read<SignUpFormBloc>()
                                .add(SignUpFormEvent.passwordChanged(value)),
                            validator: (_) => context
                                .read<SignUpFormBloc>()
                                .state
                                .password
                                .value
                                .fold(
                                  (f) => f.maybeMap(
                                    shortPassword: (_) => l10n.shortPassword,
                                    orElse: () => null,
                                  ),
                                  (_) => null,
                                ),
                          ),
                          MyCheckBox(
                            text: l10n.keepMeIn,
                          ),
                          const MyCheckBox(
                            text: 'Email me about special pricing and more',
                          ),
                          MyTextButton(
                            buttonName: l10n.createAccont,
                            onPressed: () {
                              context.read<SignUpFormBloc>().add(
                                    const SignUpFormEvent
                                        .registerWithEmailAndPasswordPressed(),
                                  );
                            },
                            bgColor: kPrimaryColor,
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      child: Row(
                        children: [
                          Expanded(
                            child: Divider(
                              height: 3,
                              color: kSecondaryColor.withOpacity(0.4),
                            ),
                          ),
                          Text(
                            l10n.orSignInWith,
                            style: kBodyText3,
                          ),
                          Expanded(
                            child: Divider(
                              height: 3,
                              color: kSecondaryColor.withOpacity(0.4),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: LargeIconButton(
                            buttonName: l10n.google,
                            iconImage: 'assets/images/auth/google_icon.png',
                            onPressed: () {
                              context.read<SignUpFormBloc>().add(
                                    const SignUpFormEvent
                                        .signInWithGooglePressed(),
                                  );
                            },
                          ),
                        ),
                        const SizedBox(
                          width: 20,
                        ),
                        Expanded(
                          child: LargeIconButton(
                            buttonName: l10n.facebook,
                            iconImage: 'assets/images/auth/facebook_icon.png',
                            onPressed: () {},
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: height * 3,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          l10n.alreadyHaveAnAccount,
                          style: kBodyText3,
                        ),
                        SmallTextButton(
                          buttonText: l10n.signIn,
                          // page: LoginPage(),
                          onTap: () {
                            AutoRouter.of(context).navigate(
                              const SignInPageRoute(),
                            );
                          },
                        )
                      ],
                    ),
                    SizedBox(
                      height: height * 2,
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
