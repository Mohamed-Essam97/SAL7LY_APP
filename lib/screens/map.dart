import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:sal7ly_firebase/global/Colors.dart' as myColors;

class MyMap extends StatefulWidget {
  @override
  State<MyMap> createState() => MyMapSampleState();
}

class MyMapSampleState extends State<MyMap> {
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      body: Center(
        child: Stack(
          children: <Widget>[
            GoogleMap(
              mapType: MapType.satellite,
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
                          print("object");
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
  }
}
