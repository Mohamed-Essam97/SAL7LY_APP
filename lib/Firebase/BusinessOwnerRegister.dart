import 'package:flutter/material.dart';
import 'package:firebase_storage/firebase_storage.dart'; // For File Upload To Firestore
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart' as Path;
import 'dart:io';

import 'package:sal7ly_firebase/Firebase/camera.dart';

class Business_owner_Register extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return new _Business_owner_Register();
  }
}

class _Business_owner_Register extends State<Business_owner_Register> {


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
      return Image.file(imageFile, width: 4000, height: 100);
    }
  }

  TextEditingController _email;
  TextEditingController _password;
  TextEditingController _Name;
  TextEditingController _PhoneNumber;

  Color _color = const Color(0xFF1D3575);


/*

  void _showToast(BuildContext context) {
    final scaffold = Scaffold.of(context);
    scaffold.showSnackBar(
      SnackBar(
        content: const Text('Added to favorite'),
        action: SnackBarAction(
            label: 'UNDO', onPressed: scaffold.hideCurrentSnackBar),
      ),
    );
  }

*/


  void Business_owner_data() {

    uploadFile();
    if(_uploadedFileURL==null) {
      _email.text="File Don't Uploaded! ";
    }
    else {
      Firestore.instance.collection('service_owner').document().setData({
        'email': _email.text,
        'password': _password.text,
        'name': _Name.text,
        //'national_id': _NationalID.text,
        'phone': _PhoneNumber.text,
        'imageurl': _uploadedFileURL
      });
    }
  }

  void initState() {
    super.initState();
    _email = new TextEditingController();
    _password = new TextEditingController();
    _Name = new TextEditingController();
    _PhoneNumber = new TextEditingController();
  //  _NationalID = new TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: new AppBar(
        title: new Text("Business owner Register"),
        backgroundColor: _color,
      ),
      body: new Container(
        padding: EdgeInsets.all(15.0),
        child: new Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            new TextFormField(
              controller: _email,
              validator: (String inValue) {
                if (inValue.length == 0) {
                  return "Please enter username";
                }
                return null;
              },
              decoration: new InputDecoration(

                  border: OutlineInputBorder(),
                  icon: Icon(
                    Icons.email,
                    color: _color,
                  ),
                  hintText: "name@email.com",
                  labelText: "Email"),
              keyboardType: TextInputType.emailAddress,
            ),
            new TextFormField(
              controller: _password,
              validator: (String inValue) {
                if (inValue.length < 10) {
                  return "Password must be >=10 in length";
                }
                return null;
              },
              obscureText: true,
              decoration: new InputDecoration(
                  border: OutlineInputBorder(),
                  icon: Icon(
                    Icons.border_color,
                    color: _color,
                  ),
                  hintText: "Your Password",
                  labelText: "Password"),
             // keyboardType: TextInputType.visiblePassword,
            ),
            new TextField(
              controller: _Name,
              decoration: new InputDecoration(
                  border: OutlineInputBorder(),
                  icon: Icon(
                    Icons.person,
                    color: _color,
                  ),
                  hintText: "Name",
                  labelText: "Your Name"),
              keyboardType: TextInputType.text,
            ),
            new TextField(
              controller: _PhoneNumber,
              decoration: new InputDecoration(
                  border: OutlineInputBorder(),
                  icon: Icon(
                    Icons.phone,
                    color: _color,
                  ),
                  hintText: "Number",
                  labelText: "Phone Number"),
              keyboardType: TextInputType.number,
            ),
            new RaisedButton(
              onPressed: () {
                _showChoiceDialoge(context);
              },
              color: _color,
              child: new Text(
                "National ID Image",
                style: TextStyle(fontSize: 25.0),
              ),
              textColor: Colors.white,
            ),
            _decideImageView(),
            new RaisedButton(
              onPressed: Business_owner_data,
              color: _color,
              child: new Text(
                "Register",
                style: TextStyle(fontSize: 25.0),
              ),
              textColor: Colors.white,
            )
          ],
        ),
      ),
    );
  }
}
