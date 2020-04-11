import 'package:flutter/material.dart';
import 'package:sal7ly_firebase/firebase_login/loginpage.dart';
import 'package:sal7ly_firebase/firebase_login/signuppage.dart';

import 'Home_Screen.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  Color _color = const Color(0xDDBE1D2D);

  Color _colorBlack = const Color(0xFF2E2E2E);


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Transform.translate(
            offset: Offset(0, -50),
            child: SizedBox(
              child: Container(
                  //Logo
              ),
              width:400,
              height: 400,
            ),
          ),
          Transform.translate(
            offset: Offset(0, -100 ),
            child: Text(
              "Welcome to Sal7ly",
              style: TextStyle(
                color: _colorBlack,
                fontSize: 28,
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center,
            ),
          ),
          Transform.translate(
            offset: Offset(0, -100 ),
            child: Padding(
              padding:
              const EdgeInsets.only(left: 48, right: 48, top: 18),
              child: Text(
                "To Encrease your encome and more work",
                style: TextStyle(
                  color: _colorBlack,
                  fontSize: 16,
                ),
                textAlign: TextAlign.center,
              ),
            ),
          ),
          Transform.translate(
            offset: Offset(0, 45 ),
            child: Align(
              alignment: Alignment.bottomCenter,
              child: Padding(
                padding: const EdgeInsets.only(bottom: 24.0, right: 16, left: 16),
                child: SizedBox(
                  width: double.infinity,
                  height: 50,
                  child: RaisedButton(
                    color: _color,
                    child: Text(
                      'Sign in',
                      style: TextStyle(
                          color: Colors.white, fontSize: 26, letterSpacing: 1),
                    ),
                    onPressed: () {

                      Navigator.pushNamed(context, '/Login');

                    },
                  ),
                ),
              ),
            ),
          ),
          Transform.translate(
            offset: Offset(0,40),
              child: InkWell(
                child: Text("Sign up",style: TextStyle(color: _colorBlack,fontSize: 20),),
                onTap: (){

                  Navigator.pushNamed(context, '/Signup');

                },
              )
          ),
        ],
      ) ,
    );
    }
}
