import'package:flutter/material.dart';
import 'package:sal7ly_firebase/firebase_login/loginpage.dart';
import 'package:sal7ly_firebase/firebase_login/signuppage.dart';
import 'package:sal7ly_firebase/screens/Home_Screen.dart';
import 'package:sal7ly_firebase/screens/add_Service.dart';

  Map< String , WidgetBuilder> routes =

  {

      '/Home':(context) => Home_Screen_Main(),
      '/AddService':(context) => Add_Service(),
      '/Signup':(context) => SignupPage(),
      '/Login':(context) => LoginPage(),

  };