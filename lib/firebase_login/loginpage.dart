import 'package:flutter/material.dart';
import 'package:async/async.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:sal7ly_firebase/global/Colors.dart' as myColors;

import 'package:sal7ly_firebase/firebase_login/home.dart';
import 'package:sal7ly_firebase/firebase_login/homepage.dart';
import 'package:sal7ly_firebase/firebase_login/signuppage.dart';
import 'package:sal7ly_firebase/screens/Home_Screen.dart';

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
                  child: RaisedButton(
                    child: Text(
                      'Sign in',
                      style: TextStyle(
                          color: Colors.white, fontSize: 26, letterSpacing: 1),
                    ),
                    color: myColors.red[900],
                    textColor: Colors.white,
                    elevation: 10.0,

                    onPressed: () {
                      signInWithEmailAndPassword();
                    },
                  ),
                ),
                SizedBox(height: 15.0),
                Text('Don\'t have an account?'),
                SizedBox(height: 10.0),
                RaisedButton(
                  child: Text('Sign Up'),
                  color: myColors.red[900],
                  textColor: Colors.white,
                  elevation: 10.0,
                  onPressed: () {
                    Navigator.of(context).pushNamed('/Signup');
                  },
                ),
              ],
            ),
          )),
    ));
  }

  void signInWithEmailAndPassword() {
    FirebaseAuth.instance
        .signInWithEmailAndPassword(email: _email, password: _password)
        .then((AuthResult auth) {
      Navigator.pushNamed(context, '/Home');
    }).catchError((e) {
      print(e);
    });
  }
}
