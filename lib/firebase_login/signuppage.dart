import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
//import 'package:sal7ly_firebase/firebase_login/home.dart';
import 'package:path/path.dart' as Path;
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


  File imageFile;
  String _uploadedFileURL;

  File imageIdFile;
  String _uploadedImageIdFileURL;


  Future uploadFile() async {
    StorageReference storageReference = FirebaseStorage.instance
        .ref()
        .child('service_owner/${Path.basename(imageFile.path)}}');
    StorageUploadTask uploadTask = storageReference.putFile(imageFile);
    await uploadTask.onComplete;
    print('File Uploaded');
    storageReference.getDownloadURL().then((fileURL) {
      setState(() async {
        _uploadedFileURL = fileURL;
        print(_uploadedFileURL);
      });
    });
  }

  _openGallary(BuildContext context) async {
    var picture = await ImagePicker.pickImage(source: ImageSource.gallery);
    this.setState(() {
      imageFile = picture;
    });
    Navigator.of(context).pop();
    _showImageDialoge(context);
  }

  _openCamera(BuildContext context) async {
    var picture = await ImagePicker.pickImage(source: ImageSource.camera);
    this.setState(() {
      imageFile = picture;
    });
    Navigator.of(context).pop();
    _showImageDialoge(context);
  }

  Future<void> _showChoiceDialoge(BuildContext context) {
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text("Make a Choice! "),
            content: SingleChildScrollView(
              child: ListBody(
                children: <Widget>[
                  GestureDetector(
                    child: Text("Gallary"),
                    onTap: () {
                      _openGallary(context);
                    },
                  ),
                  Padding(padding: EdgeInsets.all(5.0)),
                  GestureDetector(
                    child: Text("Camera"),
                    onTap: () {
                      _openCamera(context);
                    },
                  )
                ],
              ),
            ),
          );
        });
  }

  Future<void> _showImageDialoge(BuildContext context) {
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text("Image"),
            content: SingleChildScrollView(
              child: ListBody(
                children: <Widget>[
                  Column(
                    children: <Widget>[
                      Image.file(imageFile, width: 400, height: 400),
                      SizedBox(
                        height: 20,
                      ),
                      GestureDetector(
                        child: Text(
                          "Save",
                          style: TextStyle(fontSize: 20, color: myColors.green),
                        ),
                        onTap: () {
                          uploadFile();
                          Navigator.of(context).pop();
                        },
                      ),
                    ],
                  ),
                  Padding(padding: EdgeInsets.all(5.0)),
                ],
              ),
            ),
          );
        });
  }


  Future uploadImageIdFile() async {
    StorageReference storageReference = FirebaseStorage.instance
        .ref()
        .child('service_owner/${Path.basename(imageIdFile.path)}}');
    StorageUploadTask uploadTask = storageReference.putFile(imageIdFile);
    await uploadTask.onComplete;
    print('File Uploaded');
    storageReference.getDownloadURL().then((fileURL) {
      setState(() async {
        _uploadedImageIdFileURL = fileURL;
        print(_uploadedImageIdFileURL);
      });
    });
  }

  _openGallaryy(BuildContext context) async {
    var picture = await ImagePicker.pickImage(source: ImageSource.gallery);
    this.setState(() {
      imageIdFile = picture;
    });
    Navigator.of(context).pop();
    _showImageDialoge(context);
  }

  _openCameraa(BuildContext context) async {
    var picture = await ImagePicker.pickImage(source: ImageSource.camera);
    this.setState(() {
      imageIdFile = picture;
    });
    Navigator.of(context).pop();
    _showImageDialogee(context);
  }

  Future<void> _showChoiceDialogee(BuildContext context) {
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text("Make a Choice! "),
            content: SingleChildScrollView(
              child: ListBody(
                children: <Widget>[
                  GestureDetector(
                    child: Text("Gallary"),
                    onTap: () {
                      _openGallaryy(context);
                    },
                  ),
                  Padding(padding: EdgeInsets.all(5.0)),
                  GestureDetector(
                    child: Text("Camera"),
                    onTap: () {
                      _openCameraa(context);
                    },
                  )
                ],
              ),
            ),
          );
        });
  }

  Future<void> _showImageDialogee(BuildContext context) {
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text("Image"),
            content: SingleChildScrollView(
              child: ListBody(
                children: <Widget>[
                  Column(
                    children: <Widget>[
                      Image.file(imageIdFile, width: 400, height: 400),
                      SizedBox(
                        height: 20,
                      ),
                      GestureDetector(
                        child: Text(
                          "Save",
                          style: TextStyle(fontSize: 20, color: myColors.green),
                        ),
                        onTap: () {
                          uploadImageIdFile();
                          Navigator.of(context).pop();
                        },
                      ),
                    ],
                  ),
                  Padding(padding: EdgeInsets.all(5.0)),
                ],
              ),
            ),
          );
        });
  }


  Widget returnImage() {
    return Stack(
      children: <Widget>[
        Imag(),
        Transform.translate(
          offset: Offset(75, 75),
          child: CircleAvatar(
            backgroundColor: Colors.grey.shade300,
            radius: 20.0,
            child: IconButton(
                icon: Icon(
                  Icons.add,
                  color: myColors.green,
                ),
                onPressed: () {
                  _showChoiceDialoge(context);
                },
                iconSize: 25.0),
          ),
        ),
      ],
    );
  }

Widget Imag()
{
  if(imageFile == null){
    return Container(
      width: 110.0,
      height: 110.0,
      decoration: new BoxDecoration(
        shape: BoxShape.circle,
        image: new DecorationImage(
          image: AssetImage('assets/first.png'),
          fit: BoxFit.cover,
        ),
      ),
    );
  }else
    {
    return Container(
        width: 110.0,
        height: 110.0,
        decoration: new BoxDecoration(
          shape: BoxShape.circle,
          image: new DecorationImage(
              image: FileImage(imageFile),
            fit: BoxFit.cover,
          ),
        ),
      );
    }

}


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
  FirebaseMessaging xnm = new FirebaseMessaging();
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
                  Center(
                    child: Text(
                      "Register",
                      style: TextStyle(
                        fontFamily: 'Bold',
                        fontSize: 30,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  returnImage(),
                  SizedBox(
                    height: 20,
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
                  Padding(
                    padding: const EdgeInsets.only(top: 8.0),
                    child: Container(
                      height: 40.0,
                      child: GestureDetector(
                        onTap: () {
                          _showChoiceDialogee(context);
                        },
                        child: Container(
                          decoration: BoxDecoration(
                            border: Border.all(
                              color: myColors.red,
                              style: BorderStyle.solid,
                              width: 1.0,
                            ),
                            color: Colors.transparent,
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Padding(
                                padding: const EdgeInsets.all(2.0),
                                child: Icon(
                                  Icons.camera_enhance,
                                  color: myColors.red,
                                  size: 20.0,
                                ),
                              ),
                              Text(
                                "Add your National Id Image ",
                                style: TextStyle(
                                  color: myColors.red,
                                  fontFamily: 'SemiBold',
                                  fontSize: 12,
                                  fontWeight: FontWeight.w600,
                                  letterSpacing: 1,
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
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

  bool check=false;
   signUp() async {

    if ( ! formKey.currentState.validate() && imageIdFile==null) {
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
        'imageurl': _uploadedFileURL,
        'national_id':_uploadedImageIdFileURL,
      });
      Navigator.of(context).pushNamedAndRemoveUntil(
          '/Home', (Route<dynamic> route) => false);
    }).catchError((e) {
      print(e);
    });
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('email', _emailController.text);
      xnm.getToken().then((value) => {
        Firestore.instance
            .collection('tokens')
            .add({
          'token': value,
        }).then((value) => {})
      });
  }
}}
