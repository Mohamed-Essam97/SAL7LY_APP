import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:sal7ly_firebase/global/Colors.dart' as myColors;
import 'package:flutter_multiselect/flutter_multiselect.dart';
import 'package:multiselect_formfield/multiselect_formfield.dart';
import 'package:sal7ly_firebase/screens/add_Service_Location.dart';
import 'chat/Widgets/Loading.dart';

class ServiceDetails extends StatefulWidget {
  var Lat;
  var Long;
  List<ad> serviceTypeList;
  List<ad> service_type_refernce;
  List<String> splizatian_name;
  List<DocumentReference> splizatin_refernce;

  ServiceDetails(
      {this.Lat,
      this.Long,
      this.serviceTypeList,
      this.splizatin_refernce,
      this.splizatian_name,
      this.service_type_refernce});

  @override
  _ServiceDetailsState createState() => _ServiceDetailsState(
      Lat,
      Long,
      serviceTypeList,
      service_type_refernce,
      splizatian_name,
      service_type_refernce);
}

class _ServiceDetailsState extends State<ServiceDetails> {
  var Lat;
  var Long;
  List<ad> service_type_refernce;
  List<String> splizatian_name;
  List<ad> splizatin_refernce;
  DocumentReference val;
  DocumentReference serviceType;
  DocumentReference specialization;

  _ServiceDetailsState(
      this.Lat,
      this.Long,
      this.serviceTypeList,
      this.service_type_refernce,
      this.splizatian_name,
      this.splizatin_refernce);

  List<ad> serviceTypeList;
  List<String> spicalizationList = ["d", "d"];

  //List<String> selectedChoices = List();

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
      DocumentReference documentReference =
          Firestore.instance.collection('service').document();
      DocumentReference ref =
          Firestore.instance.collection('service_owner').document(user.uid);
      documentReference.setData({
        'owner_id': user.uid,
        'active': true,
        'location': GeoPoint(Lat, Long),
        'service_id': documentReference.documentID,
        'name': _serviceNameController.text,
        'service_owner': ref,
        'phone': _servicePhoneController.text,
        'rating': double.tryParse('0'),
        'specialization': specialization ,
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
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
                  offset: Offset(10, 0),
                ),
                SizedBox(
                  width: 38,
                ),
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
          Row(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: returnSelectedChips(),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: updateSpecialization != null ? returnSpecializationSelectedChips() : Text(' '),
              ),
            ],
          ),
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
                  _validateForm();
                  print(serviceTypeList);
                  print(splizatin_refernce);
                },
              ),
            ),
          ),
        ],
      ),
    ));
  }

  bool a = false;
  String serviceTypeHint = 'Choose';
  String specializationHint = 'Choose';
//  List<ad> updateSpecialization = new List();
  List<ad> updateSpecialization = null;

  Widget returnSelectedChips() {
    String dropdownValue = 'One';
    int _value = 1;

    return Column(
      children: <Widget>[
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
          child: new DropdownButton<ad>(
            icon: Icon(Icons.arrow_drop_down),
            iconSize: 24,
            elevation: 16,
            style: TextStyle(color: Colors.deepPurple),
            items: widget.serviceTypeList.map((value) {
              return new DropdownMenuItem<ad>(
                value: value,
                child: new Text(value.x),
              );
            }).toList(),
            onChanged: (ad value) {
              setState(() {
                _selectedItem = value.x;
                _dropdownError = null;
                print(widget.serviceTypeList);
                serviceTypeHint=value.x;
                updateSpecialization = new List();
                for (int i = 0; i < splizatin_refernce.length; i++) {
                  if (value.xs == splizatin_refernce[i].service_Type_Ref) {
                    print(value);
                    print(splizatin_refernce[i].x);

                    updateSpecialization.add(new ad(
                        splizatin_refernce[i].x,
                        splizatin_refernce[i].xs,
                        splizatin_refernce[i].service_Type_Ref));
                  }
                }
              });
            },
            hint: Text(serviceTypeHint),
          ),
        ),
        _dropdownError == null
            ? SizedBox.shrink()
            : Text(
                _dropdownError ?? "",
                style: TextStyle(color: Colors.red),
              ),
      ],
    );
  }

  String _dropdownError;
  String _selectedItem;

  _validateForm() {
    bool _isValid = formKey.currentState.validate();

    if (_selectedItem == null) {
      setState(() => _dropdownError = "Please select an option!");
      _isValid = false;
    }

    if (_isValid) {
      //form is valid
    }
  }

  Widget returnSpecializationSelectedChips() {
    String dropdownValue = 'One';
    int _value = 1;

    return Column(
      children: <Widget>[
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
          child: new DropdownButton<ad>(
            items: updateSpecialization.map((value) {
              return new DropdownMenuItem<ad>(
                value: value,
                child: new Text(value.x),
              );
            }).toList(),
            onChanged: (ad value) {
              setState(() {
                _selectedItem = value.x;
                _dropdownError = null;
                specializationHint=value.x.toString();
              });
              print(widget.serviceTypeList);
              specialization = value.xxs;
            },
            hint: Text(specializationHint),
          ),
        ),
        _dropdownError == null
            ? SizedBox.shrink()
            : Text(
          _dropdownError ?? "",
          style: TextStyle(color: Colors.red),
        ),
      ],
    );
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
            ),*/ /*

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
            ),*/ /*

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
                   */ /*

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
