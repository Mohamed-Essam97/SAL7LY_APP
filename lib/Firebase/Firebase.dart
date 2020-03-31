
import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:firebase_messaging/firebase_messaging.dart';



class MyHomePage extends StatefulWidget {

  @override
  _MyHomePageState createState() => new _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  var mymap = {};
  var title = '';
  var body = {};
  var mytoken = '';

  FirebaseMessaging firebaseMessaging = new FirebaseMessaging();
  FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
  new FlutterLocalNotificationsPlugin();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    var android = new AndroidInitializationSettings('mipmap/ic_launcher');
    var ios = new IOSInitializationSettings();
    var platform = new InitializationSettings(android, ios);
    flutterLocalNotificationsPlugin.initialize(platform);

    firebaseMessaging.configure(
        onLaunch: (Map<String , dynamic> msg){
          print("onLaunch called ${(msg)}");
        },
        onResume: (Map<String , dynamic> msg){
          print("onResume called ${(msg)}");
        },
        onMessage:  (Map<String , dynamic> msg){
          print("onResume called ${(msg)}");
          mymap = msg;
          showNotification(msg);
        }
    );

    firebaseMessaging.requestNotificationPermissions(
        const IosNotificationSettings(sound: true , alert: true ,badge: true));
    firebaseMessaging.onIosSettingsRegistered
        .listen((IosNotificationSettings setting){
      print("onIosSettingsRegistered");
    });
    firebaseMessaging.getToken().then((token){
      update(token);
    });

  }



  showNotification(Map<String , dynamic> msg) async{
    var android = new AndroidNotificationDetails(
        "1", "channelName", "channelDescription");
    var iOS = new IOSNotificationDetails();
    var platform = new NotificationDetails(android,iOS);

    msg.forEach((k,v){
      title = k;
      body = v;
      setState(() {

      });
    });

    await flutterLocalNotificationsPlugin.show(0, " ${body.keys}", "  ${body.values}", platform);

  }


  update(String token ){
    print(token);
    DatabaseReference databaseReference = new FirebaseDatabase().reference();
    databaseReference.child('fcm-token/$token').set({"token":token});
    mytoken = token;
    setState(() {

    });
  }

  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      home: new Scaffold(
        appBar: new AppBar(
          backgroundColor: Colors.deepPurpleAccent,
          title: new Text('Messeging App'),
        ),
        body: new Center(
          child: new Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              new Text(
                'You have pushed the button this many times:',
              ),
              new Text(
                '$mytoken',
                style: Theme.of(context).textTheme.display1,
              ),
            ],
          ),
        ),
        floatingActionButton: new FloatingActionButton(
          onPressed: (){},
          tooltip: 'Increment',
          child: new Icon(Icons.add),
        ),
      ),
    );
  }
}

/*
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
class Firebase extends StatelessWidget
{
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return new StreamBuilder(
        stream: Firestore.instance.collection('service_owner').document('pMhSEYGh7MakLR6xfR6t').snapshots(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return new Text("Loading",
              textDirection: TextDirection.ltr,
              textAlign:TextAlign.center,
            );
          }
          var userDocument = snapshot.data;
          return new Text (userDocument ["name"], textDirection: TextDirection.ltr,textAlign: TextAlign.center,);
        }
    );
  }

}
*/
