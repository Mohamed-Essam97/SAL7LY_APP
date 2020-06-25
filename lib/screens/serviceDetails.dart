import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:sal7ly_firebase/global/Colors.dart' as myColors;

import 'chat/Widgets/Loading.dart';

class ServiceDetails extends StatefulWidget {


  var Lat;
  var Long;
  List<String> serviceTypeList ;
  List <DocumentReference> service_type_refernce;
  List  <String> splizatian_name;
  List <DocumentReference> splizatin_refernce;
  List<ad>spl;
  List<ad>type;



  ServiceDetails({this.spl,this.type,this.Lat, this.Long,this.serviceTypeList,this.splizatin_refernce,this.splizatian_name,this.service_type_refernce});

  @override
  _ServiceDetailsState createState() => _ServiceDetailsState(spl,type,Lat,Long,serviceTypeList,service_type_refernce,splizatian_name,service_type_refernce);
}

class _ServiceDetailsState extends State<ServiceDetails> {

  var Lat;
  var Long;
  List <DocumentReference> service_type_refernce;
  List  <String> splizatian_name;
  List <DocumentReference> splizatin_refernce;
  List<ad>spl;
  List<ad>type;


  _ServiceDetailsState(this.spl,this.type,this.Lat, this.Long,this.serviceTypeList,this.service_type_refernce,this.splizatian_name,this.splizatin_refernce);







  List<String> serviceTypeList ;
  List<String> spicalizationList=["d","d"] ;
















  //List<String> selectedChoices = List();
  List<String> selectedServiceTypeList = List();
  List<String> selectedSpicalizationList = List();


  TextEditingController _serviceNameController = TextEditingController();
  TextEditingController _servicePhoneController = TextEditingController();
  TextEditingController _phoneTwoController = TextEditingController();

  final formKey = new GlobalKey<FormState>();

  List phones;
  saveNameAndPhoneNumber() async {
    if (!formKey.currentState.validate()) {

    } else {
      FirebaseUser user = await FirebaseAuth.instance.currentUser();
      print(user.uid);
      DocumentReference documentReference = Firestore.instance.collection('service').document();
      DocumentReference ref = Firestore.instance.collection('service_owner').document(user.uid);
      documentReference
          .setData({
        'owner_id':user.uid,
        'active':true,
        'location':GeoPoint(Lat, Long),
        'service_id': documentReference.documentID,
        'name': _serviceNameController.text,
        'service_owner': ref,
        'phone':_servicePhoneController.text,
        'rating':double.tryParse('0'),
      });
    }
  }



  @override
  Widget build(BuildContext context) {



    return
      Scaffold(
          body:


          Container(
            //color: myColors.background,
            child: ListView(
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.only(top: 30, bottom: 0),
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
                        "Service Details",
                        style: TextStyle(
                          fontFamily: 'Bold',
                          fontSize: 30,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: Form(
                    key: formKey,
                    child: Column(
                      children: <Widget>[
                        TextFormField(
                          controller: _serviceNameController,
                          validator: (value) {
                            if (value.isEmpty) {
                              return 'Enter Service Name';
                            }
                            return null;
                          },
                          decoration: InputDecoration(
                            hintText: 'Service Name',
                          ),
                        ),
                        TextFormField(
                          controller: _servicePhoneController,
                          validator: (value) {
                            if (value.isEmpty) {
                              return 'Enter Service Phone';
                            }
                            return null;
                          },
                          decoration: InputDecoration(
                            hintText: 'Service Phone',
                          ),
                        ),
                        TextFormField(
                          controller: _phoneTwoController,
                          decoration: InputDecoration(
                            hintText: 'Service Phone',
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 15, top: 15),
                  child: Text(
                    "Service Type",
                    style: TextStyle(
                      fontFamily: 'SemiBold',
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: returnSelectedChipss(serviceTypeList,type),
                ),
                /*Padding(
              padding: const EdgeInsets.only(left: 15),
              child: Text(selectedServiceTypeList.join(" , ")),
            ),*/
                Padding(
                  padding: const EdgeInsets.only(left: 15, top: 15),
                  child: Text(
                    "Service Specialization",
                    style: TextStyle(
                      fontFamily: 'SemiBold',
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: returnSelectedChips(spicalizationList),
                ),
                /*Padding(
              padding: const EdgeInsets.only(left: 15),
              child: Text(selectedSpicalizationList.join(" , ")),
            ),*/
                Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: SizedBox(
                    height: 45,
                    width: double.infinity,
                    child: FlatButton(
                      shape: new RoundedRectangleBorder(
                        borderRadius: new BorderRadius.circular(10.0),
                      ),
                      color: myColors.green,
                      child: Text(
                        'Save',
                        style: TextStyle(
                          fontFamily: 'SemiBold',
                          color: Colors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          letterSpacing: 1,
                        ),
                      ),
                      onPressed: () {
                        saveNameAndPhoneNumber();
                        /* Navigator.pushNamed(context, '/FinalDetails');
                   */
                        print(selectedSpicalizationList);
                        print(selectedServiceTypeList);
                      },
                    ),
                  ),
                ),
              ],
            ),
          )
      );
  }



  Widget returnSelectedChips(List<String> Listt)
  {
    return MultiSelectChip(
      Listt,
      onSelectionChanged: (selectedList) {
        setState(() {
          selectedServiceTypeList = selectedList;
        });
      },
    );
  }

  Widget returnSelectedChipss(type ,spl)
  {

    return MultiSelectChip(
      spl,
      onSelectionChanged: (selectedList) {
        setState(() {


          for(int i=0;i<selectedList.length;i++) {
            for (int j = 0; j < widget.splizatin_refernce.length; j++) {
              if (selectedList == widget.spl[i].xxs) {
                spicalizationList.add(widget.spl[i].x);
              }
            }
          }
        });
      },
    );
  }

  forr()
  {
    for(int i=0;i<widget.spl.length;i++) {
      for(int j=0;j<widget.type.length;j++) {
        if (widget.type[j].xxs == widget.spl[i].xxs) {
          spicalizationList.add(widget.spl[i].x);
        }
      }
    }
  }


}



class MultiSelectChip extends StatefulWidget {
  final List<String> reportList;
  final Function(List<String>) onSelectionChanged;

  MultiSelectChip(this.reportList, {this.onSelectionChanged});

  @override
  _MultiSelectChipState createState() => _MultiSelectChipState();
}

class _MultiSelectChipState extends State<MultiSelectChip> {
  // String selectedChoice = "";
  List<String> selectedChoices = List();

  _buildChoiceList() {
    List<Widget> choices = List();

    widget.reportList.forEach((item) {
      choices.add(Container(
        padding: const EdgeInsets.all(2.0),
        child: ChoiceChip(
          label: Text(item),
          selected: selectedChoices.contains(item),
          onSelected: (selected) {
            setState(() {
              selectedChoices.contains(item)
                  ? selectedChoices.remove(item)
                  : selectedChoices.add(item);
              widget.onSelectionChanged(selectedChoices);
            });
          },
        ),
      ));
    });

    return choices;
  }

  @override
  Widget build(BuildContext context) {
    return Wrap(
      children: _buildChoiceList(),
    );
  }
}
class ad{
  String x;
  DocumentReference xs;
  ad(this.x,this.xs);
  get xx{
    return x;
  }
  get xxs{
    return xxs;
  }


}























/*
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:sal7ly_firebase/global/Colors.dart' as myColors;

import 'chat/Widgets/Loading.dart';

class ServiceDetails extends StatefulWidget {


  var Lat;
  var Long;
  List<String> serviceTypeList ;
  List <DocumentReference> service_type_refernce;
  List  <String> splizatian_name;
  List <DocumentReference> splizatin_refernce;


  ServiceDetails({this.Lat, this.Long,this.serviceTypeList,this.splizatin_refernce,this.splizatian_name,this.service_type_refernce});

  @override
  _ServiceDetailsState createState() => _ServiceDetailsState(Lat,Long,serviceTypeList,service_type_refernce,splizatian_name,service_type_refernce);
}

class _ServiceDetailsState extends State<ServiceDetails> {

  var Lat;
  var Long;
  List <DocumentReference> service_type_refernce;
  List  <String> splizatian_name;
  List <DocumentReference> splizatin_refernce;

  _ServiceDetailsState(this.Lat, this.Long,this.serviceTypeList,this.service_type_refernce,this.splizatian_name,this.splizatin_refernce);







  List<String> serviceTypeList ;

  List<String> spicalizationList = [
    "ميكانيكى",
    "كهؤبائى",
    "سمكرى",
    "كوتش و بطاريات",
    "زجاج",
    "عفشه",
    "سروجى",
    "اكسسورات",
  ];








  Future <Widget> async()
  {
    return  Firestore.instance
        .collection("service_type")
        .document()
        .get()
        .then((snapshot) {
      try {
        return returnSelectedChips(List.from(snapshot['name']));
      } catch (e) {
        print(e);
        return null;
      }
    });

  }







  //List<String> selectedChoices = List();
  List<String> selectedServiceTypeList = List();
  List<String> selectedSpicalizationList = List();


  TextEditingController _serviceNameController = TextEditingController();
  TextEditingController _servicePhoneController = TextEditingController();
  TextEditingController _phoneTwoController = TextEditingController();

  final formKey = new GlobalKey<FormState>();

  List phones;
  saveNameAndPhoneNumber() async {
    if (!formKey.currentState.validate()) {

    } else {
      FirebaseUser user = await FirebaseAuth.instance.currentUser();
      print(user.uid);
      DocumentReference documentReference = Firestore.instance.collection('service').document();
      DocumentReference ref = Firestore.instance.collection('service_owner').document(user.uid);
      documentReference
          .setData({
        'owner_id':user.uid,
        'active':true,
        'location':GeoPoint(Lat, Long),
        'service_id': documentReference.documentID,
        'name': _serviceNameController.text,
        'service_owner': ref,
        'phone':_servicePhoneController.text,
        'rating':double.tryParse('0'),
      });
    }
  }



  @override
  Widget build(BuildContext context) {



    return
      Scaffold(
          body:


          Container(
            //color: myColors.background,
            child: ListView(
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.only(top: 30, bottom: 0),
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
                        "Service Details",
                        style: TextStyle(
                          fontFamily: 'Bold',
                          fontSize: 30,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: Form(
                    key: formKey,
                    child: Column(
                      children: <Widget>[
                        TextFormField(
                          controller: _serviceNameController,
                          validator: (value) {
                            if (value.isEmpty) {
                              return 'Enter Service Name';
                            }
                            return null;
                          },
                          decoration: InputDecoration(
                            hintText: 'Service Name',
                          ),
                        ),
                        TextFormField(
                          controller: _servicePhoneController,
                          validator: (value) {
                            if (value.isEmpty) {
                              return 'Enter Service Phone';
                            }
                            return null;
                          },
                          decoration: InputDecoration(
                            hintText: 'Service Phone',
                          ),
                        ),
                        TextFormField(
                          controller: _phoneTwoController,
                          decoration: InputDecoration(
                            hintText: 'Service Phone',
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 15, top: 15),
                  child: Text(
                    "Service Type",
                    style: TextStyle(
                      fontFamily: 'SemiBold',
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: returnSelectedChips(serviceTypeList),
                ),
                */
/*Padding(
              padding: const EdgeInsets.only(left: 15),
              child: Text(selectedServiceTypeList.join(" , ")),
            ),*//*

                Padding(
                  padding: const EdgeInsets.only(left: 15, top: 15),
                  child: Text(
                    "Service Specialization",
                    style: TextStyle(
                      fontFamily: 'SemiBold',
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: returnSelectedChips(splizatian_name),
                ),
                */
/*Padding(
              padding: const EdgeInsets.only(left: 15),
              child: Text(selectedSpicalizationList.join(" , ")),
            ),*//*

                Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: SizedBox(
                    height: 45,
                    width: double.infinity,
                    child: FlatButton(
                      shape: new RoundedRectangleBorder(
                        borderRadius: new BorderRadius.circular(10.0),
                      ),
                      //color: myColors.green,
                      child: Text(
                        'Save',
                        style: TextStyle(
                          fontFamily: 'SemiBold',
                          color: Colors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          letterSpacing: 1,
                        ),
                      ),
                      onPressed: () {
 //                       saveNameAndPhoneNumber();
                        */
/* Navigator.pushNamed(context, '/FinalDetails');
                   *//*

                        print(selectedSpicalizationList);
                        print(selectedServiceTypeList);
                      },
                    ),
                  ),
                ),
              ],
            ),
          )
      );
  }



  Widget returnSelectedChips(List<String> Listt)
  {
    return MultiSelectChip(
      Listt,
      onSelectionChanged: (selectedList) {
        setState(() {
          selectedServiceTypeList = selectedList;
        });
      },
    );
  }

}

class MultiSelectChip extends StatefulWidget {
  final List<String> reportList;
  final Function(List<String>) onSelectionChanged;

  MultiSelectChip(this.reportList, {this.onSelectionChanged});

  @override
  _MultiSelectChipState createState() => _MultiSelectChipState();
}

class _MultiSelectChipState extends State<MultiSelectChip> {
  // String selectedChoice = "";
  List<String> selectedChoices = List();

  _buildChoiceList() {
    List<Widget> choices = List();

    widget.reportList.forEach((item) {
      choices.add(Container(
        padding: const EdgeInsets.all(2.0),
        child: ChoiceChip(
          label: Text(item),
          selected: selectedChoices.contains(item),
          onSelected: (selected) {
            setState(() {
              selectedChoices.contains(item)
                  ? selectedChoices.remove(item)
                  : selectedChoices.add(item);
              widget.onSelectionChanged(selectedChoices);
            });
          },
        ),
      ));
    });

    return choices;
  }

  @override
  Widget build(BuildContext context) {
    return Wrap(
      children: _buildChoiceList(),
    );
  }
}*/
