import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:sal7ly_firebase/firebase_login/services/usermanagment.dart';
import 'package:sal7ly_firebase/screens/add_Service.dart';
import 'package:sal7ly_firebase/share_ui/navigation_drawer.dart';
import 'package:sal7ly_firebase/screens/chat.dart';
import 'package:sal7ly_firebase/screens/profile.dart';
import 'package:sal7ly_firebase/screens/search.dart';
import 'package:sal7ly_firebase/screens/WorkShops.dart';
import 'package:sal7ly_firebase/screens/chat/global/Colors.dart' as myColors;


class Home_Screen_Main extends StatefulWidget {
  @override
  _Home_Screen_MainState createState() => _Home_Screen_MainState();
}
Color _color = const Color(0xDDBE1D2D);

class _Home_Screen_MainState extends State<Home_Screen_Main> {

  Color _color = const Color(0xDDBE1D2D);

  Color _colorBlack = Colors.grey;



  int currentTab = 0; // to keep track of active tab index
  final List<Widget> screens = [
    Work_Shops(),
    Chat(),
    Profile(),
    Search(),
  ]; // to store nested tabs
  final PageStorageBucket bucket = PageStorageBucket();
  Widget currentScreen = Work_Shops(); // Our first view in viewport





  @override
  Widget build(BuildContext context) {



    return Scaffold(
      appBar: AppBar(
        title: Text("SAL7LY",style: TextStyle(fontSize: 30,fontWeight: FontWeight.bold),),
        backgroundColor:myColors.red[900] ,
        centerTitle: true,
        actions: <Widget>[
          ],
      ),
      drawer: NavigationDrawer(),
      body: PageStorage(
        child: currentScreen,
        bucket: bucket,
      ),
        floatingActionButton: FloatingActionButton(
          child: Icon(Icons.add),
          backgroundColor: Colors.green ,
          onPressed: () {
            Navigator.pushNamed(context, '/AddService');
          },
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        bottomNavigationBar: BottomAppBar(
          shape: CircularNotchedRectangle(),
          notchMargin: 10,
          child: Container(
            height: 60,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    MaterialButton(
                      minWidth: 40,
                      onPressed: () {
                        setState(() {
                          currentScreen =
                              Work_Shops(); // if user taps on this dashboard tab will be active
                          currentTab = 0;
                        });
                      },
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Icon(
                            Icons.dashboard,
                            color: currentTab == 0 ? _color : _colorBlack,
                          ),
                          Text(
                            'Work Shops',
                            style: TextStyle(
                              color: currentTab == 0 ?  _color : _colorBlack,
                            ),
                          ),
                        ],
                      ),
                    ),
                    MaterialButton(
                      minWidth: 40,
                      onPressed: () {
                        setState(() {
                          currentScreen =
                              Search(); // if user taps on this dashboard tab will be active
                          currentTab = 1;
                        });
                      },
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Icon(
                            Icons.search,
                            color: currentTab == 1 ?  _color : _colorBlack,
                          ),
                          Text(
                            'Search',
                            style: TextStyle(
                              color: currentTab == 1 ?  _color : _colorBlack,
                            ),
                          ),
                        ],
                      ),
                    )
                  ],
                ),

                // Right Tab bar icons

                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    MaterialButton(
                      minWidth: 40,
                      onPressed: () {
                        setState(() {
                          currentScreen =
                              Chat(); // if user taps on this dashboard tab will be active
                          currentTab = 2;
                        });
                      },
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Icon(
                            Icons.chat,
                            color: currentTab == 2 ?  _color : _colorBlack,
                          ),
                          Text(
                            'Chats',
                            style: TextStyle(
                              color: currentTab == 2 ?  _color : _colorBlack,
                            ),
                          ),
                        ],
                      ),
                    ),
                    MaterialButton(
                      minWidth: 40,
                      onPressed: () {
                        setState(() {
                          currentScreen =
                              Profile(); // if user taps on this dashboard tab will be active
                          currentTab = 3;
                        });
                      },
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Icon(
                            Icons.person,
                            color: currentTab == 3 ?  _color : _colorBlack,
                          ),
                          Text(
                            'Profile',
                            style: TextStyle(
                              color: currentTab == 3 ?  _color : _colorBlack,
                            ),
                          ),
                        ],
                      ),
                    )
                  ],
                )

              ],
            ),
          ),
        ),
    );
  }



  someMethod() async {
    FirebaseUser user = await FirebaseAuth.instance.currentUser();
    print(user.uid);
    }


}
