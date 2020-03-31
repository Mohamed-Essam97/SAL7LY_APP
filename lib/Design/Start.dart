import 'package:flutter/material.dart';
import 'package:sal7ly_firebase/Firebase/Service_Owner_Data.dart';
import 'package:sal7ly_firebase/Design/RegisterTab.dart';
import 'package:sal7ly_firebase/Design/RegisterTab.dart';

class Start extends StatefulWidget
{
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return new _Start();
  }

}

class _Start extends State<Start>
{
  Color _color = const Color(0xFF1D3575);


  var assetsImage=new AssetImage("assets/SALHLY.png");


  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return new  Scaffold(
      body: new Column(
        children: <Widget>[
          new Container(
            child: Image.asset('assets/SALHLY.png',width: 300.0,height: 150.0,),
            padding: EdgeInsets.only(top: 20.0,bottom: 10.0,left: 10.0,right: 10.0),
          ),
          new Container(
            alignment: Alignment.center,
            child: Image.asset("assets/first.png"),
          ),
          new Container(
             child: Padding(
               padding: const EdgeInsets.all(70.0),
               child: ButtonTheme(
                   minWidth: 370.0,
                   height: 40.0,
                   child: RaisedButton(
                     shape: new RoundedRectangleBorder(
                         borderRadius: new BorderRadius.circular(15.0)),
                     color:_color,
                          onPressed:(){
                            Navigator.push(context,
                            MaterialPageRoute(builder:(context)=>ServiceOwnerData()));
                  },
                  textColor: Colors.white,
                  child: Text(
                      'ابدأ',
                      style: TextStyle(fontSize: 20)
                  ),
                )),
             )
          )
        ],
      ),
    );
  }





/*


  ButtonTheme(
  minWidth: 400.0,
  height: 40.0,
  child: RaisedButton(
  shape: new RoundedRectangleBorder(
  borderRadius: new BorderRadius.circular(15.0)),
  child: Text("Log In"),

  color: _color,
  textColor: Colors.white,
  onPressed: () {
  if (_formKey.currentState.validate()) {
  _formKey.currentState.save();
  Business_owner_data();
  }
  })),
*/


}