import 'package:flutter/material.dart';
import 'package:zawadi/presentation/splash/app_styles.dart';

class SmallTextButton extends StatelessWidget {
  const SmallTextButton({
    Key? key,
    required this.buttonText,
    // required this.page
    this.onTap,
  }) : super(key: key);

  final String buttonText;
  // final Widget page;
  final void Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        splashColor: kSecondaryColor.withOpacity(0.2),
        borderRadius: BorderRadius.circular(12),
        child: Padding(
          padding: const EdgeInsets.all(8),
          child: Text(
            buttonText,
            style: kBodyText3.copyWith(
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }
}
