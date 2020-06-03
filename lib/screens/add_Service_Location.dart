import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:geolocator/geolocator.dart';
import 'package:sal7ly_firebase/global/Colors.dart' as myColors;
import 'package:sal7ly_firebase/screens/serviceDetails.dart';

class AddServiceLocation extends StatefulWidget {
  @override
  _AddServiceLocationState createState() => _AddServiceLocationState();
}

class _AddServiceLocationState extends State<AddServiceLocation> {


  var Lat;
  var Long;

  getAndSaveCurrentLocation() async {
    Position position = await Geolocator()
        .getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
    print(position.latitude);
    print(position.longitude);
    Lat = position.latitude;
    Long = position.longitude;
    Navigator.of(context).push(MaterialPageRoute(
      builder: (context)=>ServiceDetails(Lat:Lat,Long:Long),
    ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: myColors.background,
        child: Column(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(top: 50, bottom: 0),
              child: Row(
                children: <Widget>[
                  Transform.translate(
                    child: IconButton(
                      icon: Icon(Icons.arrow_back_ios),
                      color: Colors.black,
                      onPressed: () {
                        Navigator.pop(context);
                      },
                    ),
                    offset: Offset(10,0),
                  ),
                  SizedBox(width: 38,),
                  Text(
                    "Service Location",
                    style: TextStyle(
                      fontFamily: 'Bold',
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              width: 400,
              height: 400,
              child: SvgPicture.asset(
                "assets/location.svg",
                matchTextDirection: false,
                width: 500,
                height: 500,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                height: 50.0,
                child: GestureDetector(
                  onTap: () {
                    getAndSaveCurrentLocation();
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: myColors.red,
                        style: BorderStyle.solid,
                        width: 1.0,
                      ),
                      color: Colors.transparent,
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        SvgPicture.asset(
                          "assets/icons/near.svg",
                          width: 24,
                          height: 24,
                          color: myColors.red,
                        ),
                        Text(
                          "Use current Address",
                          style: TextStyle(
                            color: myColors.red,
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
            Padding(
              padding: const EdgeInsets.only(top: 20),
              child: InkWell(
                  onTap: () {
                    Navigator.pushNamed(context, '/Map');
                  },
                  child: Center(
                    child: Text(
                      'Select it manually',
                      style: TextStyle(fontSize: 15, fontFamily: 'SemiBold'),
                    ),
                  )),
            ),
          ],
        ),
      ),
    );
  }



}
