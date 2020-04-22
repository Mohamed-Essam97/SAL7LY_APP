import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:sal7ly_firebase/firebase_login/loginpage.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:splashscreen/splashscreen.dart';
import 'package:sal7ly_firebase/Design/Start.dart';
import 'package:sal7ly_firebase/onBording/first.dart';


class Splash extends StatefulWidget {
@override
_SplashState createState() => new _SplashState();
}

class _SplashState extends State<Splash> {

  Future<String> submitAll() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var email = prefs.getString('email');
    if (email == null) {
      print(email);
      Navigator.of(context).pushNamed('/Login');
    }
    else if (email != null) {
      Firestore.instance
          .collection('service_owner').where('email', isEqualTo: email).limit(1)
          .snapshots()
          .listen((data) =>
          data.documents.forEach((doc) {
            //print(data.documents.length);
            print(email);
            //bool x =false;
            if (data.documents.length == 1) {
              Navigator.of(context).pushNamed('/Home');
            }
            else {
              Navigator.of(context).pushNamed('/Login');
            }
          }));
    }
  }


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

