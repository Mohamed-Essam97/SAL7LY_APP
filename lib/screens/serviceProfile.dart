import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:path/path.dart' as Path;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:sal7ly_firebase/global/Colors.dart' as myColors;
import 'package:sal7ly_firebase/screens/chat/Widgets/Loading.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

class ServiceProfile extends StatefulWidget {
  String serviceID;
  String serviceName;

  ServiceProfile({this.serviceID, this.serviceName});

  @override
  _ServiceProfileState createState() => _ServiceProfileState(serviceID, serviceName);
}

class _ServiceProfileState extends State<ServiceProfile> {
  String serviceID;
  String serviceName;
  _ServiceProfileState(this.serviceID, this.serviceName);

  File imageFile;
  String _uploadedFileURL;
  bool _isActive = true;

  TextEditingController _descriptionController = TextEditingController();

  final formKey = new GlobalKey<FormState>();


  Future uploadServiceImage() async {
    if(!_uploadedFileURL.isEmpty)
    {
      print(serviceID);
      Firestore.instance
          .collection('service')
          .document(serviceID)
          .updateData({'image': _uploadedFileURL});

    }else
      {
        print('Error');
      }

  }

  Future uploadFile() async {
    StorageReference storageReference = FirebaseStorage.instance
        .ref()
        .child('service/${Path.basename(imageFile.path)}}');
    StorageUploadTask uploadTask = storageReference.putFile(imageFile);
    await uploadTask.onComplete;
    print('File Uploaded');
    storageReference.getDownloadURL().then((fileURL) {
        _uploadedFileURL = fileURL;
        print(_uploadedFileURL);
    });
  }


  _openGallary(BuildContext context) async {
    var picture = await ImagePicker.pickImage(source: ImageSource.gallery);
    this.setState(() {
      imageFile = picture;
    });
    uploadFile();
    Navigator.of(context).pop();
    _showImageDialoge(context);
  }

  _openCamera(BuildContext context) async {
    var picture = await ImagePicker.pickImage(source: ImageSource.camera);
    this.setState(() {
      imageFile = picture;
    });
    uploadFile();
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
                          uploadServiceImage();
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


  void addDescription() {
    if (!formKey.currentState.validate()) {
      print('Error');
    } else {
      Firestore.instance.collection('service')
          .document(serviceID)
          .updateData({
        'description': _descriptionController.text,
      });
      _descriptionController.clear();
      Navigator.of(context).pop();
    }
  }

  Future<void> _showDescriptionDialoge(BuildContext context) {
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text("Enter The Service Description"),
            content: SingleChildScrollView(
              child: ListBody(
                children: <Widget>[
                  Column(
                    children: <Widget>[
                      Form(
                        key: formKey,
                        child: new TextFormField(
                          controller: _descriptionController,
                          validator: (value) {
                            if (value.isEmpty) {
                              return 'Please Write description';
                            }
                            return null;
                          },
                          decoration: const InputDecoration(hintText: "Description"),
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          GestureDetector(
                            child: Text(
                              "Save",
                              style: TextStyle(fontSize: 20, color: myColors.green),
                            ),
                            onTap: () {
                              addDescription();
                            },
                          ),
                          GestureDetector(
                            child: Text(
                              "Cancel",
                              style: TextStyle(fontSize: 20, color: myColors.red),
                            ),
                            onTap: () {
                              _descriptionController.clear();
                              Navigator.of(context).pop();
                            },
                          ),
                        ],
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



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(serviceName),
      ),
      body: drawScreen(),
    );
  }

  Widget returnImage() {
    return new StreamBuilder(
        stream: Firestore.instance
            .collection('service')
            .document(serviceID)
            .snapshots(),
        builder: (context, snapshots) {
          if (!snapshots.hasData && _uploadedFileURL == null) {
            return SizedBox(
              width: double.infinity,
              height: MediaQuery.of(context).size.height * 0.25,
              child: Image(
                image: AssetImage('assets/first.png'),
                fit: BoxFit.cover,
              ),
            );
          }
          var userDocument = snapshots.data;
          // ignore: missing_return
          return SizedBox(
            width: double.infinity,
            height: MediaQuery.of(context).size.height * 0.25,
            child: Image(
              image: NetworkImage(userDocument["image"].toString()),
              fit: BoxFit.cover,
            ),
          );
        });
  }

  GoogleMapController mapController;
  List<Position> kk = [];
  Position gg;
  String searchAddr;

  void onMapCreated(controller) {
    setState(() {
      mapController = controller;
    });
  }


  Widget returnReviews() {
    return new StreamBuilder(
      stream: Firestore.instance
          .collection('service')
          .where("service_id", isEqualTo: serviceID)
          .snapshots(),
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (!snapshot.hasData) {
          return Loading();
        }
        return new ListView(
          children: snapshot.data.documents.map((document) {
            return Row(
              children: <Widget>[
              Container(
              width: 50.0,
              height: 50.0,
              decoration: new BoxDecoration(
                shape: BoxShape.circle,
                image: new DecorationImage(
                  image: NetworkImage(document["comments"]['comment']['pic'][1].toString()),
                  fit: BoxFit.cover,
                ),
              ),
            ),
              ],
            );
          }).toList(),
        );
      },
    );
  }

  Widget drawScreen() {
    return new StreamBuilder(
        stream: Firestore.instance
            .collection('service')
            .document(serviceID)
            .snapshots(),
        builder: (context, snapshots) {
          if (!snapshots.hasData) {
            return Loading();
          }
          var userDocument = snapshots.data;
          _isActive = userDocument['active'];
          return Container(
            child: SingleChildScrollView(
              child: Column(
                children: <Widget>[
                  Stack(
                    children: <Widget>[
                      returnImage(),
                      Transform.translate(
                        offset: Offset(-180, 140),
                        child: new Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            new CircleAvatar(
                              backgroundColor: myColors.primaryText,
                              radius: 20.0,
                              child: IconButton(
                                  icon: Icon(
                                    Icons.camera_alt,
                                    color: Colors.white,
                                  ),
                                  onPressed: () {
                                    _showChoiceDialoge(context);
                                  },
                                  iconSize: 25.0),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 2.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Row(
                                children: <Widget>[
                                  Container(
                                    width: 10.0,
                                    height: 10.0,
                                    decoration: new BoxDecoration(
                                      color:
                                          _isActive ? Colors.green : Colors.red,
                                      shape: BoxShape.circle,
                                    ),
                                  ),
                                  SizedBox(width: 3),
                                  Text(_isActive ? 'Active' : 'Not Active'),
                                ],
                              ),
                            ),
                            RatingBarIndicator(
                              rating: userDocument["rating"],
                              unratedColor: Colors.grey.shade300,
                              itemBuilder: (context, index) => Icon(
                                Icons.star,
                                color: myColors.green,
                              ),
                              itemCount: 5,
                              itemSize: 30.0,
                              direction: Axis.horizontal,
                            ),
                          ],
                        ),
                        Padding(
                          padding: const EdgeInsets.all(6.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: <Widget>[
                              Text(
                                userDocument["name"].toString(),
                                style:
                                    TextStyle(fontSize: 30, fontFamily: 'Bold'),
                              ),
                              Text(
                                userDocument["phone"][0].toString(),
                                style:
                                    TextStyle(fontSize: 15, color: Colors.grey),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  Column(
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          children: <Widget>[
                            Text(
                              'Off Days:',
                              style: TextStyle(
                                  fontSize: 15,
                                  color: Colors.black,
                                  fontFamily: 'Bold'),
                            ),
                            SizedBox(
                              width: 3,
                            ),
/*
                            Row(
                              children: <Widget>[
                                Text(userDocument['off_days'][0].toString() + ' , '),
                                Text(userDocument['off_days'][1].toString()),
                              ],
                            ),
*/
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          children: <Widget>[
                            Text(
                              'Time:',
                              style: TextStyle(
                                  fontSize: 15,
                                  color: Colors.black,
                                  fontFamily: 'Bold'),
                            ),
                            SizedBox(
                              width: 3,
                            ),
                         /*   Row(
                              children: <Widget>[
                                Text(userDocument['time']['start_time'].toString() + ' to '),
                                Text(userDocument['time']['end_time'].toString()),
                              ],
                            ),*/
                          ],
                        ),
                      ),
                    ],
                  ),
                  Container(
                    height: 0.1,
                    width: double.infinity,
                    color: Colors.black,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(right: 300, top: 8),
                    child: Text(
                      'Description:',
                      style: TextStyle(color: Colors.black, fontSize: 15),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      userDocument['description'].toString(),
                      style: TextStyle(color: Colors.grey),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 320),
                    child: IconButton(
                        icon: Icon(
                          Icons.edit,
                          color: Colors.grey,
                        ),
                        onPressed: () {
                          _showDescriptionDialoge(context);
                        }),
                  ),
                  Container(
                    height: 0.2,
                    width: double.infinity,
                    color: Colors.black,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Center(
                      child: Text('Reviews',style: TextStyle(fontSize: 15,fontFamily: 'Bold'),),
                    ),
                  ),
                ],
              ),
            ),
          );
        });
  }



}
