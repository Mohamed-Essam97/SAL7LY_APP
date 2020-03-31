import "package:flutter/material.dart";

class demo extends StatefulWidget {
  demo({Key key}) : super(key: key);
  @override
  _demo createState() => _demo();
}

class LoginData {
  String username = "";
  String password = "";
  String Name = "";
  String PhoneNumber = "";
}

class _demo extends State {
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
                              return "Please enter username";
                            }
                            return null;
                          },
                          onSaved: (String inValue) {
                            this._loginData.username = inValue;
                          },
                          decoration: InputDecoration(
                              hintText: "none@none.com",
                              labelText: "Username (Email address)")),
                      TextFormField(
                          obscureText: true,
                          validator: (String inValue) {
                            if (inValue.length < 10) {
                              return "Password must be >=10 in length";
                            }
                            return null;
                          },
                          onSaved: (String inValue) {
                            this._loginData.password = inValue;
                          },
                          decoration: InputDecoration(
                              hintText: "Password", labelText: "Password")),
                      TextFormField(
                          keyboardType: TextInputType.text,
                          obscureText: true,
                          onSaved: (String inValue) {
                            this._loginData.Name= inValue;
                          },
                          decoration: InputDecoration(
                              hintText: "Your Name", labelText: "Your Name")),
                      TextFormField(
                          keyboardType: TextInputType.phone,
                          obscureText: true,
                          onSaved: (String inValue) {
                            this._loginData.PhoneNumber = inValue;
                          },
                          decoration: InputDecoration(
                              hintText: "Your Phone", labelText: "Phone Number")),
                      RaisedButton(
                          child: Text("Log In!"),
                          onPressed: () {
                            if (_formKey.currentState.validate()) {
                              _formKey.currentState.save();
                              print("Username: ${_loginData.username}");
                              print("Password: ${_loginData.password}");
                            }
                          })
                    ])))));
  }
}
