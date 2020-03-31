import 'package:flutter/material.dart';
import 'package:firebase_storage/firebase_storage.dart'; // For File Upload To Firestore
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart' as Path;
import 'dart:io';






class ServiceOwnerData extends StatefulWidget {
  @override
  _ServiceOwnerDataState createState() => _ServiceOwnerDataState();
}

class LoginData {
  String username = "";
  String password = "";
  String Name = "";
  String PhoneNumber = "";
  String Imageurl = "";
}

class _ServiceOwnerDataState extends State<ServiceOwnerData> {
  LoginData _loginData = new LoginData();

  GlobalKey<FormState> _formKey = new GlobalKey<FormState>();

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
      return Padding(
        padding: const EdgeInsets.only(top:10.0),
        child: Text("أدخل صورة البطاقه"),
      );
    } else {
      return Image.file(imageFile, width: 4000, height: 100);
    }
  }

  void Business_owner_data() {
    uploadFile();
    if (_uploadedFileURL == null) {
      _loginData.username = "File Don't Uploaded! ";
    } else {
      Firestore.instance.collection('service_owner').document().setData({
        'email': _loginData.username,
        'password': _loginData.password,
        'name': _loginData.Name,
        //'national_id': _NationalID.text,
        'phone': _loginData.PhoneNumber,
        'imageurl': _uploadedFileURL
      });
    }
  }

  Color _color = const Color(0xFF1D3575);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: new AppBar(
          title: new Text("Business owner Register"),
          backgroundColor: _color,
        ),
        body: Container(
            padding: EdgeInsets.all(50.0),
            child: Form(
                key: this._formKey,
                child: Column(children: [
                  TextFormField(
                      keyboardType: TextInputType.emailAddress,
                      validator: (String inValue) {
                        if (inValue.length == 0) {
                          return "Please enter username";
                        }
                        return null;
                      },
                      onSaved: (String inValue) {
                        this._loginData.username = inValue;
                      },
                      decoration: InputDecoration(
                          hintText: "none@none.com",
                          labelText: "Username (Email address)")),
                  TextFormField(
                      obscureText: true,
                      validator: (String inValue) {
                        if (inValue.length < 10) {
                          return "Password must be >=10 in length";
                        }
                        return null;
                      },
                      onSaved: (String inValue) {
                        this._loginData.password = inValue;
                      },
                      decoration: InputDecoration(
                          hintText: "Password", labelText: "Password")),
                  TextFormField(
                      keyboardType: TextInputType.text,
                      obscureText: true,
                      onSaved: (String inValue) {
                        this._loginData.Name = inValue;
                      },
                      decoration: InputDecoration(
                          hintText: "Your Name", labelText: "Your Name")),
                  TextFormField(
                      keyboardType: TextInputType.phone,
                      obscureText: true,
                      onSaved: (String inValue) {
                        this._loginData.PhoneNumber = inValue;
                      },
                      decoration: InputDecoration(
                          hintText: "Your Phone", labelText: "Phone Number")),
                  _decideImageView(),
                  Container(
                    padding: EdgeInsets.only(left:3.0),
                    child: FlatButton(
                        child: IconButton(
                          icon: Icon(Icons.add_a_photo),
                          onPressed: () {
                            _showChoiceDialoge(context);
                          },
                          color: _color,
                        ),
                        onPressed: () {
                          _showChoiceDialoge(context);
                        }),
                  ),
                  ButtonTheme(
                      minWidth: 400.0,
                      height: 40.0,
                      child: RaisedButton(
                          shape: new RoundedRectangleBorder(
                              borderRadius: new BorderRadius.circular(15.0)),
                          child: Text("Log In"),

                          color: _color,
                          textColor: Colors.white,
                          onPressed: () {
                            if (_formKey.currentState.validate()) {
                              _formKey.currentState.save();
                              Business_owner_data();
                            }
                          })),
                ]))));
  }
}
