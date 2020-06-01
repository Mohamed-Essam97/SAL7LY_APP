import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:sal7ly_firebase/global/Colors.dart' as myColors;

class EditName extends StatefulWidget {
  @override
  _EditNameState createState() => _EditNameState();
}

class _EditNameState extends State<EditName> {

  TextEditingController _nameController = TextEditingController();

  final formKey = new GlobalKey<FormState>();

  bool _autovalidation = false;
  bool _isLoading = false;
  String _error ;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text('Name',style: TextStyle(color:myColors.secondText),),
          leading:  IconButton(
            icon: Icon(Icons.arrow_back, color: myColors.secondText),
            onPressed: () => Navigator.of(context).pop(),
          ),
          backgroundColor: Colors.grey.shade100,
        ),
      body: Column(
        children: <Widget>[
          Padding(
            padding: EdgeInsets.all( 10.0),
            child: Form(
              key: formKey,
              child: new TextFormField(
                controller: _nameController,
                validator: (value) {
                  if (value.isEmpty) {
                    return 'Enter Your Name';
                  }
                  return null;
                },
                decoration: const InputDecoration(hintText: "Update Your Name"),
                  ),
            ),
          ),
          Center(
            child: Padding(
              padding: const EdgeInsets.only(top: 190.0,left: 20,right: 20,),
              child: SizedBox(
                width: double.infinity,
                height: 50,
                child: FlatButton(
                  shape: new RoundedRectangleBorder(
                    borderRadius: new BorderRadius.circular(10.0),
                  ),
                  child: Text(
                    'Update',
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
                    _updateName();
                  },
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }


  Future<void> _updateName() async {
    if (!formKey.currentState.validate()) {
      setState(() {
        _autovalidation = true;
      });
    } else {
      setState(() {
        _isLoading = true;
        _autovalidation = false;
      });
      FirebaseUser user = await FirebaseAuth.instance.currentUser();
      print(user.uid);
      Firestore.instance.collection('service_owner')
          .document(user.uid)
          .updateData({
        'name': _nameController.text,
      });
      Navigator.pop(context);
    }
  }
}
