import 'package:flutter/material.dart';
import 'package:zawadi/presentation/splash/app_styles.dart';

class MyTextFormField extends StatelessWidget {
  const MyTextFormField({
    Key? key,
    required this.hint,
    required this.icon,
    required this.fillColor,
    required this.inputType,
    required this.inputAction,
    required this.focusNode,
    required this.validator,
    this.autocorrect = false,
    this.onChanged,
  }) : super(key: key);

  final String hint;
  final IconData icon;
  final bool autocorrect;
  final Color fillColor;
  final TextInputType inputType;
  final TextInputAction inputAction;
  final FocusNode focusNode;
  final String? Function(String?)? validator;
  final void Function(String)? onChanged;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5),
      child: TextFormField(
        style: focusNode.hasFocus
            ? kBodyText2.copyWith(color: kPrimaryColor)
            : kInputHintStyle,
        cursorColor: kSecondaryColor,
        autocorrect: autocorrect,
        keyboardType: inputType,
        textInputAction: inputAction,
        focusNode: focusNode,
        validator: validator,
        onChanged: onChanged,
        decoration: InputDecoration(
          filled: true,
          fillColor: fillColor,
          border: kInputBorder,
          enabledBorder: kInputBorder,
          hintText: hint,
          hintStyle: kInputHintStyle,
          // contentPadding: EdgeInsets.all(0),
          // since we removed container remove content padding 0 to
          // enable default padding for the field
          prefixIcon: Padding(
            padding: const EdgeInsets.only(right: 16),
            child: Container(
              // height: 60,
              // this container height is causing the error
              decoration: const BoxDecoration(
                border: Border(
                  right: BorderSide(
                    width: 2,
                    color: kScaffoldBackground,
                  ),
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Icon(
                  icon,
                  color: focusNode.hasFocus
                      ? kPrimaryColor
                      : kSecondaryColor.withOpacity(0.5),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
