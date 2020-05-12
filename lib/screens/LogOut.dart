import 'package:flutter/material.dart';
import 'package:sal7ly_firebase/global/Colors.dart' as myColors;
import 'package:shared_preferences/shared_preferences.dart';

class LogOut extends StatefulWidget {
  @override
  _LogOutState createState() => _LogOutState();
}

class _LogOutState extends State<LogOut> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Container(
        child: Column(
          children: <Widget>[
            SizedBox(
              width: double.infinity,
              height: 50,
              child: FlatButton(
                shape: new RoundedRectangleBorder(
                  borderRadius: new BorderRadius.circular(10.0),
                ),
                child: Text(
                  'Sign Up',
                  style: TextStyle(
                    fontFamily: 'SemiBold',
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.w600,
                    letterSpacing: 1,
                  ),
                ),
                color: myColors.red[900],
                textColor: Colors.white,
                onPressed: () {
                  LogOut();
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  LogOut() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.clear();
    Navigator.of(context).pushNamedAndRemoveUntil(
        '/Login', (Route<dynamic> route) => false);
  }
}
