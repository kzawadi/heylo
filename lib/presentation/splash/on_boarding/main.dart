import 'package:flutter/material.dart';
import 'package:zawadi/presentation/splash/on_boarding/demo.dart';
// import 'package:shared/env.dart';

// import './demo.dart';

// void main() => runApp(App());

class OnBoarding extends StatelessWidget {
  const OnBoarding({Key? key}) : super(key: key);

  // static String _pkg = 'indie_3d';
  // static String get pkg => _pkg; //Env.getPackage(_pkg);
  // static String get bundle => _pkg; //Env.getBundle(_pkg);

  @override
  Widget build(BuildContext context) {
    return const Indie3dHome();
  }
}
