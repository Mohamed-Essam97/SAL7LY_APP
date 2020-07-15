import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:like_button/like_button.dart';
import 'package:path/path.dart' as Path;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:sal7ly_firebase/global/Colors.dart' as myColors;
import 'package:sal7ly_firebase/screens/chat/Widgets/Loading.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:timeago/timeago.dart' as timeago;
class ServiceProfile extends StatefulWidget {
  String serviceID;
  String serviceName;

  ServiceProfile({this.serviceID, this.serviceName});

  @override
  _ServiceProfileState createState() =>
      _ServiceProfileState(serviceID, serviceName);
}

class _ServiceProfileState extends State<ServiceProfile> {
  String serviceID;
  String serviceName;
  _ServiceProfileState(this.serviceID, this.serviceName);

  List<String> rimg = [];
  List<String> rphone = [];
  List<String> rcomment = new List<String>();
  List<String> rsender = new List<String>();
  List<int> rcounter = new List<int>();
  List<Timestamp> rtime = new List<Timestamp>();
  String phone_number;

  List<String> servicePhone = [];


  File imageFile;
  String _uploadedFileURL;
  bool _isActive = true;

  TextEditingController _descriptionController = TextEditingController();

  final formKey = new GlobalKey<FormState>();

/*
  Future uploadServiceImage() async {
    if(!_uploadedFileURL.isEmpty)
    {
      print(serviceID);
      Firestore.instance
          .collection('service')
          .document(serviceID)
          .updateData({'image': _uploadedFileURL});

    }else
      {
        print('Error');
      }

  }
*/

  _openGallary(BuildContext context) async {
    var picture = await ImagePicker.pickImage(source: ImageSource.gallery);
    this.setState(() {
      imageFile = picture;
    });
   // uploadFile();
    Navigator.of(context).pop();
    _showImageDialoge(context);
  }

  _openCamera(BuildContext context) async {
    var picture = await ImagePicker.pickImage(source: ImageSource.camera);
    this.setState(() {
      imageFile = picture;
    });
   // uploadFile();
    Navigator.of(context).pop();
    _showImageDialoge(context);
  }

  Future<void> _showChoiceDialoge(BuildContext context) {
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text("Make a Choice! "),
            content: SingleChildScrollView(
              child: ListBody(
                children: <Widget>[
                  GestureDetector(
                    child: Text("Gallary"),
                    onTap: () {
                      _openGallary(context);
                    },
                  ),
                  Padding(padding: EdgeInsets.all(5.0)),
                  GestureDetector(
                    child: Text("Camera"),
                    onTap: () {
                      _openCamera(context);
                    },
                  )
                ],
              ),
            ),
          );
        });
  }

  Future<void> _showImageDialoge(BuildContext context) {
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text("Image"),
            content: SingleChildScrollView(
              child: ListBody(
                children: <Widget>[
                  Column(
                    children: <Widget>[
                      Image.file(imageFile, width: 400, height: 400),
                      SizedBox(
                        height: 20,
                      ),
                      GestureDetector(
                        child: Text(
                          "Save",
                          style: TextStyle(fontSize: 20, color: myColors.green),
                        ),
                        onTap: () {
                          uploadFile();
                          Navigator.of(context).pop();
                        },
                      ),
                    ],
                  ),
                  Padding(padding: EdgeInsets.all(5.0)),
                ],
              ),
            ),
          );
        });
  }

  Future uploadFile() async {
    StorageReference storageReference = FirebaseStorage.instance
        .ref()
        .child('service/${Path.basename(imageFile.path)}}');
    StorageUploadTask uploadTask = storageReference.putFile(imageFile);
    await uploadTask.onComplete;
    print('File Uploaded');
    storageReference.getDownloadURL().then((fileURL) {
      _uploadedFileURL = fileURL;
      print(_uploadedFileURL);
      print(serviceID);
      Firestore.instance
          .collection('service')
          .document(serviceID)
          .updateData({'image': _uploadedFileURL});
    });
  }

  Widget returnImage() {
    return new StreamBuilder(
        stream: Firestore.instance
            .collection('service')
            .document(serviceID)
            .snapshots(),
        builder: (context, snapshots) {
          if (!snapshots.hasData && _uploadedFileURL == null) {
            return SizedBox(
              width: double.infinity,
              height: MediaQuery.of(context).size.height * 0.25,
              child: Image(
                image: AssetImage('assets/first.png'),
                fit: BoxFit.cover,
              ),
            );
          }
          var userDocument = snapshots.data;
          // ignore: missing_return
          return SizedBox(
            width: double.infinity,
            height: MediaQuery.of(context).size.height * 0.25,
            child: Image(
              image: NetworkImage(userDocument["image"].toString()),
              fit: BoxFit.cover,
            ),
          );
        });
  }

  void addDescription() {
    if (!formKey.currentState.validate()) {
      print('Error');
    } else {
      Firestore.instance.collection('service').document(serviceID).updateData({
        'description': _descriptionController.text,
      });
      _descriptionController.clear();
      Navigator.of(context).pop();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(serviceName),
      ),
      body: Container(child: drawScreen(context)),
    );
  }

  Future<void> _showDescriptionDialoge(BuildContext context) {
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text("Enter The Service Description"),
            content: SingleChildScrollView(
              child: ListBody(
                children: <Widget>[
                  Column(
                    children: <Widget>[
                      Form(
                        key: formKey,
                        child: new TextFormField(
                          controller: _descriptionController,
                          validator: (value) {
                            if (value.isEmpty) {
                              return 'Please Write description';
                            }
                            return null;
                          },
                          decoration:
                              const InputDecoration(hintText: "Description"),
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          GestureDetector(
                            child: Text(
                              "Save",
                              style: TextStyle(
                                  fontSize: 20, color: myColors.green),
                            ),
                            onTap: () {
                              addDescription();
                            },
                          ),
                          GestureDetector(
                            child: Text(
                              "Cancel",
                              style:
                                  TextStyle(fontSize: 20, color: myColors.red),
                            ),
                            onTap: () {
                              _descriptionController.clear();
                              Navigator.of(context).pop();
                            },
                          ),
                        ],
                      ),
                    ],
                  ),
                  Padding(padding: EdgeInsets.all(5.0)),
                ],
              ),
            ),
          );
        });
  }

  GoogleMapController mapController;
  List<Position> kk = [];
  Position gg;
  String searchAddr;

  void onMapCreated(controller) {
    setState(() {
      mapController = controller;
    });
  }

  Widget _buildGridItem(context, index) {
    return Column(
      children: <Widget>[
        Material(
          elevation: 7.0,
          shadowColor: Colors.blueAccent.shade700,
          child: InkWell(
            onTap: () {},
            child: Hero(
              tag: index['title'],
              child: Image.network(
                index["pic"],
                fit: BoxFit.fill,
                height: 132,
                width: 100,
              ),
            ),
          ),
        ),
        Container(
          width: 100,
          margin: EdgeInsets.only(top: 10, bottom: 5),
          child: Text(
            index["content"],
            textAlign: TextAlign.center,
            overflow: TextOverflow.ellipsis,
            maxLines: 2,
            style: TextStyle(
              fontSize: 10,
              fontWeight: FontWeight.w900,
            ),
          ),
        ),
      ],
    );
  }

  List<String> days = new List<String>();

  Widget returnRev(BuildContext context) {
    return Container(
      height : 260,
      child : ListView.builder(
          shrinkWrap: true,
          scrollDirection: Axis.vertical,
          itemBuilder: (context, index) {
            if (index < rcomment.length) {
              return new Container(
                  child: Stack(children: <
                      Widget>[
                    Padding(
                        padding:
                        EdgeInsets.only(
                            bottom: 40.0)),
                    Row(
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.only(left:8.0),
                          child: CircleAvatar(
                            radius: 20.0,
                            backgroundImage:
                            NetworkImage(
                                rimg[index]),
                          ),
                        ),
                        new Padding(
                            padding:
                            EdgeInsets.only(
                                left: 7)),
                        (phone_number != null)
                            ? {
                          rsender[index] =
                              phone_number,
                          Text(
                            rsender[index] +
                                ": ",
                            style: TextStyle(
                                color: myColors
                                    .secondText,
                                fontFamily: 'Regular'),
                          )
                        }
                            : Text(
                            rsender[index],
                            style: TextStyle(
                                color: myColors
                                    .secondText,
                                fontFamily: 'Bold')),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            timeago.format(
                                rtime[index]
                                    .toDate()),
                            style: TextStyle(
                                color: myColors
                                    .primaryText,
                                fontFamily: "Regular"),),
                        ),
                      ],
                    ),
                    Container(height: 20),
                    Padding(
                        padding:
                        EdgeInsets.all(36),
                        child: Card(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                          elevation: 0,
                          color:
                          Colors.grey[300],
                          child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: <Widget>[
                                ListTile(
                                  title: Text(
                                    rcomment[index],
                                    style: TextStyle(
                                        color: Colors
                                            .black,
                                        fontFamily: "Semi_Bold"),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: LikeButton(
                                    onTap:
                                    onLikeButtonTapped,
                                    size: 48.0,
                                    circleColor: CircleColor(
                                        start:myColors.red,
                                        end: myColors.red),
                                    bubblesColor:
                                    BubblesColor(
                                      dotPrimaryColor:
                                      myColors.red,
                                      dotSecondaryColor:
                                      Color(
                                          0xffAD0514),
                                    ),
                                    likeCount:
                                    rcounter[
                                    index],
                                    likeBuilder: (bool
                                    isLiked) {
                                      return Icon(
                                        Icons
                                            .favorite_border,
                                        color: isLiked
                                            ? Color(
                                            0xffAD0514)
                                            : null,
                                        size: 24.0,
                                      );
                                    },
                                    countBuilder: (int
                                    count,
                                        bool isLiked,
                                        String text) {
                                      var color = isLiked
                                          ? Colors
                                          .black
                                          : Colors
                                          .black;
                                      int result2;
                                      if (count ==
                                          0) {
                                        result2 = 0;
                                      }
                                      else
                                        rcounter[
                                        index] =
                                            count;
                                      //return result;
                                    },
                                  ),
                                )
                              ]
                          ),
                        )
                    ),
                  ]));
            }
          }),
    );
  }

/*
  Widget returnReviews(BuildContext context) {
    return new StreamBuilder(
      stream: Firestore.instance
          .collection('service')
          .document("9NdLU1IYB3YldVt515pW")
          .snapshots(),
      builder: (context, AsyncSnapshot snapshot) {
        var doc = snapshot.data;
        if (!snapshot.hasData)
          return new Center(
            child: Text("No Reviews for this service"),
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
            if (doc['comments']['comment']['content'] == null &&
                serviceName == null) {
              return Container(
                child: Text(
                  "No Reviews for this Service",
                  style: TextStyle(color: Colors.black),
                ),
              );
            } else {
              return Column(
                children: <Widget>[
                  drawScreen(),
                  Container(
                      child: returnRev(),),
                ],
              );
            }
        }
      },
    );
  }
*/



  List<String> phones = [];

  Widget drawScreen(BuildContext context) {
    return SingleChildScrollView(
      child: StreamBuilder(
          stream: Firestore.instance
              .collection('service')
              .document(serviceID)
              .snapshots(),
          builder: (context, snapshots) {
            if (!snapshots.hasData) {
              return Loading();
            }
            var userDocument = snapshots.data;
           // print(userDocument['comments']['comment']['content'].toString());
            //print("dsadad");
            if (userDocument['comments'] == null) {
            // ignore: missing_return
              _isActive = userDocument['active'];
              days = List.from(userDocument['off_days']);
              phones = List.from(userDocument['phone']);
              int len =phones.length;
              return Column(
              children: <Widget>[
                Stack(
                  children: <Widget>[
                    returnImage(),
                    Transform.translate(
                      offset: Offset(-180, 140),
                      child: new Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          new CircleAvatar(
                            backgroundColor: myColors.primaryText,
                            radius: 20.0,
                            child: IconButton(
                                icon: Icon(
                                  Icons.camera_alt,
                                  color: Colors.white,
                                ),
                                onPressed: () {
                                  _showChoiceDialoge(context);
                                },
                                iconSize: 25.0),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 2.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Row(
                              children: <Widget>[
                                Container(
                                  width: 10.0,
                                  height: 10.0,
                                  decoration: new BoxDecoration(
                                    color:
                                    _isActive ? Colors.green : Colors.red,
                                    shape: BoxShape.circle,
                                  ),
                                ),
                                SizedBox(width: 3),
                                Text(_isActive ? 'Active' : 'Not Active'),
                              ],
                            ),
                          ),
                          RatingBarIndicator(
                            rating: userDocument["rating"],
                            unratedColor: Colors.grey.shade300,
                            itemBuilder: (context, index) => Icon(
                              Icons.star,
                              color: myColors.green,
                            ),
                            itemCount: 5,
                            itemSize: 30.0,
                            direction: Axis.horizontal,
                          ),
                        ],
                      ),
                      Padding(
                        padding: const EdgeInsets.all(6.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: <Widget>[
                            Text(
                              userDocument["name"].toString(),
                              style:
                              TextStyle(fontSize: 30, fontFamily: 'Bold'),
                            ),
                            Text(
                              phones.toString().substring(1,phones.toString().length-1),
                              style:
                              TextStyle(fontSize: 15, color: Colors.grey),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                Column(
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        children: <Widget>[
                          Text(
                            'Off Days:',
                            style: TextStyle(
                                fontSize: 15,
                                color: Colors.black,
                                fontFamily: 'Bold'),
                          ),
                          SizedBox(
                            width: 3,
                          ),
                          Row(
                            children: <Widget>[
                              Text(days.toString().substring(1,days.toString().length-1)),
                            ],
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        children: <Widget>[
                          Text(
                            'Time:',
                            style: TextStyle(
                                fontSize: 15,
                                color: Colors.black,
                                fontFamily: 'Bold'),
                          ),
                          SizedBox(
                            width: 3,
                          ),
                          Row(
                            children: <Widget>[
                              Text(userDocument['time']['start_time']
                                  .toString() +
                                  ' to '),
                              Text(userDocument['time']['end_time']
                                  .toString()),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                Container(
                  height: 0.1,
                  width: double.infinity,
                  color: Colors.black,
                ),
                Padding(
                  padding: const EdgeInsets.only(right: 300, top: 8),
                  child: Text(
                    'Description:',
                    style: TextStyle(color: Colors.black, fontSize: 15 , fontFamily: 'Bold'),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    userDocument['description'].toString(),
                    style: TextStyle(color: Colors.grey,fontFamily: 'Regular'),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 320),
                  child: IconButton(
                      icon: Icon(
                        Icons.edit,
                        color: Colors.grey,
                      ),
                      onPressed: () {
                        _showDescriptionDialoge(context);
                      }),
                ),
                Container(
                  height: 0.2,
                  width: double.infinity,
                  color: Colors.black,
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Center(
                    child: Text(
                      'Reviews',
                      style: TextStyle(fontSize: 15, fontFamily: 'Bold'),
                    ),
                  ),
                ),
                Container(
                child: Text("No Reviews for this Service",
                style: TextStyle(color: Colors.black),),
                ),
              ],
            );
            }
            else {
            rcomment = List.from(userDocument['comments']['comment']['content']);
            rsender = List.from(userDocument['comments']['comment']['sender']);
            rcounter = List.from(userDocument['comments']['comment']['love']);
            rtime= List.from(userDocument['comments']['comment']['at']);
            rimg= List.from(userDocument['comments']['comment']['pic']);
            _isActive = userDocument['active'];
            return Container(
              child: SingleChildScrollView(
                child: Column(
                  children: <Widget>[
                    Stack(
                      children: <Widget>[
                        returnImage(),
                        Transform.translate(
                          offset: Offset(-180, 140),
                          child: new Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              new CircleAvatar(
                                backgroundColor: myColors.primaryText,
                                radius: 20.0,
                                child: IconButton(
                                    icon: Icon(
                                      Icons.camera_alt,
                                      color: Colors.white,
                                    ),
                                    onPressed: () {
                                      _showChoiceDialoge(context);
                                    },
                                    iconSize: 25.0),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 2.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Row(
                                  children: <Widget>[
                                    Container(
                                      width: 10.0,
                                      height: 10.0,
                                      decoration: new BoxDecoration(
                                        color:
                                            _isActive ? Colors.green : Colors.red,
                                        shape: BoxShape.circle,
                                      ),
                                    ),
                                    SizedBox(width: 3),
                                    Text(_isActive ? 'Active' : 'Not Active'),
                                  ],
                                ),
                              ),
                              RatingBarIndicator(
                                rating: userDocument["rating"],
                                unratedColor: Colors.grey.shade300,
                                itemBuilder: (context, index) => Icon(
                                  Icons.star,
                                  color: myColors.green,
                                ),
                                itemCount: 5,
                                itemSize: 30.0,
                                direction: Axis.horizontal,
                              ),
                            ],
                          ),
                          Padding(
                            padding: const EdgeInsets.all(6.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: <Widget>[
                                Text(
                                  userDocument["name"].toString(),
                                  style:
                                      TextStyle(fontSize: 30, fontFamily: 'Bold'),
                                ),
                                Text(
                                  userDocument["phone"][0].toString(),
                                  style:
                                      TextStyle(fontSize: 15, color: Colors.grey),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    Column(
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            children: <Widget>[
                              Text(
                                'Off Days:',
                                style: TextStyle(
                                    fontSize: 15,
                                    color: Colors.black,
                                    fontFamily: 'Bold'),
                              ),
                              SizedBox(
                                width: 3,
                              ),
                              Row(
                                children: <Widget>[
                                  Text(userDocument['off_days'][0].toString() +
                                      ' , '),
                                  Text(userDocument['off_days'][1].toString()),
                                ],
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            children: <Widget>[
                              Text(
                                'Time:',
                                style: TextStyle(
                                    fontSize: 15,
                                    color: Colors.black,
                                    fontFamily: 'Bold'),
                              ),
                              SizedBox(
                                width: 3,
                              ),
                              Row(
                                children: <Widget>[
                                  Text(userDocument['time']['start_time']
                                          .toString() +
                                      ' to '),
                                  Text(userDocument['time']['end_time']
                                      .toString()),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    Container(
                      height: 0.1,
                      width: double.infinity,
                      color: Colors.black,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(right: 300, top: 8),
                      child: Text(
                        'Description:',
                        style: TextStyle(color: Colors.black, fontSize: 15 , fontFamily: 'Bold'),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        userDocument['description'].toString(),
                        style: TextStyle(color: Colors.grey,fontFamily: 'Regular'),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 320),
                      child: IconButton(
                          icon: Icon(
                            Icons.edit,
                            color: Colors.grey,
                          ),
                          onPressed: () {
                            _showDescriptionDialoge(context);
                          }),
                    ),
                    Container(
                      height: 0.2,
                      width: double.infinity,
                      color: Colors.black,
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Center(
                        child: Text(
                          'Reviews',
                          style: TextStyle(fontSize: 15, fontFamily: 'Bold'),
                        ),
                      ),
                    ),
                    returnRev(context),

                  ],
                ),
              ),
            );
          }
          }),
    );
  }

  Widget drawScreenn(BuildContext context) {
    return SingleChildScrollView(
      child: StreamBuilder(
          stream: Firestore.instance
              .collection('service')
              .document(serviceID)
              .snapshots(),
          builder: (context, snapshots) {
            if (!snapshots.hasData) {
              return Loading();
            }
            var userDocument = snapshots.data;
            print(userDocument['comments']['comment']['content'].toString());
            //print("dsadad");
            if (userDocument['comments']['comment']['content'] == null) {
              // ignore: missing_return
              return Container(
                child: Text("No Reviews for this Service",
                  style: TextStyle(color: Colors.black),),
              );
            }
            else {
              rcomment = List.from(userDocument['comments']['comment']['content']);
              rsender = List.from(userDocument['comments']['comment']['sender']);
              rcounter = List.from(userDocument['comments']['comment']['love']);
              rtime= List.from(userDocument['comments']['comment']['at']);
              rimg= List.from(userDocument['comments']['comment']['pic']);
              _isActive = userDocument['active'];
              return Container(
                child: SingleChildScrollView(
                  child: Column(
                    children: <Widget>[
                      Stack(
                        children: <Widget>[
                          returnImage(),
                          Transform.translate(
                            offset: Offset(-180, 140),
                            child: new Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                new CircleAvatar(
                                  backgroundColor: myColors.primaryText,
                                  radius: 20.0,
                                  child: IconButton(
                                      icon: Icon(
                                        Icons.camera_alt,
                                        color: Colors.white,
                                      ),
                                      onPressed: () {
                                        _showChoiceDialoge(context);
                                      },
                                      iconSize: 25.0),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 2.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Row(
                                    children: <Widget>[
                                      Container(
                                        width: 10.0,
                                        height: 10.0,
                                        decoration: new BoxDecoration(
                                          color:
                                          _isActive ? Colors.green : Colors.red,
                                          shape: BoxShape.circle,
                                        ),
                                      ),
                                      SizedBox(width: 3),
                                      Text(_isActive ? 'Active' : 'Not Active'),
                                    ],
                                  ),
                                ),
                                RatingBarIndicator(
                                  rating: userDocument["rating"],
                                  unratedColor: Colors.grey.shade300,
                                  itemBuilder: (context, index) => Icon(
                                    Icons.star,
                                    color: myColors.green,
                                  ),
                                  itemCount: 5,
                                  itemSize: 30.0,
                                  direction: Axis.horizontal,
                                ),
                              ],
                            ),
                            Padding(
                              padding: const EdgeInsets.all(6.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: <Widget>[
                                  Text(
                                    userDocument["name"].toString(),
                                    style:
                                    TextStyle(fontSize: 30, fontFamily: 'Bold'),
                                  ),
                                  Text(
                                    userDocument["phone"][0].toString(),
                                    style:
                                    TextStyle(fontSize: 15, color: Colors.grey),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      Column(
                        children: <Widget>[
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Row(
                              children: <Widget>[
                                Text(
                                  'Off Days:',
                                  style: TextStyle(
                                      fontSize: 15,
                                      color: Colors.black,
                                      fontFamily: 'Bold'),
                                ),
                                SizedBox(
                                  width: 3,
                                ),
                                Row(
                                  children: <Widget>[
                                    Text(userDocument['off_days'][0].toString() +
                                        ' , '),
                                    Text(userDocument['off_days'][1].toString()),
                                  ],
                                ),
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Row(
                              children: <Widget>[
                                Text(
                                  'Time:',
                                  style: TextStyle(
                                      fontSize: 15,
                                      color: Colors.black,
                                      fontFamily: 'Bold'),
                                ),
                                SizedBox(
                                  width: 3,
                                ),
                                Row(
                                  children: <Widget>[
                                    Text(userDocument['time']['start_time']
                                        .toString() +
                                        ' to '),
                                    Text(userDocument['time']['end_time']
                                        .toString()),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      Container(
                        height: 0.1,
                        width: double.infinity,
                        color: Colors.black,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(right: 300, top: 8),
                        child: Text(
                          'Description:',
                          style: TextStyle(color: Colors.black, fontSize: 15),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          userDocument['description'].toString(),
                          style: TextStyle(color: Colors.grey),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 320),
                        child: IconButton(
                            icon: Icon(
                              Icons.edit,
                              color: Colors.grey,
                            ),
                            onPressed: () {
                              _showDescriptionDialoge(context);
                            }),
                      ),
                      Container(
                        height: 0.2,
                        width: double.infinity,
                        color: Colors.black,
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Center(
                          child: Text(
                            'Reviews',
                            style: TextStyle(fontSize: 15, fontFamily: 'Bold'),
                          ),
                        ),
                      ),

                      returnRev(context),
                    ],
                  ),
                ),
              );
            }
          }),
    );
  }

  Future<bool> onLikeButtonTapped(bool isLiked) async {
    /// send your request here
    // final bool success= await sendRequest();
    Firestore.instance.collection("service").document(serviceID).updateData({
      "comments": {
        'comment': {
          'content': rcomment,
          'sender': rsender,
          'love': rcounter,
          'at': rtime,
          'pic': rimg,
        }
      }
    });
}
}
