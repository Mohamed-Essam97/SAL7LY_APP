import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:sal7ly_firebase/firebase_login/loginpage.dart';
import 'package:sal7ly_firebase/screens/Home_Screen.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:splashscreen/splashscreen.dart';
import 'dart:async';
import 'package:sal7ly_firebase/global/Colors.dart' as myColors;

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
      Navigator.of(context).pushNamedAndRemoveUntil(
          '/Login', (Route<dynamic> route) => false);
    } else if (email != null) {
      Firestore.instance
          .collection('service_owner')
          .where('email', isEqualTo: email)
          .limit(1)
          .snapshots()
          .listen((data) => data.documents.forEach((doc) {
                //print(data.documents.length);
                print(email);
                //bool x =false;
                if (data.documents.length == 1) {
                  Navigator.of(context).pushNamedAndRemoveUntil(
                      '/Home', (Route<dynamic> route) => false);
                  print(data.documents.length);
                } else if(doc["email"] != email ){
                  Navigator.of(context).pushNamedAndRemoveUntil(
                      '/Login', (Route<dynamic> route) => false);
                }
              }));
    }
  }

  void initState() {
    super.initState();

    Future.delayed(Duration(seconds: 4), () {
      submitAll();
    });
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      body: Container(
        color: myColors.red,
        child: Center(
          child: CircularProgressIndicator(
            valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
          ),
        ),
      ),
    );
  }
}
