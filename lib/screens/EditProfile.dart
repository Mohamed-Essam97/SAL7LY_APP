import 'dart:io';
import 'package:path/path.dart' as Path;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:sal7ly_firebase/global/Colors.dart' as myColors;
import 'package:sal7ly_firebase/screens/updatePhone.dart';

class EditProfile extends StatefulWidget {
  @override
  _EditProfileState createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile>
    with SingleTickerProviderStateMixin {

  String imageUrlPath = 'https://www.pngitem.com/middle/mJiimi_my-profile-icon-blank-profile-picture-circle-hd';



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: myColors.red,
        centerTitle: true,
        title: Text('Edit profile'),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            children: <Widget>[
              Padding(
                padding: EdgeInsets.all(30.0),
                child: new Stack(
                  fit: StackFit.loose,
                  children: <Widget>[
                    image(imageUrlPath),
                    Padding(
                      padding: EdgeInsets.only(top: 80.0, right: 80.0),
                      child: new Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          new CircleAvatar(
                            backgroundColor: myColors.red,
                            radius: 20.0,
                            child: IconButton(
                                icon: Icon(
                                  Icons.camera_alt,
                                  color: Colors.white,
                                ),
                                onPressed: () {},
                                iconSize: 25.0),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    'Mohamed Essam',
                    style: TextStyle(fontSize: 20, fontFamily: 'Bold'),
                  ),
                  SizedBox(
                    height: 8,
                  ),
                  Text('01007670722')
                ],
              ),
            ],
          ),
          SizedBox(height: 30,),
          Container(
            height: 50.0,
            child: GestureDetector(
              onTap: () {
                Navigator.of(context).pushNamed('/EditName');              },
              child:Container(
                child: Padding(
                  padding: const EdgeInsets.only(top: 10,left: 40),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text('Name',style: TextStyle(fontFamily: 'Regular'),),
                          Text('Mohamed Essam',style: TextStyle(fontFamily: 'Bold'),),
                        ],
                      ),
                      IconButton(icon: Icon(Icons.chevron_right), onPressed: (){
                        Navigator.of(context).pushNamed('/EditName');
                      }),
                    ],
                  ),
                ),
              ),
            ),
          ),
          SizedBox(height: 10,),
          Container(
            height: 0.2,
            width: double.infinity,
            color: myColors.primaryText,
          ),
          Container(
            height: 50.0,
            child: GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => EditPhone(),
                  ),
                );
                },
              child:Container(
                child: Padding(
                  padding: const EdgeInsets.only(top: 10,left: 40),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text('Phone Number',style: TextStyle(fontFamily: 'Regular'),),
                          Text('01007670722',style: TextStyle(fontFamily: 'Bold'),),
                        ],
                      ),
                      IconButton(icon: Icon(Icons.chevron_right), onPressed: (){
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => EditPhone(),
                          ),
                        );
                      }),
                    ],
                  ),
                ),
              ),
            ),
          ),
          SizedBox(height: 10,),
          Container(
            height: 0.2,
            width: double.infinity,
            color: myColors.primaryText,
          ),
          Container(
            height: 50.0,
            child: GestureDetector(
              onTap: () {
                Navigator.of(context).pushNamed('/EditPhone');
              },
              child:Container(
                child: Padding(
                  padding: const EdgeInsets.only(top: 10,left: 40),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text('Email',style: TextStyle(fontFamily: 'Regular'),),
                          Text('mohamedEssam@hotmail.com',style: TextStyle(fontFamily: 'Bold'),),
                        ],
                      ),
                      IconButton(icon: Icon(Icons.chevron_right), onPressed: (){
                        Navigator.of(context).pushNamed('/EditPhone');
                      }),
                    ],
                  ),
                ),
              ),
            ),
          ),
          SizedBox(
            height: 80,
          ),
          Center(
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: SizedBox(
                width: double.infinity,
                height: 40,
                child: FlatButton(
                  shape: new RoundedRectangleBorder(
                    borderRadius: new BorderRadius.circular(10.0),
                  ),
                  child: Text(
                    'Save',
                    style: TextStyle(
                      fontFamily: 'SemiBold',
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.w600,
                      letterSpacing: 1,
                    ),
                  ),
                  color: myColors.green[900],
                  textColor: Colors.white,
                  onPressed: () {
                  },
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }


  Widget image(String imageUrl){
    return Container(
      width: 110.0,
      height: 110.0,
      decoration: new BoxDecoration(
        shape: BoxShape.circle,
        image: new DecorationImage(
          image: NetworkImage(imageUrl),
          fit: BoxFit.cover,
        ),
      ),
    );
  }

}
