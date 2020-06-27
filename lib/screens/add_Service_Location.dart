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

  List <ad> service_type_name=new List();
  var Lat;
  var Long;
  List <DocumentReference> service_type_refernce=new List();
  List  <String> splizatian_name=new List();
  List <DocumentReference> splizatin_refernce=new List();



  getAndSaveCurrentLocation() async {
    Position position = await Geolocator()
        .getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
    print(position.latitude);
    print(position.longitude);
    Lat = position.latitude;
    Long = position.longitude;
    Navigator.of(context).push(MaterialPageRoute(
      builder: (context)=>ServiceDetails(Lat:Lat,Long:Long,serviceTypeList:service_type_name,service_type_refernce:spl,splizatian_name:splizatian_name,splizatin_refernce:splizatin_refernce),
    ));
  }
  List <ad> type=new List();
  List <ad> spl=new List();

  @override
  Widget build(BuildContext context) {
    var deviceInfo = MediaQuery.of(context);
    return Scaffold(
        body:StreamBuilder<QuerySnapshot>(
            stream: Firestore.instance.collection('service_type')

                .snapshots(),
            builder:
                (BuildContext context,
                AsyncSnapshot<QuerySnapshot> snapshot) {
              if (!snapshot.hasData)
                return new Text(
                  'Error: ${snapshot.error.toString()}',
                  textDirection: TextDirection.ltr,
                );
              switch (snapshot.connectionState) {
                case ConnectionState.waiting:
                  return new Text(
                    'Loading...',
                    textDirection: TextDirection.ltr,
                  );
                default:
                  DocumentReference  amr ;
                  type=new List();
                  service_type_name = new List();
                  snapshot.data.documents.forEach((element) {
                    service_type_name.add(new ad(element['name'],element.reference,amr));
                    service_type_refernce.add(element.reference);
                    type.add(new ad(element["name"], element.reference,amr));

                  });

                  return  StreamBuilder<QuerySnapshot>(
                      stream: Firestore.instance.collection('specialization')

                          .snapshots(),
                      builder:
                          (BuildContext context,
                          AsyncSnapshot<QuerySnapshot> snapshott) {
                        if (!snapshott.hasData)
                          return new Text(
                            'Error: ${snapshott.error.toString()}',
                            textDirection: TextDirection.ltr,
                          );
                        switch (snapshott.connectionState) {
                          case ConnectionState.waiting:
                            return new Text(
                              'Loading...',
                              textDirection: TextDirection.ltr,
                            );
                          default:
                            spl=new List();
                            splizatian_name = new List();
                            splizatin_refernce = new List();
                            snapshott.data.documents.forEach((element) {
                              splizatian_name.add(element["name"]);
                              splizatin_refernce.add(element["service_type"]);
                              spl.add(new ad(element["name"], element.reference,element['service_type']));

                            });
                            return Container(

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
                            );
                        }});
              }}));
  }



}
class ad{
  String x;
  DocumentReference xs;
  DocumentReference service_Type_Ref;
  ad(this.x,this.xs,this.service_Type_Ref);
  get xx=>x;
  get xxs=>xs;


}












/*
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

  List <String> service_type_name=new List();
  var Lat;
  var Long;
  List <DocumentReference> service_type_refernce=new List();
  List  <String> splizatian_name=new List();
  List <DocumentReference> splizatin_refernce=new List();



  getAndSaveCurrentLocation() async {
    Position position = await Geolocator()
        .getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
    print(position.latitude);
    print(position.longitude);
    Lat = position.latitude;
    Long = position.longitude;
    Navigator.of(context).push(MaterialPageRoute(
      builder: (context)=>ServiceDetails(Lat:Lat,Long:Long,serviceTypeList:service_type_name,service_type_refernce:service_type_refernce,splizatian_name:splizatian_name,splizatin_refernce:splizatin_refernce),
    ));
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
        body:StreamBuilder<QuerySnapshot>(
            stream: Firestore.instance.collection('service_type')

                .snapshots(),
            builder:
                (BuildContext context,
                AsyncSnapshot<QuerySnapshot> snapshot) {
              if (!snapshot.hasData)
                return new Text(
                  'Error: ${snapshot.error.toString()}',
                  textDirection: TextDirection.ltr,
                );
              switch (snapshot.connectionState) {
                case ConnectionState.waiting:
                  return new Text(
                    'Loading...',
                    textDirection: TextDirection.ltr,
                  );
                default:
                  service_type_name=new List();
                  service_type_refernce=new List();
                  snapshot.data.documents.forEach((element) {
                    service_type_name.add(element["name"]);
                    service_type_refernce.add(element.reference);

                  });

                  return  StreamBuilder<QuerySnapshot>(
                      stream: Firestore.instance.collection('specialization')

                          .snapshots(),
                      builder:
                          (BuildContext context,
                          AsyncSnapshot<QuerySnapshot> snapshott) {
                        if (!snapshott.hasData)
                          return new Text(
                            'Error: ${snapshott.error.toString()}',
                            textDirection: TextDirection.ltr,
                          );
                        switch (snapshott.connectionState) {
                          case ConnectionState.waiting:
                            return new Text(
                              'Loading...',
                              textDirection: TextDirection.ltr,
                            );
                          default:
                            splizatian_name=new List();
                            splizatin_refernce=new List();
                            snapshott.data.documents.forEach((element) {
                              splizatian_name.add(element["name"]);
                              splizatin_refernce.add(element.reference);

                            });
                            return Container(
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
                            );
                        }});
              }}));
  }



}*/
