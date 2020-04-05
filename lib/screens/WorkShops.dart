import 'package:flutter/material.dart';
import 'package:sal7ly_firebase/screens/chat/Widgets/Loading.dart';

class Work_Shops extends StatefulWidget {
  @override
  _Work_ShopsState createState() => _Work_ShopsState();
}

class _Work_ShopsState extends State<Work_Shops> {

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
          body: ListView.builder(
            padding: EdgeInsets.all(8),
            itemBuilder: (context, position) {
              return Padding(
                padding: const EdgeInsets.only(bottom: 8),
                child: Card(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      _drawBody(),
                      _drawTitle(),
                      _drawHeader(),
                    ],
                  ),
                ),
              );
            },
            itemCount: 20,
          ),
        ),
      );
    }
  }
  Widget _drawHeader() {
    return Row(
      children: <Widget>[
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text(
                'Mechanical',
                style: TextStyle(color: Colors.grey),
              ),
            )
          ],
        ),
        SizedBox(
          width: 100,
        ),
        Row(
          children: <Widget>[
            IconButton(
                icon: Icon(Icons.star),
                color: Colors.grey.shade400,
                onPressed: () {}),
            Transform.translate(
              offset: Offset(-12, 0),
              child: Text(
                '4.5',
                style: TextStyle(color: Colors.grey, fontSize: 16),
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _drawTitle() {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8, left: 16, right: 16, top: 16),
      child: Text(
        'Al-Amana WorkShop ',
        style: TextStyle(color: Colors.grey.shade900,fontWeight: FontWeight.bold,fontSize: 15),
      ),
    );
  }

  Widget _drawHashTags() {
    return Container(
      child: Wrap(
        children: <Widget>[
          FlatButton(
              onPressed: () {},
              child: Text(
                '#advance',
              )),
          FlatButton(
              onPressed: () {},
              child: Text(
                '#retro',
              )),
          FlatButton(
              onPressed: () {},
              child: Text(
                '#instagram',
              )),
        ],
      ),
    );
  }

  Widget _drawBody() {
    return SizedBox(
      width: double.infinity,
      height: MediaQuery.of(context).size.height * 0.25,
      child: Image(
        image: ExactAssetImage('assets/first.png'),
        fit: BoxFit.cover,
      ),
    );
  }

  Widget _drawFooter() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        FlatButton(onPressed: () {}, child: Text('10 COMMENTS')),
        Row(
          children: <Widget>[
            FlatButton(onPressed: () {}, child: Text('SHARE')),
            FlatButton(onPressed: () {}, child: Text('OPEN')),
          ],
        )
      ],
    );
  }
}
