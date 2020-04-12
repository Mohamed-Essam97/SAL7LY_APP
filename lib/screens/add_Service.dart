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

  final _formKey = GlobalKey<FormState>();

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
        body: Container(
          child: Column(
            children: <Widget>[
              Form(
                key: _formKey,
                child: Column(
                  children: <Widget>[
                    TextFormField(
                        decoration: const InputDecoration(
                          icon: const Icon(Icons.person),
                          hintText: 'Enter your Service name',
                          labelText: 'Service Name',
                        ),
                        onChanged: (value) {
                        setState(() {
                        serviceName = value;
                        });
                    }  // The validator receives the text that the user has entered.
                    ),
                    TextFormField(
                        decoration: const InputDecoration(
                          icon: const Icon(Icons.person),
                          hintText: 'Enter your Service Phone Number',
                          labelText: 'Phone Number',
                        ),
                        onChanged: (value) {
                        setState(() {
                        phoneNumber1 = value;
                        });
                    }  // The validator receives the text that the user has entered.
                    ),
                    TextFormField(
                        decoration: const InputDecoration(
                          icon: const Icon(Icons.person),
                          hintText: 'Enter your Service Phone Number',
                          labelText: 'another Phone Number',
                        ),
                        onChanged: (value) {
                          setState(() {
                            phoneNumber2 = value;
                          });
                        }  // The validator receives the text that the user has entered.
                    ),
                    TextFormField(
                        decoration: const InputDecoration(
                          icon: const Icon(Icons.person),
                          hintText: 'Enter Service Type',
                          labelText: 'Service Type',
                        ),
                        onChanged: (value) {
                          setState(() {
                            serviceType = value;
                          });
                        }  // The validator receives the text that the user has entered.
                    ),
                    TextFormField(
                        decoration: const InputDecoration(
                          icon: const Icon(Icons.person),
                          hintText: 'Enter your Service Specialization',
                          labelText: 'Service Specialization',
                        ),
                        onChanged: (value) {
                          setState(() {
                            specialization = value;
                          });
                        }  // The validator receives the text that the user has entered.
                    ),
                    TextFormField(
                        decoration: const InputDecoration(
                          icon: const Icon(Icons.person),
                          hintText: 'Enter your Service Max Price',
                          labelText: 'Max Price',
                        ),
                        onChanged: (value) {
                          setState(() {
                            maxPrice = value;
                          });
                        }  // The validator receives the text that the user has entered.
                    ),
                    TextFormField(
                        decoration: const InputDecoration(
                          icon: const Icon(Icons.person),
                          hintText: 'Enter your Service Min Price',
                          labelText: 'Min Price',
                        ),
                        onChanged: (value) {
                          setState(() {
                            minPrice = value;
                          });
                        }  // The validator receives the text that the user has entered.
                    ),
                    TextFormField(
                        decoration: const InputDecoration(
                          icon: const Icon(Icons.person),
                          hintText: 'Enter your Service off Days',
                          labelText: 'offDays',
                        ),
                        onChanged: (value) {
                          setState(() {
                            offDay1 = value;
                          });
                        }  // The validator receives the text that the user has entered.
                    ),

                    RaisedButton(
                      child: Text('ADD DATA'),
                      color: Colors.blue,
                      textColor: Colors.white,
                      elevation: 7.0,
                      onPressed: () {
                      addServiceData();
                      },
                    ),
                  ],
                ),
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
