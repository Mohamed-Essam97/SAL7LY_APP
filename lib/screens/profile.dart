import 'dart:io';
import 'package:path/path.dart' as Path;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:sal7ly_firebase/global/Colors.dart' as myColors;
import 'package:sal7ly_firebase/screens/chat/Widgets/Loading.dart';

class Profile extends StatefulWidget {
  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> with SingleTickerProviderStateMixin {
  String userId;
  String phoneNumber;
  String email;
  String age;

  FirebaseUser _user;
  String _errorMessage;
  bool _hasError = false;
  bool _isLoading = true;
  bool isLoading = true;

  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 2), () {
      setState(() {
        isLoading = false;
      });
    });
    FirebaseAuth.instance.currentUser().then((user) {
      setState(() {
        _user = user;
        _hasError = false;
        _isLoading = false;
      });
    }).catchError((error) {
      setState(() {
        _hasError = true;
        _errorMessage = error.toString();
      });
    });
  }

  Future<String> getUserId() async {
    FirebaseUser user = await FirebaseAuth.instance.currentUser();
    print(user.uid);
    userId = user.uid;
    return user.uid.toString();
  }

  Widget returnName(double fontSize,String fontFamily) {
/*
    FirebaseAuth.instance.currentUser();
    Firestore.instance.collection("service_owner").document(_user.uid).get().then((value){
      print(value.data["name"]);
    });
*/
    return new StreamBuilder(
        stream: Firestore.instance
            .collection('service_owner')
            .document(userId)
            .snapshots(),
        builder: (context, snapshots) {
          if (!snapshots.hasData) {
            return new Text("");
          }
          var userDocument = snapshots.data;
          // ignore: missing_return
          return new Text(
            userDocument["name"].toString(),
            style: TextStyle(fontSize: fontSize, fontFamily: fontFamily),
          );
        });
  }

  Widget returnPhoneNumber(double fontSize,String fontFamily) {
    return new StreamBuilder(
        stream: Firestore.instance
            .collection('service_owner')
            .document(userId)
            .snapshots(),
        builder: (context, snapshots) {
          if (!snapshots.hasData) {
            return new Text("");
          }
          var userDocument = snapshots.data;
          // ignore: missing_return
          return new Text(
            userDocument["phone"].toString(),
            style: TextStyle(fontSize: fontSize,fontFamily: fontFamily ),

          );
        });
  }

  Widget returnEmail(double fontSize,String fontFamily) {
    return new StreamBuilder(
        stream: Firestore.instance
            .collection('service_owner')
            .document(userId)
            .snapshots(),
        builder: (context, snapshots) {
          if (!snapshots.hasData) {
            return new Text("");
          }
          var userDocument = snapshots.data;
          // ignore: missing_return
          return new Text(
            userDocument["email"].toString(),
            style: TextStyle(fontSize: fontSize,fontFamily: fontFamily ),

          );
        });
  }


  Widget returnImage() {
    return new StreamBuilder(
        stream: Firestore.instance
            .collection('service_owner')
            .document(userId)
            .snapshots(),
        builder: (context, snapshots) {
          if (!snapshots.hasData) {
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
          }
          var userDocument = snapshots.data;
          // ignore: missing_return
          return Container(
            width: 110.0,
            height: 110.0,
            decoration: new BoxDecoration(
              shape: BoxShape.circle,
              image: new DecorationImage(
                image: NetworkImage(userDocument["imageurl"].toString()),
                fit: BoxFit.cover,
              ),
            ),
          );
        });
  }


  File imageFile;
  String _uploadedFileURL;

/*
  Future uploadProfileImage() async {
    uploadFile();
    FirebaseUser user = await FirebaseAuth.instance.currentUser();
    print(user.uid);
    if (_uploadedFileURL == null) {
      print("File Don't Uploaded! ");
    } else {
      Firestore.instance
          .collection('service_owner')
          .document(user.uid)
          .updateData({'imageurl': _uploadedFileURL});
    }
  }
*/

  Future uploadFile() async {
    StorageReference storageReference = FirebaseStorage.instance
        .ref()
        .child('users/${Path.basename(imageFile.path)}}');
    StorageUploadTask uploadTask = storageReference.putFile(imageFile);
    await uploadTask.onComplete;
    print('File Uploaded');
    storageReference.getDownloadURL().then((fileURL) {
      setState(() async {
        _uploadedFileURL = fileURL;
        print(_uploadedFileURL);
        FirebaseUser user = await FirebaseAuth.instance.currentUser();
        print(user.uid);
        Firestore.instance
            .collection('service_owner')
            .document(user.uid)
            .updateData({'imageurl': _uploadedFileURL});
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

  bool _status = true;
  final FocusNode myFocusNode = FocusNode();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: content(context),
    );
  }

  Widget content(BuildContext context) {
    getUserId();
    if (isLoading == true) {
      return Loading();
    } else {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            children: <Widget>[
              Padding(
                padding: EdgeInsets.all(30.0),
                child: new Stack(
                  fit: StackFit.loose,
                  children: <Widget>[
                    returnImage(),
                  ],
                ),
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      returnName(20,'Bold'),
                      SizedBox(
                        height: 8,
                      ),
                      returnPhoneNumber(15,''),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 8.0),
                    child: Container(
                      height: 30.0,
                      child: GestureDetector(
                        onTap: () {
                          _showChoiceDialoge(context);
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
                                "Change photo ",
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
                ],
              ),
            ],
          ),
          SizedBox(
            height: 30,
          ),
          Container(
            height: 50.0,
            child: GestureDetector(
              onTap: () {
                Navigator.of(context).pushNamed('/EditName');
              },
              child: Container(
                child: Padding(
                  padding: const EdgeInsets.only(top: 10, left: 40),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            'Name',
                            style: TextStyle(fontFamily: 'Regular'),
                          ),
                          returnName(15, 'Bold'),
                        ],
                      ),
                      IconButton(
                          icon: Icon(Icons.chevron_right),
                          onPressed: () {
                            Navigator.of(context).pushNamed('/EditName');
                          }),
                    ],
                  ),
                ),
              ),
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Container(
            height: 0.2,
            width: double.infinity,
            color: myColors.primaryText,
          ),
          Container(
            height: 50.0,
            child: GestureDetector(
              onTap: () {
                Navigator.pushNamed(context, '/EditPhone');
              },
              child: Container(
                child: Padding(
                  padding: const EdgeInsets.only(top: 10, left: 40),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            'Phone Number',
                            style: TextStyle(fontFamily: 'Regular'),
                          ),
                          returnPhoneNumber(15, 'Bold'),
                        ],
                      ),
                      IconButton(
                          icon: Icon(Icons.chevron_right),
                          onPressed: () {
                            Navigator.pushNamed(context, '/EditPhone');

                          }),
                    ],
                  ),
                ),
              ),
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Container(
            height: 0.2,
            width: double.infinity,
            color: myColors.primaryText,
          ),
          Container(
            height: 50.0,
            child: GestureDetector(
              onTap: () {
              },
              child: Container(
                child: Padding(
                  padding: const EdgeInsets.only(top: 10, left: 40),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            'Email',
                            style: TextStyle(fontFamily: 'Regular'),
                          ),
                          returnEmail(15, 'Bold'),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
          SizedBox(
            height: 80,
          ),
        ],
      );
    }

  }

}
