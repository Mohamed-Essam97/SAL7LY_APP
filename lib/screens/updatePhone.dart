import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:international_phone_input/international_phone_input.dart';
import 'package:intl_phone_number_input/intl_phone_number_input.dart';
import 'package:sal7ly_firebase/global/Colors.dart' as myColors;

class EditPhone extends StatefulWidget {
  @override
  _EditPhoneState createState() => _EditPhoneState();
}

class _EditPhoneState extends State<EditPhone> {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  final TextEditingController controller = TextEditingController();
  String initialCountry = 'EG';
  PhoneNumber number = PhoneNumber(isoCode: 'EG');
  bool valdation = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('Phone Number',style: TextStyle(color:myColors.secondText),),
        leading:  IconButton(
          icon: Icon(Icons.arrow_back, color: myColors.secondText),
          onPressed: () => Navigator.of(context).pop(),
        ),
        backgroundColor: Colors.grey.shade100,
      ),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Form(
          key: formKey,
          child: Container(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                InternationalPhoneNumberInput(
                  onInputChanged: (PhoneNumber number) {
                    print(number.phoneNumber);
                  },
                 /* onInputValidated: (bool value) {
                    if (value == true) {
                      // ignore: missing_return, missing_return
                      return ' Enter';
                    } else {
                      return null;
                    }
                  },*/
                  ignoreBlank: false,
                  autoValidate: true,
                  selectorTextStyle: TextStyle(color: Colors.black),
                  initialValue: number,
                  textFieldController: controller,
                  onInputValidated: (value) {
                    if (value==null) {
                      return 'Enter Your Phone Number';
                    }
                    return null;
                  },
                ),
                /*    RaisedButton(
                  onPressed: () {
                    print(controller.text);
                    formKey.currentState.validate();
                  },
                  child: Text('Validate'),
                ),
                RaisedButton(
                  onPressed: () {
                    print(controller.text);
                    getPhoneNumber('+15417543010');
                  },
                  child: Text('Update'),
                ),*/
                Center(
                  child: Padding(
                    padding: const EdgeInsets.only(
                      top: 190.0,
                      left: 20,
                      right: 20,
                    ),
                    child: SizedBox(
                      width: double.infinity,
                      height: 50,
                      child: FlatButton(
                        shape: new RoundedRectangleBorder(
                          borderRadius: new BorderRadius.circular(10.0),
                        ),
                        child: Text(
                          'Update',
                          style: TextStyle(
                            fontFamily: 'SemiBold',
                            color: Colors.white,
                            fontSize: 20,
                            fontWeight: FontWeight.w600,
                            letterSpacing: 1,
                          ),
                        ),
                        color: myColors.green[900],
                        textColor: Colors.white,
                        onPressed: () {
                            _updatePhone();
                          },
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<void> _updatePhone() async {
    if (!formKey.currentState.validate()) {
      setState(() {
      });
    } else {
      setState(() {

      });
      FirebaseUser user = await FirebaseAuth.instance.currentUser();
      print(user.uid);
      Firestore.instance.collection('service_owner')
          .document(user.uid)
          .updateData({
        'phone': controller.text,
      });
      Navigator.pop(context);
    }
  }


  void getPhoneNumber(String phoneNumber) async {
    PhoneNumber number =
        await PhoneNumber.getRegionInfoFromPhoneNumber(phoneNumber, 'US');

    setState(() {
      this.number = number;
    });
  }

  @override
  void dispose() {
    controller?.dispose();
    super.dispose();
  }
}
