import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';

import 'package:flutter/widgets.dart';
import 'package:sal7ly_firebase/firebase_login/homepage.dart';
import 'package:sal7ly_firebase/screens/Home_Screen.dart';

class UserManagement {

  DocumentReference ref;

  storeNewUser(user, context) async {
    ref = await Firestore.instance.collection('service_owner').document('${user.uid}').setData({
        'email': user.email,
        'uid': user.uid
      }).then((value) {
        Navigator.pushNamed(context, '/Home');
      }).catchError((e) {
        print(e);
      });
    }
}
