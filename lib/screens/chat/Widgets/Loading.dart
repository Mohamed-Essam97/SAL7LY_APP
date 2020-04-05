import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';
import 'package:sal7ly_firebase/screens/chat/global/Colors.dart' as myColors;

class Loading extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Shimmer.fromColors(
              baseColor:myColors.red ,
              highlightColor:myColors.blue,
              child: Text(
                'SAL7LY',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 40.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Text("Please wait...")
          ],
        ),
      ),
    );
  }
}