import 'package:flutter/material.dart';
import 'package:sal7ly_firebase/Design/SplashScreen.dart';
import 'package:sal7ly_firebase/screens/onboarding.dart';
import 'package:sal7ly_firebase/screens/Welcome.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sal7ly_firebase/utilties/app_theme.dart';

import 'Routes/routes.dart';


main() async {

  WidgetsFlutterBinding.ensureInitialized();
  Widget screen;
  SharedPreferences prefs = await SharedPreferences.getInstance();
  bool seen = prefs.getBool('seen');
  if (seen == null || seen == false)
  {

    screen = OnBoarding();

  }
  else
  {

    screen = Splash();

  }

  runApp( NewsApp(screen));

}


class NewsApp extends StatelessWidget
{


  final Widget _screen;


  NewsApp(this._screen);

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return MaterialApp(
      routes: routes,
      debugShowCheckedModeBanner: false,
      theme: AppTheme.appTheme,
      home: this._screen,
    );
  }

}