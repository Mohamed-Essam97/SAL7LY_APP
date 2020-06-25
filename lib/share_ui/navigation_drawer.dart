import 'package:flutter/material.dart';
import 'package:sal7ly_firebase/models/nav_menu.dart';
import 'package:sal7ly_firebase/global/Colors.dart' as myColors;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';

class NavigationDrawer extends StatefulWidget {
  @override
  _NavigationDrawerState createState() => _NavigationDrawerState();
}
final Color backgroundColor = Color(0xFF4A4A58);

class _NavigationDrawerState extends State<NavigationDrawer> with SingleTickerProviderStateMixin {

  String userId;

  @override
  Widget build(BuildContext context) {
    getUserId();
    return Drawer(
      child: Column(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: returnImage(),
          ),
          ListTile(
            leading: Icon(Icons.input),
            title: Text('Welcome'),
            onTap: () => {},
          ),
          ListTile(
            leading: Icon(Icons.verified_user),
            title: Text('Profile'),
            onTap: () => {Navigator.of(context).pop()},
          ),
          ListTile(
            leading: Icon(Icons.settings),
            title: Text('Settings'),
            onTap: () => {Navigator.of(context).pop()},
          ),
          ListTile(
            leading: Icon(Icons.border_color),
            title: Text('Feedback'),
            onTap: () => {Navigator.of(context).pop()},
          ),
          ListTile(
            leading: Icon(Icons.exit_to_app),
            title: Text('Logout'),
            onTap: () => {Navigator.of(context).pop()},
          ),
        ],
      ),
    );
  }
  Future<String> getUserId() async {
    FirebaseUser user = await FirebaseAuth.instance.currentUser();
    print(user.uid);
    userId = user.uid;
    return user.uid.toString();
  }


  Widget returnImage() {
    return StreamBuilder(
        stream: Firestore.instance
            .collection('service_owner')
            .document(userId)
            .snapshots(),
        builder: (context, snapshots) {
          if (!snapshots.hasData) {
            return Container(
              width: 110.0,
              height: 110.0,
              decoration: new BoxDecoration(
                shape: BoxShape.circle,
                image: new DecorationImage(
                  image: AssetImage('assets/first.png'),
                  fit: BoxFit.cover,
                ),
              ),
            );
          }
          var userDocument = snapshots.data;
          // ignore: missing_return
          return Container(
            width: 110.0,
            height: 110.0,
            decoration: new BoxDecoration(
              shape: BoxShape.circle,
              image: new DecorationImage(
                image: NetworkImage(userDocument["imageurl"].toString()),
                fit: BoxFit.cover,
              ),
            ),
          );
        });
  }

  }
