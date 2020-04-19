import 'package:flutter/material.dart';
import 'package:sal7ly_firebase/global/Colors.dart' as myColors;
import 'package:sal7ly_firebase/screens/chat/Widgets/ChatListViewItem.dart';
import 'package:sal7ly_firebase/screens/chat/Widgets/Loading.dart';



class Chat extends StatefulWidget {
  @override
  _ChatState createState() => _ChatState();
}

class _ChatState extends State<Chat> {

  bool isLoading = true;


  @override
  void initState() {
    super.initState();

    Future.delayed(const Duration(seconds: 2), () {
      setState(() {
        isLoading = false;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    if (isLoading == true) {
      return Loading();
    } else {
      return Container(
        child: Scaffold(
          body: Container(
            child: Container(
              decoration: BoxDecoration(
                  color: myColors.backGround,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(15.0),
                    topRight: Radius.circular(15.0),
                  )),
              child: ListView(
                children: <Widget>[
                  ChatListViewItem(
                    hasUnreadMessage: true,
                    image: AssetImage('assets/images/person1.jpg'),
                    lastMessage:
                    "Lorem ipsum dolor sit amet. Sed pharetra ante a blandit ultrices.",
                    name: "Bree Jarvis",
                    newMesssageCount: 8,
                    time: "19:27 PM",
                  ),
                  ChatListViewItem(
                    hasUnreadMessage: true,
                    image: AssetImage('assets/images/person2.png'),
                    lastMessage:
                    "Lorem ipsum dolor sit amet. Sed pharetra ante a blandit ultrices.",
                    name: "Alex",
                    newMesssageCount: 5,
                    time: "19:27 PM",
                  ),
                  ChatListViewItem(
                    hasUnreadMessage: false,
                    image: AssetImage('assets/images/person3.jpg'),
                    lastMessage:
                    "Lorem ipsum dolor sit amet. Sed pharetra ante a blandit ultrices.",
                    name: "Carson Sinclair",
                    newMesssageCount: 0,
                    time: "19:27 PM",
                  ),
                  ChatListViewItem(
                    hasUnreadMessage: false,
                    image: AssetImage('assets/images/person4.png'),
                    lastMessage:
                    "Lorem ipsum dolor sit amet. Sed pharetra ante a blandit ultrices.",
                    name: "Lucian Guerra",
                    newMesssageCount: 0,
                    time: "19:27 PM",
                  ),
                  ChatListViewItem(
                    hasUnreadMessage: false,
                    image: AssetImage('assets/images/person5.jpg'),
                    lastMessage:
                    "Lorem ipsum dolor sit amet. Sed pharetra ante a blandit ultrices.",
                    name: "Sophia-Rose Bush",
                    newMesssageCount: 0,
                    time: "19:27 PM",
                  ),
                  ChatListViewItem(
                    hasUnreadMessage: false,
                    image: AssetImage('assets/images/person6.jpg'),
                    lastMessage:
                    "Lorem ipsum dolor sit amet. Sed pharetra ante a blandit ultrices.",
                    name: "Mohammad",
                    newMesssageCount: 0,
                    time: "19:27 PM",
                  ),
                  ChatListViewItem(
                    hasUnreadMessage: false,
                    image: AssetImage('assets/images/person7.jpg'),
                    lastMessage:
                    "Lorem ipsum dolor sit amet. Sed pharetra ante a blandit ultrices.",
                    name: "Jimi Cooke",
                    newMesssageCount: 0,
                    time: "19:27 PM",
                  ),
                ],
              ),
            ),
          ),
        ),
      );
    }
  }
}
