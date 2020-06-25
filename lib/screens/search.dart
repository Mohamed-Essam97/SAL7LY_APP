import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'dart:async';
import 'dart:core';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:shared_preferences/shared_preferences.dart';
class Search extends StatefulWidget {
  @override
  _SearchState createState() => _SearchState();
}

class _SearchState extends State<Search> {

  List<String> rimg =[];
  List<String> rphone =[];
  List<String> rcomment = new List<String>();
  List<String> rsender = new List<String>();
  List<int> rcounter = new List<int>();
  List<Timestamp> rtime = new List<Timestamp>();
  String phone_number ;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body:StreamBuilder(
        stream: Firestore.instance.collection('service').document("9NdLU1IYB3YldVt515pW").snapshots(),
        builder:
            (context, AsyncSnapshot snapshot) {
          var doc = snapshot.data;
          if (!snapshot.hasData)
            return new Center(
              child : Text("No Reviews for this service"),
            );
          switch (snapshot.connectionState) {
            case ConnectionState.waiting:
              return new Text(
                'Loading...',
                textDirection: TextDirection.ltr,
              );
            default:
              print(doc['comments']['comment']['content'].toString());
              //print("dsadad");
              if(doc['comments']['comment']['content'] == null )
              {
                return Container(
                  child: Text("No Reviews for this Service",style: TextStyle(color: Colors.black),),
                );
              }
              else {
                rcomment = List.from(doc['comments']['comment']['content']);
                rsender = List.from(doc['comments']['comment']['sender']);
                rcounter = List.from(doc['comments']['comment']['love']);
                rtime= List.from(doc['comments']['comment']['at']);
                rimg= List.from(doc['comments']['comment']['pic']);
                return ListView.builder(
                    scrollDirection: Axis.vertical,
                    itemBuilder: (context, index){
                      if (index < rcomment.length){
                        return new Container(
                            child: Stack(
                                children: <Widget>[
                                  Padding(padding: EdgeInsets.only(bottom: 40.0)),
                                  Row(children: <Widget>[
                                    CircleAvatar(
                                      radius: 25.0,
                                      backgroundImage: NetworkImage(
                                          rimg[index]),
                                    ),
                                    new Padding(
                                        padding: EdgeInsets.only(left: 7)),
                                    (phone_number != null) ? {
                                      rsender[index] = phone_number,
                                      Text(rsender[index] + ": ", style: TextStyle(
                                          color: Colors.black,
                                          fontStyle: FontStyle.italic,
                                          fontWeight: FontWeight.bold),)} :
                                    Text(rsender[index] + ": ", style: TextStyle(
                                        color: Colors.black,
                                        fontStyle: FontStyle.italic,
                                        fontWeight: FontWeight.bold)),
                                    Padding(
                                        padding: EdgeInsets.only(left: 40)),
                                    /*Text(timeago.format(rtime[index].toDate())),*/
                                  ],
                                  ),
                                  Container(height: 20),
                                  Padding(
                                    padding: EdgeInsets.all(36),
                                    child: Card(color: Color(0xffAD0514),
                                      child: ListTile(
                                        title: Text(rcomment[index],
                                          style: TextStyle(color: Colors.white,
                                              fontWeight: FontWeight.bold,
                                              fontStyle: FontStyle.italic),),),
                                    ),
                                  ),
                                  Padding(
                                      padding: EdgeInsets.only(top: 90, left: 320),
                                      child: Column(children: <Widget>[
                                        IconButton(
                                            icon: Icon(Icons.favorite),
                                            color: Color(0xffAD0514),
//highlightColor: Colors.red,
                                            onPressed: () {

                                            }
                                        ),
                                        Text("${rcounter[index]} love"),

                                      ],
                                      )
                                  )
                                ]
                            )
                        );
                      }
                    }
                );
              }
          }
        },
      )
    );
  }
}

