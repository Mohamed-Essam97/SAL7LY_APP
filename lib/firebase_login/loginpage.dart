import 'package:flutter/material.dart';
import 'package:async/async.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_svg/svg.dart';
import 'package:sal7ly_firebase/global/Colors.dart' as myColors;
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:sal7ly_firebase/firebase_login/home.dart';
import 'package:sal7ly_firebase/firebase_login/homepage.dart';
import 'package:sal7ly_firebase/firebase_login/signuppage.dart';
import 'package:sal7ly_firebase/screens/Home_Screen.dart';
import 'package:sal7ly_firebase/screens/LoginPhone.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  TextEditingController _phoneNumber = TextEditingController();

  final formKey = new GlobalKey<FormState>();

  bool _autovalidation = false;
  bool _isLoading = false;
  String _error;
  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  bool isValid = false;

  Future<Null> validate(StateSetter updateState) async {
    print("in validate : ${_phoneNumber.text.length}");
    if (_phoneNumber.text.length == 10) {
      updateState(() {
        isValid = true;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
        body: Container(
      padding: EdgeInsets.all(25.0),
      child: Form(
        key: formKey,
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              SizedBox(
                height: 90,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
              /*    Text(
                    "Welcome to",
                    style: TextStyle(
                      fontFamily: 'Bold',
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    "SAL7LY",
                    style: TextStyle(
                      fontFamily: 'Bold',
                      fontSize: 30,
                      color: myColors.red,
                      fontWeight: FontWeight.bold,
                    ),
                  ),*/
              Center(
                child: SizedBox(
                  width: 400.0,
                  child: TypewriterAnimatedTextKit(
                    onTap: () {
                      print("Tap Event");
                    },
                    text: [
                      "Welcome ",
                      "To",
                      "SAL7LY",
                      "Welcome ",
                      "To",
                      "SAL7LY",
                    ],
                    textStyle: TextStyle(
                        fontSize: 50.0,
                        fontFamily: "Bold",
                      color: myColors.red
                    ),
                  ),
                ),
              ),
                ],
              ),
              Text(
                "Sign In",
                style: TextStyle(
                  fontFamily: 'Bold',
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                ),
              ),  SizedBox(
                height: 10,
              ),

              TextFormField(
                textCapitalization: TextCapitalization.words,
                autofocus: false,
                controller: _emailController,
                validator: (value) {
                  if (value.isEmpty) {
                    return 'Email is required';
                  }
                  return null;
                },
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
              ),
              SizedBox(height: 15.0),
              TextFormField(
                textCapitalization: TextCapitalization.words,
                autofocus: false,
                controller: _passwordController,
                validator: (value) {
                  if (value.isEmpty) {
                    return 'Password is required';
                  }
                  return null;
                },
                decoration: InputDecoration(
                  prefixIcon: Padding(
                    padding: EdgeInsets.only(left: 5.0),
                    child: Icon(
                      Icons.lock,
                      color: Colors.grey,
                    ), // icon is 48px widget.
                  ),
                  hintText: 'Enter your password',
                  contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15.0)),
                ),
                obscureText: true,
              ),
              SizedBox(height: 20.0),
              Row(
                children: <Widget>[
                  Container(
                    color: myColors.secondText,
                    height: 0.5,
                    width: 110,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text('With Phone number'),
                  ),
                  Container(
                    color: myColors.secondText,
                    height: 0.5,
                    width: 110,
                  ),
                ],
              ),
              /* new IconButton(
                    icon: SvgPicture.asset(
                      "assets/facebook.svg",
                      width: 50,
                      height: 50,
                    ),
                    tooltip: 'Closes application',
                    onPressed: () {
                      initiateFacebookLogin();
                    },
                  ),*/
              /*SizedBox(height: 15.0),
                    TextFormField(
                      textCapitalization: TextCapitalization.words,
                      keyboardType: TextInputType.phone,
                      autofocus: false,
                      controller: _phoneNumber,
                      decoration: InputDecoration(
                        prefix: Container(
                          padding: EdgeInsets.all(4.0),
                          child: Text(
                            "+20",
                            style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                        prefixIcon: Padding(
                          padding: EdgeInsets.only(left: 5.0),
                          child: Icon(
                            Icons.phone,
                            color: Colors.grey,
                          ), // icon is 48px widget.
                        ),
                        hintText: 'Enter your Phone Number',
                        contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15.0)),
                      ),
                    ),*/
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
                  onPressed: () async {
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
        ),
      ),
    ));
  }

  void signInWithEmailAndPassword() async {
    if (!formKey.currentState.validate()) {
      setState(() {
        _autovalidation = true;
      });
    } else {
      setState(() {
        _isLoading = true;
        _autovalidation = false;
      });
      FirebaseAuth.instance
          .signInWithEmailAndPassword(
              email: _emailController.text, password: _passwordController.text)
          .then((AuthResult auth) {
        Navigator.of(context)
            .pushNamedAndRemoveUntil('/Home', (Route<dynamic> route) => false);
      }).catchError((e) {
        print(e);
      });
      SharedPreferences prefs = await SharedPreferences.getInstance();
      prefs.setString('email', _emailController.text);
    }
  }
}
