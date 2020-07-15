import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:sal7ly_firebase/global/Colors.dart' as myColors;
import 'package:flutter_multiselect/flutter_multiselect.dart';
import 'package:multiselect_formfield/multiselect_formfield.dart';
import 'package:sal7ly_firebase/screens/add_Service_Location.dart';
import 'chat/Widgets/Loading.dart';
import 'package:path/path.dart' as Path;
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'dart:io';
import 'package:chips_choice/chips_choice.dart';
import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';
import 'package:intl/intl.dart';

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
  String phoneOne;
  String phoneTwo;


  final formKey = new GlobalKey<FormState>();

  File imageFile;
  String _uploadedFileURL;

  _openGallary(BuildContext context) async {
    var picture = await ImagePicker.pickImage(source: ImageSource.gallery);
    this.setState(() {
      imageFile = picture;
    });
    uploadFile();
    Navigator.of(context).pop();
    _showImageDialoge(context);
  }

  _openCamera(BuildContext context) async {
    var picture = await ImagePicker.pickImage(source: ImageSource.camera);
    this.setState(() {
      imageFile = picture;
    });
    uploadFile();
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
    });
  }

  Widget returnImage() {
    if (imageFile == null) {
      return Text("No Image Selected ! ");
    } else {
      return Image.file(imageFile, width: 600, height: 200);
    }
  }

  List<String> phones = [];


  saveNameAndPhoneNumber() async {
    if (!formKey.currentState.validate()) {
    } else {
      setState(() {
        phones.add(_servicePhoneController.text);
        phones.add(_phoneTwoController.text);
      });
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
        'phone': FieldValue.arrayUnion(phones),
        'rating': double.tryParse('0'),
        'specialization': specialization,
        'image': _uploadedFileURL,
        'off_days': FieldValue.arrayUnion(tags),
        'time':timee,
      });
      Navigator.of(context)
          .pushNamedAndRemoveUntil('/Home', (Route<dynamic> route) => false);
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
                  Row(
                    children: <Widget>[
                      IconButton(
                          icon: Icon(
                            Icons.camera_alt,
                            color: myColors.red,
                          ),
                          onPressed: () {
                            _showChoiceDialoge(context);
                          },
                          iconSize: 25.0),
                      Flexible(child: returnImage()),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextFormField(
                      controller: _serviceNameController,
                      validator: (value) {
                        if (value.isEmpty) {
                          return 'Enter Service Name';
                        }
                        return null;
                      },
                      decoration: InputDecoration(
                        prefixIcon: Padding(
                          padding: EdgeInsets.only(left: 5.0),
                          child: Icon(
                            Icons.assignment_ind,
                            color:  Colors.grey[400],
                          ), // icon is 48
                        ),
                        hintText: 'service name',
                        hintStyle: TextStyle(
                            fontSize: 15,
                            fontFamily: 'Regular',
                            color:  Colors.grey[400]),
                        contentPadding:
                            EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15.0)),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextFormField(
                      autofocus: false,
                      controller: _servicePhoneController,
                      validator: (value) {
                        if (value.isEmpty) {
                          return 'Enter Service Phone';
                        }
                        return null;
                      },
                      decoration: InputDecoration(
                        prefixIcon: Padding(
                          child: Icon(
                            Icons.phone,
                            color: Colors.grey[400],
                          ), // icon is
                          padding: EdgeInsets.only(left: 5.0),
                        ),
                        hintText: 'service phone',
                        hintStyle: TextStyle(
                            fontSize: 15,
                            fontFamily: 'Regular',
                            color:  Colors.grey[400]),
                        contentPadding:
                            EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15.0)),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextFormField(
                      controller: _phoneTwoController,
                      decoration: InputDecoration(
                        prefixIcon: Padding(
                          padding: EdgeInsets.only(left: 5.0),
                          child: Icon(
                            Icons.phone,
                            color:  Colors.grey[400],
                          ), // icon is
                        ),
                        hintText: 'service phone two',
                        hintStyle: TextStyle(
                            fontSize: 15,
                            fontFamily: 'Regular',
                            color:  Colors.grey[400]),
                        contentPadding:
                            EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15.0)),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Center(
            child: Row(
              children: <Widget>[
                returnSelectedChips(),
                updateSpecialization != null
                    ? returnSpecializationSelectedChips()
                    : Text(' '),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left:14.0),
            child: Text('Off Days:',style: TextStyle(fontSize: 15,fontFamily: 'SemiBold'),),
          ),
          off_Days(),
          Padding(
            padding: const EdgeInsets.only(bottom: 14),
            child: Container(
              height: 0.2,
              width: double.infinity,
              color: myColors.secondText,
            ),
          ),
          time(),
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
                  _validateForm();
                  saveNameAndPhoneNumber();
                  /* Navigator.pushNamed(context, '/FinalDetails');
                   */

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

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.only(left:6.0),
            child: Text('Service Type:',style: TextStyle(fontSize: 15,fontFamily: 'SemiBold'),),
          ),
          new DropdownButton<ad>(
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
                serviceTypeHint = value.x;
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
          _dropdownError == null
              ? SizedBox.shrink()
              : Text(
                  _dropdownError ?? "",
                  style: TextStyle(color: Colors.red),
                ),
        ],
      ),
    );
  }

  String _dropdownError;
  String _selectedItem;

  _validateForm() {
    bool _isValid = formKey.currentState.validate();

    if (_selectedItem == null) {
      setState(() => _dropdownError = "     Please select an option!");
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
          padding: const EdgeInsets.only(left:14.0),
          child: Text('Specialization:',style: TextStyle(fontSize: 15,fontFamily: 'SemiBold'),),
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
                specializationHint = value.x.toString();
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

  final _formKey = GlobalKey<FormState>();
  bool _autovalidate = false;
  String selectedSalutation;
  String name;
  List<String> tags = [];

  List<Map<String, String>> days = [
    {'value': 'mon', 'title': 'Monday'},
    {'value': 'tue', 'title': 'Tuesday'},
    {'value': 'wed', 'title': 'Wednesday'},
    {'value': 'thu', 'title': 'Thursday'},
    {'value': 'fri', 'title': 'Friday'},
    {'value': 'sat', 'title': 'Saturday'},
    {'value': 'sun', 'title': 'Sunday'},
  ];
  List<String> options = [
    'Sunday',
    'Saturday',
    'Friday',
    'Thursday',
    'Wednesday',
    'Tuesday',
    'Monday',
  ];
  Widget off_Days() {
    return ChipsChoice<String>.multiple(
      value: tags,
      options: ChipsChoiceOption.listFrom<String, String>(
        source: options,
        value: (i, v) => v,
        label: (i, v) => v,
      ),
      onChanged: (val) => setState(() => tags = val),
      isWrapped: true,
    );

    /*return ChipsChoice<String>.multiple(
      value: tags,
      options: ChipsChoiceOption.listFrom<String, String>(
        source: options,
        value: (i, v) => v,
        label: (i, v) => v,
      ),
      onChanged: (val) => setState(() => tags = val),
    );*/
  }


  var timee = new Map();

  String startTime;
  String endTime;


  final format = DateFormat("HH:mm");
  Widget time()
  {
    return Row(
      children: <Widget>[
        Flexible(
          child: Padding(
            padding: const EdgeInsets.only(left:10.0,right: 10.0),
            child: DateTimeField(
              validator: (value) {
                if (value==null) {
                  return 'Enter Service Phone';
                }
                return null;
              },
              decoration: InputDecoration(
                prefixIcon: Padding(
                  padding: EdgeInsets.only(left: 5.0),
                  child: Icon(
                    Icons.watch_later,
                    color:  Colors.grey[400],
                  ), // icon is
                ),
                hintText: 'Start time',
                hintStyle: TextStyle(
                    fontSize: 15,
                    fontFamily: 'Regular',
                    color:  Colors.grey[400]),
                contentPadding:
                EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15.0)),
              ),        format: format,
              onShowPicker: (context, currentValue) async {
                final time = await showTimePicker(
                  context: context,
                  initialTime: TimeOfDay.fromDateTime(currentValue ?? DateTime.now()),
                );
                startTime =DateTimeField.convert(time).hour.toString();
                timee['start_time'] = startTime;

                print(DateTimeField.convert(time).hour);
                return DateTimeField.convert(time);
              },
            ),
          ),
        ),
        Flexible(
          child: Padding(
            padding: const EdgeInsets.only(left:10.0,right: 10.0),
            child: DateTimeField(
              validator: (value) {
                if (value == null) {
                  return 'Enter Service Phone';
                }
                return null;
              },
              decoration: InputDecoration(
                prefixIcon: Padding(
                  padding: EdgeInsets.only(left: 5.0),
                  child: Icon(
                    Icons.watch_later,
                    color:  Colors.grey[400],
                  ), // icon is
                ),
                hintText: 'End time',
                hintStyle: TextStyle(
                    fontSize: 15,
                    fontFamily: 'Regular',
                    color:  Colors.grey[400]),
                contentPadding:
                EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15.0)),
              ),        format: format,
              onShowPicker: (context, currentValue) async {
                final time = await showTimePicker(
                  context: context,
                  initialTime: TimeOfDay.fromDateTime(currentValue ?? DateTime.now()),
                );
                endTime =DateTimeField.convert(time).hour.toString();
                timee['end_time'] = endTime;
                print(DateTimeField.convert(time).hour);
                return DateTimeField.convert(time);
              },
            ),
          ),
        ),
      ],
    );
  }

}
