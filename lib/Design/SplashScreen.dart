import 'package:flutter/material.dart';
import 'package:splashscreen/splashscreen.dart';
import 'package:sal7ly_firebase/Design/Start.dart';
import 'package:sal7ly_firebase/onBording/first.dart';


class MyApp extends StatefulWidget {
@override
_MyAppState createState() => new _MyAppState();
}

class _MyAppState extends State<MyApp> {


  @override
  Widget build(BuildContext context) {
    return new SplashScreen(
      seconds: 4,
      navigateAfterSeconds: new OnboardingScreen(),
      imageBackground: AssetImage("assets/Splash.png"),
      loaderColor: Colors.indigo,
    );
  }
}

