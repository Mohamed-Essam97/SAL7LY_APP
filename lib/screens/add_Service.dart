import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:sal7ly_firebase/global/Colors.dart' as myColors;
import 'package:pattern_formatter/pattern_formatter.dart';


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

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Add Service"),
        backgroundColor: Colors.grey.shade50,
      ),
      body: Container(
        color: Colors.grey.shade50,
        child: Column(
          children: <Widget>[
            firstForm(),
          ],
        ),
      )
    );
  }


  Widget firstForm()
  {
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
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(32.0)),
                ),
                onChanged: (value) {
                  setState(() {
                    serviceName = value;
                  });
                }
            ),
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
                    phoneNumber1 = value;
                  });
                }
            ),
          ],
        ),
      ),
    );
  }



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
