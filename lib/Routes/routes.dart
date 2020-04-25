import'package:flutter/material.dart';
import 'package:sal7ly_firebase/firebase_login/loginpage.dart';
import 'package:sal7ly_firebase/firebase_login/signuppage.dart';
import 'package:sal7ly_firebase/screens/Home_Screen.dart';
import 'package:sal7ly_firebase/screens/add_Service.dart';
import 'package:sal7ly_firebase/screens/add_Service_Location.dart';
import 'package:sal7ly_firebase/screens/map.dart';
import 'package:sal7ly_firebase/screens/serviceDetails.dart';

  Map< String , WidgetBuilder> routes =

  {

      '/Home':(context) => Home_Screen_Main(),
      '/AddService':(context) => Add_Service(),
      '/Signup':(context) => SignupPage(),
      '/Login':(context) => LoginPage(),
      '/ServiceLocation':(context) => AddServiceLocation(),
      '/Map':(context) => MyMap(),
      '/ServiceDetails':(context) => ServiceDetails(),

  };