import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
//import 'package:sal7ly_firebase/firebase_login/home.dart';

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


  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  TextEditingController _phoneNumber = TextEditingController();
  TextEditingController _nameController = TextEditingController();

  final formKey = new GlobalKey<FormState>();

  bool _autovalidation = false;
  bool _isLoading = false;
  String _error ;
  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  String _email;
  String _password;

  UserManagement userManagement = new UserManagement();

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
        body: Center(
      child: Container(
          padding: EdgeInsets.all(25.0),
          child: Form(
            key: formKey,
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.only(right: 80,bottom: 30),
                    child: Text(
                      "Sign Up To SAL7LY",
                      style: TextStyle(
                        fontFamily: 'Bold',
                        fontSize: 30,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  TextFormField(
                    textCapitalization: TextCapitalization.words,
                    autofocus: false,
                    controller: _nameController,
                    validator: (value) {
                      if (value.isEmpty) {
                        return 'Name is required';
                      }
                      return null;
                    },
                    decoration: InputDecoration(
                      prefixIcon: Padding(
                        padding: EdgeInsets.only(left: 5.0),
                        child: Icon(
                          Icons.assignment_ind,
                          color: Colors.grey,
                        ), // icon is 48px widget.
                      ),
                      hintText: 'Enter your Name',
                      contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15.0)),
                    ),
                  ),
                  SizedBox(height: 15.0),
                  TextFormField(
                    textCapitalization: TextCapitalization.words,
                    keyboardType: TextInputType.phone,
                    autofocus: false,
                    controller: _phoneNumber,
                    validator: (value) {
                      if (value.isEmpty) {
                        return 'Phone is required';
                      }
                      return null;
                    },
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
                  ),
                  SizedBox(height: 15.0),
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
                      hintText: 'Enter your Password',
                      contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15.0)),
                    ),
                    obscureText: true,
                  ),
                  SizedBox(height: 30.0),
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
                              Navigator.of(context).pop();
                            },
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          )),
    ));
  }

   signUp() async {

    if ( ! formKey.currentState.validate()) {
      setState(() {
        _autovalidation = true;
      });
    } else {
      setState(() {
        _isLoading = true;
        _autovalidation = false;
      });

    FirebaseAuth.instance
        .createUserWithEmailAndPassword(email: _emailController.text, password: _passwordController.text)
        .then((signedInUser) async {
      FirebaseUser user = await FirebaseAuth.instance.currentUser();
      print(user.uid);
      Firestore.instance
          .collection('service_owner')
          .document("${user.uid}")
          .setData({
        'email': _emailController.text,
        'password': _passwordController.text,
        'name': _nameController.text,
        'phone': _phoneNumber.text,
        'uid': user.uid,
      });
      Navigator.of(context).pushNamedAndRemoveUntil(
          '/Home', (Route<dynamic> route) => false);
    }).catchError((e) {
      print(e);
    });
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('email', _emailController.text);
  }
}}
