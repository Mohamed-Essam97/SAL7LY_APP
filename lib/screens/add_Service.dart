import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart'; // For File Upload To Firestore
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart' as Path;
import 'package:sal7ly_firebase/global/Colors.dart' as myColors;
import 'package:pattern_formatter/pattern_formatter.dart';
import 'dart:io';

class Add_Service extends StatefulWidget {
  @override
  _Add_ServiceState createState() => _Add_ServiceState();
}

void createRecord() async {
  final databaseReference = Firestore.instance;
  await databaseReference.collection("books").document("1").setData({
    'title': 'Mastering Flutter',
    'description': 'Programming Guide for Dart'
  });

  DocumentReference ref = await databaseReference.collection("books").add({
    'title': 'Flutter in Action',
    'description': 'Complete Programming Guide to learn Flutter'
  });
  print(ref.documentID);
}

class _Add_ServiceState extends State<Add_Service> {
  File imageFile;
  String _uploadedFileURL;

  Future uploadFile() async {
    StorageReference storageReference = FirebaseStorage.instance
        .ref()
        .child('users/${Path.basename(imageFile.path)}}');
    StorageUploadTask uploadTask = storageReference.putFile(imageFile);

    await uploadTask.onComplete;
    print('File Uploaded');
    storageReference.getDownloadURL().then((fileURL) {
      setState(() {
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
  }

  _openCamera(BuildContext context) async {
    var picture = await ImagePicker.pickImage(source: ImageSource.camera);
    this.setState(() {
      imageFile = picture;
    });
    Navigator.of(context).pop();
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

  Widget _decideImageView() {
    if (imageFile == null) {
      return Text("No Image Selected ! ");
    } else {
      return Image.file(
        imageFile,
        width: 200,
        height: 100,
      );
    }
  }

  String image;
  String serviceName;
  List<String> phones = [];
  String serviceType, specialization;
  String location;
  String offDay1, offDay2;
  String startTime, endTime;

  final formKey = new GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: ListView(
          children: <Widget>[
            Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.only(top: 25),
                      child: Text(
                        "Add Service",
                        style: TextStyle(
                          fontSize: 30,
                          fontWeight: FontWeight.bold,
                          fontFamily: 'Bold',
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    addTextField(),
                    SizedBox(
                      height: 10,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.only(left: 1.0),
                          child: SizedBox(width: 300, child: addTextField()),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(right: 90.0),
                      child: SizedBox(width: 300, child: addTextField()),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        children: <Widget>[
                          Text(
                            "Add service image",
                            style: TextStyle(
                              fontSize: 15,
                              fontFamily: 'Light',
                            ),
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          IconButton(
                            icon: Icon(Icons.add),
                            color: Colors.green,
                            iconSize: 40,
                            onPressed: () {
                              _showChoiceDialoge(context);
                            },
                          ),
                          _decideImageView(),
                        ],
                      ),
                    ),
                    Row(
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: RaisedButton(
                            child: Text(
                              'Service Type',
                              style: TextStyle(
                                  color: Colors.white, fontSize: 26, letterSpacing: 1),
                            ),
                            color: myColors.red[900],
                            textColor: Colors.white,
                            elevation: 10.0,
                            onPressed: () {
                            },
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: RaisedButton(
                            child: Text(
                              'Service Type',
                              style: TextStyle(
                                  color: Colors.white, fontSize: 26, letterSpacing: 1),
                            ),
                            color: myColors.red[900],
                            textColor: Colors.white,
                            elevation: 10.0,
                            onPressed: () {
                            },
                          ),
                        ),
                      ],
                    ),
                  ],
                )),
          ],
        ),
      ),
    );
  }

  /*Widget firstForm() {
    return Padding(
      padding: const EdgeInsets.only(top: 20.0),
      child: Container(
        child: Column(
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
                  hintText: 'Enter your Service Name',
                  contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(32.0)),
                ),
                onChanged: (value) {
                  setState(() {
                    serviceName = value;
                  });
                }),
            SizedBox(
              height: 10,
            ),
            TextField(
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  icon: const Icon(Icons.person),
                  hintText: 'Enter your Service Number',
                  labelText: 'Service Number',
                ),
                onChanged: (value) {
                  setState(() {
                    String phone1 = value;
                    phones.add(phone1);
                  });
                }),
          ],
        ),
      ),
    );
  }
*/
  /*
  void getData() {
    databaseReference
        .collection("books")
        .getDocuments()
        .then((QuerySnapshot snapshot) {
      snapshot.documents.forEach((f) => print('${f.data}}'));
    });
  }*/

  /*addServiceOwnerData() async {
    FirebaseUser user = await FirebaseAuth.instance.currentUser();
    final databaseReference = Firestore.instance;
    await databaseReference
        .collection("service_owner")
        .document("${user.uid}")
        .updateData({
      'Name': serviceName,
      'Phone': phoneNumber1,
    });
  }*/

  Widget addTextField() {
    return TextFormField(
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
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(15.0)),
        ),
        onChanged: (value) {
          setState(() {
            //   _email = value;
          });
        });
  }

  addServiceData() async {
    FirebaseUser user = await FirebaseAuth.instance.currentUser();
    final databaseReference = Firestore.instance;
    await databaseReference
        .collection("service")
        .document("${user.uid}")
        .setData({
      'imageurl': _uploadedFileURL,
      'Name': serviceName,
      'location': location,
      // 'phone1': phoneNumber1,
      // 'phone2': phoneNumber2,
      'service type': serviceType,
      'specialization': specialization,
      //'max price': maxPrice,
      //'max price': minPrice,
      'off day1': offDay1,
      'off day2': offDay2, 'start time': endTime,
      'end time': startTime,
    });
  }
}
