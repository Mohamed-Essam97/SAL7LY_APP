import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:sal7ly_firebase/global/Colors.dart' as myColors;

class ServiceDetails extends StatefulWidget {
  @override
  _ServiceDetailsState createState() => _ServiceDetailsState();
}

class _ServiceDetailsState extends State<ServiceDetails> {
  List<String> serviceTypeList = [
    "ونش",
    "ورشه",
    "مغسله",
    "بنزينه",
    "قطع غيار",
    "توكيل",
    "مركز صيانه شامل",
    "شئ اخر"
  ];

  List<String> spicalizationList = [
    "ميكانيكى",
    "كهؤبائى",
    "سمكرى",
    "كوتش و بطاريات",
    "زجاج",
    "عفشه",
    "سروجى",
    "اكسسورات",
    "شئ اخر",
  ];

  //List<String> selectedChoices = List();
  List<String> selectedServiceTypeList = List();
  List<String> selectedSpicalizationList = List();

  var phone1="";
  var phone2="";
  List<String> phones = List();
  String serviceName;
  saveNameAndPhoneNumber()
  async {

    FirebaseUser user = await FirebaseAuth.instance.currentUser();
    print(user.uid);
    final databaseReference = Firestore.instance;
    await databaseReference
        .collection("service")
        .document("${user.uid}")
        .updateData({
      'name': serviceName,
      'phone':phones,
    });


  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: myColors.background,
        child: ListView(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(top: 30, bottom: 0),
              child: Center(
                child: Text(
                  "Service Details",
                  style: TextStyle(
                    fontFamily: 'Bold',
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(15.0),
              child: TextFormField(
                decoration: InputDecoration(
                  hintText: 'Service Name',
                ),
                onChanged: (value) {
                  setState(() {
                    serviceName = value;
                  });
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(15, 1, 15, 15),
              child: TextFormField(
                keyboardType:TextInputType.numberWithOptions(),
                decoration: InputDecoration(
                  hintText: 'Service Phone Number',
                ),
                onChanged: (value) {
                  setState(() {
                    phone1 = value;
                    phones.add(phone1);
                  });
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(15, 1, 15, 15),
              child: TextFormField(
                autofocus: false,
                keyboardType:TextInputType.numberWithOptions(),
                decoration: InputDecoration(
                  hintText: 'Another Phone Number',
                ),
                onChanged: (value) {
                  setState(() {
                    phone2 = value;
                    phones.add(phone2);
                  });
                },
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
              child: MultiSelectChip(
                serviceTypeList,
                onSelectionChanged: (selectedList) {
                  setState(() {
                    selectedServiceTypeList = selectedList;
                  });
                },
              ),
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
              child: MultiSelectChip(
                spicalizationList,
                onSelectionChanged: (selectedList) {
                  setState(() {
                    selectedSpicalizationList = selectedList;
                  });
                },
              ),
            ),
            /*Padding(
              padding: const EdgeInsets.only(left: 15),
              child: Text(selectedSpicalizationList.join(" , ")),
            ),*/
            Padding(
              padding: const EdgeInsets.all(20.0),
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
                  print(selectedSpicalizationList);
                  print(selectedServiceTypeList);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  /* _showReportDialog() {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          //Here we will build the content of the dialog
          return AlertDialog(
            title: Text("Report Video"),
            content: MultiSelectChip(
              serviceTypeList,
              onSelectionChanged: (selectedList) {
                setState(() {
                  selectedReportList = selectedList;
                });
              },
            ),
            actions: <Widget>[
              FlatButton(
                child: Text("Report"),
                onPressed: () => Navigator.of(context).pop(),
              )
            ],
          );
        });
  }*/
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
