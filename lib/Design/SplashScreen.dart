import 'package:flutter/material.dart';
import 'package:sal7ly_firebase/firebase_login/loginpage.dart';
import 'package:splashscreen/splashscreen.dart';
import 'package:sal7ly_firebase/Design/Start.dart';
import 'package:sal7ly_firebase/onBording/first.dart';


class Splash extends StatefulWidget {
@override
_SplashState createState() => new _SplashState();
}

class _SplashState extends State<Splash> {


  @override
  Widget build(BuildContext context) {
    return new SplashScreen(
      seconds: 4,
      navigateAfterSeconds: new LoginPage(),
      imageBackground: AssetImage("assets/Splash.png"),
      loaderColor: Colors.indigo,
    );
  }



}

