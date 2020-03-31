import 'package:flutter/material.dart';
import 'package:sal7ly_firebase/Firebase/Firebase.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:sal7ly_firebase/Firebase/BusinessOwnerRegister.dart';
import 'package:sal7ly_firebase/Design/SplashScreen.dart';
import 'package:sal7ly_firebase/Design/demo.dart';
import 'package:sal7ly_firebase/Design/3rabiti.dart';
import 'package:sal7ly_firebase/Firebase/camera.dart';
import 'package:sal7ly_firebase/Firebase/Service_Owner_Data.dart';
import 'package:sal7ly_firebase/Firebase/Firebase.dart';


import 'package:sal7ly_firebase/onBording/first.dart';

void main() => runApp(MAIN());

class MAIN extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Onboarding UI',
      debugShowCheckedModeBanner: false,
      home:  MyApp(),
    );
  }
}



/*
void main() {

  runApp(new MaterialApp(
    home: (MyApp()),
  ) );

}
*/

