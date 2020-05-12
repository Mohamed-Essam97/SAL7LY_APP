import 'package:flutter/material.dart';
import 'package:async/async.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:sal7ly_firebase/global/Colors.dart' as myColors;

import 'package:sal7ly_firebase/firebase_login/home.dart';
import 'package:sal7ly_firebase/firebase_login/homepage.dart';
import 'package:sal7ly_firebase/firebase_login/signuppage.dart';
import 'package:sal7ly_firebase/screens/Home_Screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final formKey = new GlobalKey<FormState>();

  String _email;
  String _password;

  void validateAndSave() {
    final form = formKey.currentState;
    if (form.validate()) {
      form.save();
    } else {
      print("Formis invalid");
    }
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
        body: Center(
      child: Container(
          padding: EdgeInsets.all(25.0),
          child: Form(
            key: formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Transform.translate(
                  child: Text(
                    "Sign In To SAL7LY",
                    style: TextStyle(
                      fontFamily: 'Bold',
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  offset: Offset(-35, -80),
                ),
                TextFormField(
                    textCapitalization: TextCapitalization.words,
                    autofocus: false,
                    decoration: InputDecoration(
                      prefixIcon: Padding(
                        padding: EdgeInsets.only(left: 5.0),
                        child: Icon(
                          Icons.email,
                          color: Colors.grey,
                        ), // icon is 48px widget.
                      ),
                      hintText: 'Enter your Email',
                      contentPadding:
                      EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15.0)),
                    ),
                    onChanged: (value) {
                      setState(() {
                        _email = value;
                      });
                    }),
                SizedBox(height: 15.0),
                TextFormField(
                  textCapitalization: TextCapitalization.words,
                  autofocus: false,
                  decoration: InputDecoration(
                    prefixIcon: Padding(
                      padding: EdgeInsets.only(left: 5.0),
                      child: Icon(
                        Icons.lock,
                        color: Colors.grey,
                      ), // icon is 48px widget.
                    ),
                    hintText: 'Enter your Service Name',
                    contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15.0)),
                  ),
                  onChanged: (value) {
                    setState(() {
                      _password = value;
                    });
                  },
                  obscureText: true,
                ),
                SizedBox(height: 20.0),
                SizedBox(
                  width: double.infinity,
                  height: 50,
                  child: FlatButton(
                    shape: new RoundedRectangleBorder(
                      borderRadius: new BorderRadius.circular(10.0),
                    ),
                    child: Text(
                      'Sign in',
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
                      signInWithEmailAndPassword();
                    },
                  ),
                ),
                SizedBox(height: 15.0),
                Padding(
                  padding: const EdgeInsets.only(left: 50.0, right: 50),
                  child: Center(
                    child: Row(
                      children: <Widget>[
                        Text('Don\'t have an account? '),
                        InkWell(
                          child: Text(
                            'Sign Up',
                            style: TextStyle(
                                color: myColors.red,
                                fontFamily: "Bold",
                                fontSize: 18),
                          ),
                          onTap: () {
                            Navigator.of(context).pushNamed('/Signup');
                          },
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          )),
    ));
  }

  void signInWithEmailAndPassword() async {
    FirebaseAuth.instance
        .signInWithEmailAndPassword(email: _email, password: _password)
        .then((AuthResult auth) {
      Navigator.of(context).pushNamedAndRemoveUntil(
          '/Home', (Route<dynamic> route) => false);    }).catchError((e) {
      print(e);
    });
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('email', _email);
  }
}
