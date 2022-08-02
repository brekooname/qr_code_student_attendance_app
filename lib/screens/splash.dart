import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:flutter/material.dart';

import 'dashboard.dart';

class Splash extends StatelessWidget {
  const Splash({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AnimatedSplashScreen(
      duration: 4000,
      splash: Row(
        children: const <Widget>[
          SizedBox(
            width: 20.0,
          ),
          Icon(
            Icons.qr_code_scanner_outlined,
            size: 70.0,
            color: Colors.white,
          ),
          Text(
            'Quick Attendance',
            style: TextStyle(
                fontSize: 25.0,
                fontWeight: FontWeight.bold,
                color: Colors.white),
          ),
        ],
      ),
      nextScreen: const Dashboard(),
      splashTransition: SplashTransition.fadeTransition,
      backgroundColor: Colors.blueAccent,
    );
  }
}
