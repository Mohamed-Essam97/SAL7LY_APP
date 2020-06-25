import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:sal7ly_firebase/screens/chat/Widgets/Loading.dart';
import 'package:sal7ly_firebase/global/Colors.dart' as myColors;
import 'package:sal7ly_firebase/screens/serviceProfile.dart';

class Work_Shops extends StatefulWidget {
  @override
  _Work_ShopsState createState() => _Work_ShopsState();
}

Map<String, String> collections = {'service': 'service'};

class _Work_ShopsState extends State<Work_Shops> {
  bool isLoading = true;

  FirebaseUser _user;
  String _errorMessage;
  bool _hasError = false;
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 2), () {
      setState(() {
        isLoading = false;
      });
    });
    FirebaseAuth.instance.currentUser().then((user) {
      setState(() {
        _user = user;
        _hasError = false;
        _isLoading = false;
      });
    }).catchError((error) {
      setState(() {
        _hasError = true;
        _errorMessage = error.toString();
      });
    });
  }




  @override
  Widget build(BuildContext context) {
    if (isLoading == true) {
      return Loading();
    } else {
      return Container(
        child: Scaffold(
          body: _conTent(context),
        ),
      );
    }
  }

  Widget _conTent(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(8),
      child: StreamBuilder(
        stream: Firestore.instance.collection('service').snapshots(),
        // ignore: missing_return
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.none:
            case ConnectionState.waiting:
            case ConnectionState.active:
            case ConnectionState.done:
              if (snapshot.hasError) {
                print("Error");
              }
              if (!snapshot.hasData) {
                print("No Error");
              }
              return drawScreen(context);
              break;
          }
        },
      ),
    );
  }

  String serviceName;
  String serviceID ;
  Widget drawScreen(BuildContext context) {
    return new StreamBuilder(
      stream: Firestore.instance
          .collection('service')
          .where("owner_id", isEqualTo: _user.uid)
          .snapshots(),
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (!snapshot.hasData) {
          return Loading();
        }
        return new ListView(
          children: snapshot.data.documents.map((document) {
            return GestureDetector(
              onTap: () {
                serviceID = document['service_id'].toString();
                serviceName = document['name'].toString();
                Navigator.of(context).push(MaterialPageRoute(
                  builder: (context)=>ServiceProfile(serviceID:serviceID,serviceName:serviceName),
                ));
              },
              child: Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15.0),
                ),
                margin: EdgeInsets.only(bottom: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    SizedBox(
                      width: double.infinity,
                      height: MediaQuery.of(context).size.height * 0.25,
                      child: Image(
                        image: NetworkImage(document['image'].toString()),
                        fit: BoxFit.cover,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Row(children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: RatingBarIndicator(
                            rating: document["rating"],
                            unratedColor: Colors.grey.shade300,
                            itemBuilder: (context, index) => Icon(
                              Icons.star,
                              color: myColors.green,
                            ),
                            itemCount: 5,
                            itemSize: 30.0,
                            direction: Axis.horizontal,
                          ),
                        ),
                        SizedBox(
                          width: 50,
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: <Widget>[
                            Text(
                              document['name'],
                              style: TextStyle(
                                  color: Colors.grey.shade900,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 15),
                            ),
                            Text(
                              document['phone'][0].toString(),
                              style: TextStyle(color: Colors.grey),
                            ),
                          ],
                        ),
                      ],
                      ),
                    ),
                  ],
                ),
              ),
            );
          }).toList(),
        );
      },
    );
  }

  Widget _drawScreen(BuildContext context, QuerySnapshot data) {
    return ListView.builder(
      padding: EdgeInsets.all(8),
      itemCount: data.documents.length,
      itemBuilder: (context, position) {
        return Padding(
          padding: const EdgeInsets.only(bottom: 8),
          child: Card(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
/*
                SizedBox(
                  width: double.infinity,
                  height: MediaQuery.of(context).size.height * 0.25,
                  child: Image(
                    image: NetworkImage(data.documents[position]['image']),
                    fit: BoxFit.cover,
                  ),
                ),
*/
                Padding(
                  padding: const EdgeInsets.only(
                      bottom: 8, left: 16, right: 16, top: 16),
                  child: Text(
                    data.documents[position]['name'],
                    style: TextStyle(
                        color: Colors.grey.shade900,
                        fontWeight: FontWeight.bold,
                        fontSize: 15),
                  ),
                ),
                Row(
                  children: <Widget>[
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Text(
                            data.documents[position]['phone'].toString(),
                            style: TextStyle(color: Colors.grey),
                          ),
                        )
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _drawHeader() {
    return Row(
      children: <Widget>[
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text(
                'Mechanical',
                style: TextStyle(color: Colors.grey),
              ),
            )
          ],
        ),
        SizedBox(
          width: 100,
        ),
        Row(
          children: <Widget>[
            IconButton(
                icon: Icon(Icons.star),
                color: Colors.grey.shade400,
                onPressed: () {}),
            Transform.translate(
              offset: Offset(-12, 0),
              child: Text(
                '4.5',
                style: TextStyle(color: Colors.grey, fontSize: 16),
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _drawTitle() {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8, left: 16, right: 16, top: 16),
      child: Text(
        'Al-Amana WorkShop ',
        style: TextStyle(
            color: Colors.grey.shade900,
            fontWeight: FontWeight.bold,
            fontSize: 15),
      ),
    );
  }

  Widget _drawHashTags() {
    return Container(
      child: Wrap(
        children: <Widget>[
          FlatButton(
              onPressed: () {},
              child: Text(
                '#advance',
              )),
          FlatButton(
              onPressed: () {},
              child: Text(
                '#retro',
              )),
          FlatButton(
              onPressed: () {},
              child: Text(
                '#instagram',
              )),
        ],
      ),
    );
  }

  Widget _drawBody() {
    return SizedBox(
      width: double.infinity,
      height: MediaQuery.of(context).size.height * 0.25,
      child: Image(
        image: ExactAssetImage('assets/first.png'),
        fit: BoxFit.cover,
      ),
    );
  }

  Widget _drawFooter() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        FlatButton(onPressed: () {}, child: Text('10 COMMENTS')),
        Row(
          children: <Widget>[
            FlatButton(onPressed: () {}, child: Text('SHARE')),
            FlatButton(onPressed: () {}, child: Text('OPEN')),
          ],
        )
      ],
    );
  }
}
