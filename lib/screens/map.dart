import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:sal7ly_firebase/global/Colors.dart' as myColors;
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geolocator/geolocator.dart';
import 'package:fluttertoast/fluttertoast.dart';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_sign_in/google_sign_in.dart';

class MyMap extends StatefulWidget {
  @override
  State<MyMap> createState() => MyMapSampleState();
}

class MyMapSampleState extends State<MyMap> {
  GoogleMapController mapController;
  List<Position> kk = [];
  Position gg;
  String searchAddr;

  @override
  Widget build(BuildContext context) {
    searchandNavigate() {
      if(searchAddr.length>=1){
        Geolocator().placemarkFromAddress(searchAddr).then((result) {
          mapController.animateCamera(CameraUpdate.newCameraPosition(
              CameraPosition(
                  target: LatLng(
                      result[0].position.latitude, result[0].position.longitude),
                  zoom: 10.0)));
          print(result[0].position);
          gg = result[0].position;
        });
      }else
        {
          Fluttertoast.showToast(msg: "Please Enter The Address.");

        }
    }

    void onMapCreated(controller) {
      setState(() {
        mapController = controller;
      });
    }

    return Scaffold(
      body: Stack(
        children: <Widget>[
          GoogleMap(
            onMapCreated: onMapCreated,
            initialCameraPosition: CameraPosition(
                target: LatLng(30.051084999999997, 31.3655989), zoom: 10.0),
          ),
          Positioned(
              top: 30.0,
              right: 15.0,
              left: 15.0,
              child: Container(
                height: 50.0,
                width: double.infinity,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10.0),
                    color: Colors.white),
                child: Column(children: <Widget>[
                  TextField(
                    decoration: InputDecoration(
                        hintText: 'ضع عنوانك',
                        border: InputBorder.none,
                        contentPadding: EdgeInsets.only(left: 15.0, top: 15.0),
                        suffixIcon: IconButton(
                            icon: Icon(Icons.search),
                            onPressed: searchandNavigate,
                            iconSize: 30.0)),
                    onChanged: (val) {
                      setState(() {
                        searchAddr = val;
                      });
                    },
                  ),
                ]),
              )),
          Center(
            child: SizedBox(
              width: 5,
              height: 5,
              child: Container(
                color: Colors.black,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 660, right: 15),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: <Widget>[
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.only(left: 10, right: 20),
                    child: SizedBox(
                      height: 40,
                      child: FlatButton(
                        shape: new RoundedRectangleBorder(
                          borderRadius: new BorderRadius.circular(10.0),
                        ),
                        color: myColors.green,
                        child: Text(
                          'Add Location',
                          style: TextStyle(
                            fontFamily: 'SemiBold',
                            color: Colors.white,
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                            letterSpacing: 1,
                          ),
                        ),
                        onPressed: () {
                          searchandNavigate();
                        },
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    height: 40.0,
                    child: GestureDetector(
                        onTap: () {
                          Navigator.pop(context);
                        },
                        child: Container(
                          decoration: BoxDecoration(
                            border: Border.all(
                              color: myColors.green,
                              style: BorderStyle.solid,
                              width: 1.0,
                            ),
                            color: Colors.transparent,
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Text(
                                "       Skip       ",
                                style: TextStyle(
                                  color: myColors.green,
                                  fontFamily: 'SemiBold',
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600,
                                  letterSpacing: 1,
                                ),
                              )
                            ],
                          ),
                        )),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

/*  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      body: Center(
        child: Stack(
          children: <Widget>[
            GoogleMap(
              mapType: MapType.normal,
              initialCameraPosition: CameraPosition(
                target: LatLng(30.1476397, 31.2822992),
                zoom: 11,
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 610, right: 15),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: <Widget>[
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.only(left: 10, right: 20),
                      child: SizedBox(
                        height: 40,
                        child: FlatButton(
                          shape: new RoundedRectangleBorder(
                            borderRadius: new BorderRadius.circular(10.0),
                          ),
                          color: myColors.green,
                          child: Text(
                            'Add Location',
                            style: TextStyle(
                              fontFamily: 'SemiBold',
                              color: Colors.white,
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                              letterSpacing: 1,
                            ),
                          ),
                          onPressed: () {},
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      height: 40.0,
                      child: GestureDetector(
                        onTap: () {
                          Navigator.pop(context);
                        },
                        child: Container(
                          decoration: BoxDecoration(
                            border: Border.all(
                              color: myColors.green,
                              style: BorderStyle.solid,
                              width: 1.0,
                            ),
                            color: Colors.transparent,
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Text(
                                "       Skip       ",
                                style: TextStyle(
                                  color: myColors.green,
                                  fontFamily: 'SemiBold',
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600,
                                  letterSpacing: 1,
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }*/
}

class Search extends StatefulWidget {
  Position x;
  Search(Position X) {
    this.x = X;
  }
  @override
  State<StatefulWidget> createState() => new _TawkelatState();
}

class _TawkelatState extends State<Search> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
      child: new Text(widget.x.toString()),
    ));
  }
}
