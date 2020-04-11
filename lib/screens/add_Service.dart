import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:sal7ly_firebase/screens/chat/global/Colors.dart' as myColors;

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
  String image;
  String serviceName;
  String phoneNumber1, phoneNumber2;
  String serviceType, specialization;
  String location;
  String maxPrice, minPrice;
  String offDay1, offDay2;
  String startTime, endTime;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(
            "Add Your Service",
            style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
          ),
          backgroundColor: myColors.red[900],
          centerTitle: true,
        ),
        body: ListView(
          children: <Widget>[

          ],
        ));
  }

  /*TextField(
  decoration: InputDecoration(hintText: 'Add Service Image'),
  onChanged: (value) {
  setState(() {
  image = value;
  });
  }),
  TextField(
  decoration: InputDecoration(hintText: 'Service Name'),
  onChanged: (value) {
  setState(() {
  serviceName = value;
  });
  }),
  Row(
  children: <Widget>[
  TextField(
  decoration: InputDecoration(hintText: 'Phone Number'),
  onChanged: (value) {
  setState(() {
  phoneNumber1 = value;
  });
  }),
  TextField(
  decoration:
  InputDecoration(hintText: 'Another Phone Number'),
  onChanged: (value) {
  setState(() {
  phoneNumber2 = value;
  });
  }),
  ],
  ),
  Row(
  children: <Widget>[
  TextField(
  decoration: InputDecoration(hintText: 'Specialization'),
  onChanged: (value) {
  setState(() {
  specialization = value;
  });
  }),
  TextField(
  decoration: InputDecoration(hintText: 'Service Type'),
  onChanged: (value) {
  setState(() {
  serviceType = value;
  });
  }),
  ],
  ),
  Row(
  children: <Widget>[
  TextField(
  decoration: InputDecoration(hintText: 'Max Price'),
  onChanged: (value) {
  setState(() {
  maxPrice = value;
  });
  }),
  TextField(
  decoration: InputDecoration(hintText: 'Minimum Price '),
  onChanged: (value) {
  setState(() {
  minPrice = value;
  });
  }),
  ],
  ),
  Row(
  children: <Widget>[
  TextField(
  decoration: InputDecoration(hintText: 'Day off 1'),
  onChanged: (value) {
  setState(() {
  offDay1 = value;
  });
  }),
  TextField(
  decoration: InputDecoration(hintText: 'Day off 2'),
  onChanged: (value) {
  setState(() {
  offDay2 = value;
  });
  }),
  ],
  ),
  Row(
  children: <Widget>[
  TextField(
  decoration: InputDecoration(hintText: 'Start Time'),
  onChanged: (value) {
  setState(() {
  startTime = value;
  });
  }),
  TextField(
  decoration: InputDecoration(hintText: 'End Time'),
  onChanged: (value) {
  setState(() {
  endTime = value;
  });
  }),
  ],
  ),*/


  /*
  void getData() {
    databaseReference
        .collection("books")
        .getDocuments()
        .then((QuerySnapshot snapshot) {
      snapshot.documents.forEach((f) => print('${f.data}}'));
    });
  }*/

  addServiceOwnerData() async {
    FirebaseUser user = await FirebaseAuth.instance.currentUser();
    final databaseReference = Firestore.instance;
    await databaseReference
        .collection("service_owner")
        .document("${user.uid}")
        .updateData({
      'Name': serviceName,
      'Phone': phoneNumber1,
    });
  }

  addServiceData() async {
    FirebaseUser user = await FirebaseAuth.instance.currentUser();
    final databaseReference = Firestore.instance;
    await databaseReference
        .collection("service")
        .document("${user.uid}")
        .setData({
      'image': image,
      'Name': serviceName,
      'location': location,
      'phone1': phoneNumber1,
      'phone2': phoneNumber2,
      'service type': serviceType,
      'specialization': specialization,
      'max price': maxPrice,
      'max price': minPrice,
      'off day1': offDay1,
      'off day2': offDay2,
      'start time': endTime,
      'end time': startTime,
    });
  }
}
