import 'package:flutter/material.dart';



class Arabiti extends StatefulWidget
{
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _Arabiti();
  }

}

class LoginData {
  String Car_Km = "";
}



class _Arabiti extends State {
  LoginData _loginData = new LoginData();

  GlobalKey<FormState> _formKey = new GlobalKey<FormState>();


  @override
  Widget build(BuildContext inContext) {
    return MaterialApp(
        home: Scaffold(
            body: Container(
                padding: EdgeInsets.all(50.0),
                child: Form(
                    key: this._formKey,
                    child: Column(children: [
                      TextFormField(
                          keyboardType: TextInputType.emailAddress,
                          validator: (String inValue) {
                            if (inValue.length == 0) {
                              return "من فضلك ادخل عدد كيلو سياراتك";
                            }
                            return null;
                          },
                          onSaved: (String inValue) {
                            this._loginData.Car_Km = inValue;
                          },
                          decoration: InputDecoration(
                              hintText: "كم",
                              labelText: "كم لسيارتك")),
                      RaisedButton(
                          child: Text("Log In!"),
                          onPressed: () {
                            if (_formKey.currentState.validate()) {
                              _formKey.currentState.save();
                              print("Username: ${_loginData.Car_Km}");
                            }
                          })
                    ]
                    )
                )
            )
        )
    );
  }
}
