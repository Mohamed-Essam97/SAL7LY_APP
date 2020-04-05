import 'package:flutter/material.dart';
import 'package:sal7ly_firebase/models/nav_menu.dart';
import 'package:sal7ly_firebase/screens/chat/global/Colors.dart' as myColors;


class NavigationDrawer extends StatefulWidget {
  @override
  _NavigationDrawerState createState() => _NavigationDrawerState();
}

class _NavigationDrawerState extends State<NavigationDrawer> {


  List<NavMenuItem> navigationMenu =
  [

    NavMenuItem("Home", () => (){}),
    NavMenuItem("Gad3ana", () => (){}),
    NavMenuItem("Settings", () => (){}),
    NavMenuItem("About App", () => (){}),
  ];

  List<Icon> icons =
  [
    Icon(Icons.home,color:myColors.red[900] ),
    Icon(Icons.time_to_leave,color:myColors.red[900] ),
    Icon(Icons.settings,color:myColors.red[900] ,),
    Icon(Icons.accessibility,color:myColors.red[900] ),
  ];


  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Padding(
        padding: EdgeInsets.only(top: 75, left: 32),
        child: ListView.builder(
          itemBuilder: (context, position) {
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: ListTile(
                leading: icons[position],
                title: Text(
                  navigationMenu[position].title,
                  style: TextStyle(color: Colors.grey.shade700, fontSize: 22),
                ),
                trailing: Icon(
                  Icons.chevron_right,
                  color: Colors.grey.shade400,
                ),
                onTap: () {
                  Navigator.pop(context);
                  Navigator.push(context, MaterialPageRoute(builder: (context){
                    return navigationMenu[position].destination();
                  }));


                },
              ),
            );
          },
          itemCount: navigationMenu.length,
        ),
      ),
    );
  }
}
