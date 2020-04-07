import 'package:flutter/material.dart';
import 'package:sal7ly_firebase/screens/Welcome.dart';

//pages
import 'homepage.dart';
import 'loginpage.dart';
import 'signuppage.dart';

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      home: HomeScreen(),
      routes: <String, WidgetBuilder> {
        '/landingpage': (BuildContext context)=> new MyApp(),
        '/signup': (BuildContext context) => new SignupPage(),
        '/homepage': (BuildContext context) => new HomePage()
      },
    );
  }
}