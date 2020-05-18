import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:sal7ly_firebase/firebase_login/home.dart';

//services
import 'package:sal7ly_firebase/firebase_login/services/usermanagment.dart';
import 'package:sal7ly_firebase/firebase_login/homepage.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sal7ly_firebase/global/Colors.dart' as myColors;

class SignupPage extends StatefulWidget {
  @override
  _SignupPageState createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  String _email;
  String _password;

  UserManagement userManagement = new UserManagement();

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
        body: Center(
      child: Container(
          padding: EdgeInsets.all(25.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Transform.translate(
                child: Text(
                  "Sign Up To SAL7LY",
                  style: TextStyle(
                    fontFamily: 'Bold',
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                offset: Offset(-35, -80),
              ),
              Text(
                "",
                style: TextStyle(
                  color: myColors.red,
                  fontSize: 10,
                ),
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
                    contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15.0)),
                  ),
                  onChanged: (value) {
                    setState(() {
                      _email = value;
                    });
                  }),
              SizedBox(height: 15.0),
              TextField(
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
                  hintText: 'Enter your Password',
                  contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15.0)),
                ),
                obscureText: true,
                onChanged: (value) {
                  setState(() {
                    _password = value;
                  });
                },
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
                    signUp();
                  },
                ),
              ),
              SizedBox(height: 15.0),
              Padding(
                padding: const EdgeInsets.only(left: 50.0, right: 50),
                child: Center(
                  child: Row(
                    children: <Widget>[
                      Text('I already have an account. '),
                      InkWell(
                        child: Text(
                          'Sign In',
                          style: TextStyle(
                              color: myColors.red,
                              fontFamily: "Bold",
                              fontSize: 18),
                        ),
                        onTap: () {
                          Navigator.of(context).pushNamedAndRemoveUntil(
                              '/login', (Route<dynamic> route) => false);
                        },
                      ),
                    ],
                  ),
                ),
              ),
            ],
          )),
    ));
  }

  signUp() async {
    FirebaseAuth.instance
        .createUserWithEmailAndPassword(email: _email, password: _password)
        .then((signedInUser) async {
      userManagement.storeNewUser(signedInUser.user, context);
      FirebaseUser user = await FirebaseAuth.instance.currentUser();
      print(user.uid);
      Firestore.instance
          .collection('service_owner')
          .document("${user.uid}")
          .setData({
        'email': _email,
        'password': _password,
        'uid':user.uid,
      });
      Navigator.of(context).pushNamedAndRemoveUntil(
          '/Home', (Route<dynamic> route) => false);
    }).catchError((e) {
      print(e);
    });
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('email', _email);
  }
}
