import 'package:flutter/material.dart';
import 'package:zawadi/presentation/sign_in/forgot_password_page.dart';
import 'package:zawadi/presentation/sign_in/sign_up_page.dart';
import 'package:zawadi/presentation/sign_in/validators.dart';
import 'package:zawadi/presentation/splash/app_styles.dart';
import 'package:zawadi/presentation/splash/widgets/buttons/large_icon_button.dart';
import 'package:zawadi/presentation/splash/widgets/buttons/my_text_button.dart';
import 'package:zawadi/presentation/splash/widgets/buttons/small_text_button.dart';
import 'package:zawadi/presentation/splash/widgets/fields/my_password_field.dart';
import 'package:zawadi/presentation/splash/widgets/fields/my_text_form_field.dart';

// its best practice to do relative imports

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _loginKey = GlobalKey<FormState>();

  void onSubmit() {
    _loginKey.currentState!.validate();
  }

  final List<FocusNode> _loginFocusNodes = [
    FocusNode(),
    FocusNode(),
  ];

  @override
  void initState() {
    super.initState();
    for (final element in _loginFocusNodes) {
      element.addListener(() {
        setState(() {});
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final height = SizeConfig.blockSizeV!;
    return Stack(
      children: [
        Positioned(
          bottom: height * 2,
          child: SizedBox(
            child: Image.asset('assets/images/auth/login_bg.png'),
          ),
        ),
        Scaffold(
          backgroundColor: Colors.transparent,
          body: CustomScrollView(
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
                            padding: const EdgeInsets.symmetric(horizontal: 16),
                            child: Column(
                              children: const [
                                SizedBox(
                                  height: 10,
                                ),
                                LargeIconButton(
                                  buttonName: 'Continue with Google',
                                  iconImage:
                                      'assets/images/auth/google_icon.png',
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                LargeIconButton(
                                  buttonName: 'Continue with Facebook',
                                  iconImage:
                                      'assets/images/auth/facebook_icon.png',
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
                                    child: Form(
                                      key: _loginKey,
                                      child: Column(
                                        children: [
                                          MyTextFormField(
                                            hint: 'Email',
                                            icon: Icons.email_outlined,
                                            fillColor: kScaffoldBackground,
                                            inputType:
                                                TextInputType.emailAddress,
                                            inputAction: TextInputAction.next,
                                            focusNode: _loginFocusNodes[0],
                                            validator: emailValidator,
                                          ),
                                          MyPasswordField(
                                            fillColor: kScaffoldBackground,
                                            focusNode: _loginFocusNodes[1],
                                            validator: passwordValidator,
                                          ),
                                          MyTextButton(
                                            buttonName: 'Login',
                                            onPressed: onSubmit,
                                            bgColor: kPrimaryColor,
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 14,
                                  ),
                                  GestureDetector(
                                    onTap: () {
                                      Navigator.push<void>(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) =>
                                              const ForgotPasswordPage(),
                                        ),
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
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: const [
                                      Text("Don't have an account? "),
                                      SmallTextButton(
                                        buttonText: 'Sign up',
                                        page: SigningUpPage(),
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
        ),
      ],
    );
  }
}
