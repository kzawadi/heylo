import 'package:flutter/material.dart';

class IndieAppBar extends StatelessWidget {
  const IndieAppBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        const Padding(
          padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
          child: Icon(Icons.menu, size: 32),
        ),
        Container(
          color: const Color(0xFF010101),
          padding:
              const EdgeInsets.only(top: 8, bottom: 8, left: 50, right: 16),
          child: const Text(
            'FRESH BEATS BY',
            textAlign: TextAlign.right,
            style: TextStyle(
              // package: OnBoarding.pkg,
              letterSpacing: 2,
              fontFamily: 'Staatliches',
              fontWeight: FontWeight.bold,
              color: Colors.white,
              fontSize: 10.5,
            ),
          ),
        ),
      ],
    );
  }
}
