import 'package:flutter/material.dart';
import 'package:sal7ly_firebase/share_ui/navigation_drawer.dart';

class Home_Screen_Main extends StatefulWidget {
  @override
  _Home_Screen_MainState createState() => _Home_Screen_MainState();
}
Color _color = const Color(0xDDBE1D2D);

class _Home_Screen_MainState extends State<Home_Screen_Main> {

  Color _color = const Color(0xDDBE1D2D);

  Color _colorBlack = const Color(0xFF2E2E2E);

  int _selectedIndex = 0;
  static const TextStyle optionStyle = TextStyle(fontSize: 30, fontWeight: FontWeight.bold);
  static const List<Widget> _widgetOptions = <Widget>[
    Text(
      'Index 0: Home',
      style: optionStyle,
    ),
    Text(
      'Index 1: Business',
      style: optionStyle,
    ),
    Text(
      'Index 2: School',
      style: optionStyle,
    ),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor:_color ,
        centerTitle: false,
        actions: <Widget>[
          ],
      ),
      drawer: NavigationDrawer(),
      body: Center(
        child: _widgetOptions.elementAt(_selectedIndex),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            title: Text('Home'),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.business),
            title: Text('Business'),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.school),
            title: Text('School'),
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: _color,
        onTap: _onItemTapped,
      ),
    );
  }
}
