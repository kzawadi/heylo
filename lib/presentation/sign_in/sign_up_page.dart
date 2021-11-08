import 'package:designsys/designsys.dart';
import 'package:flutter/material.dart';
import 'package:zawadi/presentation/sign_in/login_page.dart';
import 'package:zawadi/presentation/sign_in/validators.dart';
import 'package:zawadi/presentation/splash/app_styles.dart';
import 'package:zawadi/presentation/splash/widgets/buttons/large_icon_button.dart';
import 'package:zawadi/presentation/splash/widgets/buttons/my_text_button.dart';
import 'package:zawadi/presentation/splash/widgets/buttons/small_text_button.dart';
import 'package:zawadi/presentation/splash/widgets/fields/my_check_box.dart';
import 'package:zawadi/presentation/splash/widgets/fields/my_password_field.dart';
import 'package:zawadi/presentation/splash/widgets/fields/my_text_form_field.dart';

class SigningUpPage extends StatefulWidget {
  const SigningUpPage({Key? key}) : super(key: key);

  @override
  _SignUpPageState createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SigningUpPage> {
  final _signUpKey = GlobalKey<FormState>();

  void onSubmit() {
    _signUpKey.currentState!.validate();
  }

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
    SizeConfig().init(context);
    final height = SizeConfig.blockSizeV!;
    return ZawadiScaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Column(
              children: [
                SizedBox(
                  child:
                      Image.asset('assets/images/auth/signup_illustration.png'),
                ),
                SizedBox(
                  height: height * 2,
                ),
                Text(
                  'Create Your Account',
                  style: kTitle2,
                ),
                SizedBox(
                  height: height * 2,
                ),
                Form(
                  key: _signUpKey,
                  child: Column(
                    children: [
                      MyTextFormField(
                        fillColor: Colors.white,
                        hint: 'Name',
                        icon: Icons.person,
                        inputAction: TextInputAction.next,
                        inputType: TextInputType.name,
                        focusNode: _signUpFocusNodes[0],
                        validator: nameValidator,
                      ),
                      MyTextFormField(
                        hint: 'Email',
                        icon: Icons.email_outlined,
                        fillColor: Colors.white,
                        inputType: TextInputType.emailAddress,
                        inputAction: TextInputAction.next,
                        focusNode: _signUpFocusNodes[1],
                        validator: emailValidator,
                      ),
                      MyPasswordField(
                        fillColor: Colors.white,
                        focusNode: _signUpFocusNodes[2],
                        validator: passwordValidator,
                      ),
                      const MyCheckBox(
                        text: 'Keep me signed in',
                      ),
                      const MyCheckBox(
                        text: 'Email me about special pricing and more',
                      ),
                      MyTextButton(
                        buttonName: 'Create Account',
                        onPressed: onSubmit,
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
                        'Or sign in with',
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
                  children: const [
                    Expanded(
                      child: LargeIconButton(
                        buttonName: 'Google',
                        iconImage: 'assets/images/auth/google_icon.png',
                      ),
                    ),
                    SizedBox(
                      width: 20,
                    ),
                    Expanded(
                      child: LargeIconButton(
                        buttonName: 'Facebook',
                        iconImage: 'assets/images/auth/facebook_icon.png',
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
                      'Already have an account? ',
                      style: kBodyText3,
                    ),
                    const SmallTextButton(
                      buttonText: 'Sign in',
                      page: LoginPage(),
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
  }
}
