import 'package:flutter/material.dart';
import 'package:sal7ly_firebase/firebase_login/home.dart';
import 'package:sal7ly_firebase/firebase_login/loginpage.dart';
import 'package:sal7ly_firebase/models/onboarding_model.dart';
import 'package:page_view_indicator/page_view_indicator.dart';
import 'package:sal7ly_firebase/screens/Welcome.dart';
import 'package:shared_preferences/shared_preferences.dart';


class OnBoarding extends StatefulWidget {
  @override
  _OnBoardingState createState() => _OnBoardingState();
}

class _OnBoardingState extends State<OnBoarding> {
  List<PageModel> pages;

  ValueNotifier<int> _PageViewNotifier = ValueNotifier(0);

  void _addPages()
  {
    pages = List<PageModel>();
    pages.add(PageModel(
      'Welcome',
      '1 = Making Friends is easy waving your hand back and forth in easy step ',
      'assets/onBoarding/first.png',
    ));
    pages.add(PageModel(
      'Camera',
      '2 = Making Friends is easy waving your hand back and forth in easy step ',
      'assets/onBoarding/second.png',
    ));
    pages.add(PageModel(
      'Favorite',
      '3 = Making Friends is easy waving your hand back and forth in easy step ',
      'assets/onBoarding/first.png',
    ));
    }


  int currentIndex = 0;



  Color _color = const Color(0xDDBE1D2D);


  @override
  Widget build(BuildContext context) {


    Color _color = const Color(0xDDBE1D2D);

    Color _colorBlack = const Color(0xFF2E2E2E);


    _addPages();

    return  Stack(
      children: <Widget>[
        Scaffold(
          body: PageView.builder(
            itemBuilder: (context, index) {
              return Stack(
                children: <Widget>[
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Transform.translate(
                        offset: Offset(0, -50),
                        child: SizedBox(
                          child: Container(
                            decoration: BoxDecoration(
                              image: DecorationImage(
                                  image: ExactAssetImage(
                                      pages[index].image
                                  ),
                                  ),
                            ),
                          ),
                          width:400,
                          height: 400,
                        ),
                      ),
                      Transform.translate(
                        offset: Offset(0, -100 ),
                        child: Text(
                          pages[index].title,
                          style: TextStyle(
                            color: _colorBlack,
                            fontSize: 28,
                              fontWeight: FontWeight.bold,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                      Transform.translate(
                        offset: Offset(0, -100 ),
                        child: Padding(
                          padding:
                          const EdgeInsets.only(left: 48, right: 48, top: 18),
                          child: Text(
                            pages[index].description,
                            style: TextStyle(
                              color: _colorBlack,
                              fontSize: 16,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ),
                    ],
                  )
                ],
              );
            },
            itemCount: pages.length, //عدد الصفحات
            onPageChanged:(index){
              _PageViewNotifier.value = index;
            },
          ),
        ),
        Transform.translate(
          offset: Offset(0, 200 ),
          child: Align(
            alignment: Alignment.center,
            child: _drawCircle(pages.length),
          ),
        ),
        Transform.translate(
          offset: Offset(0, -50 ),
          child: Align(
            alignment: Alignment.bottomCenter,
            child: Padding(
              padding: const EdgeInsets.only(bottom: 24.0, right: 16, left: 16),
              child: SizedBox(
                width: double.infinity,
                height: 50,
                child: RaisedButton(
                  color: _color,
                  child: Text(
                    'GET STARTED',
                    style: TextStyle(
                        color: Colors.white, fontSize: 16, letterSpacing: 1),
                  ),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) {

                          _updateSeen();
                          //TODO: Update Seen
                          return LoginPage();
                        },
                      ),
                    );
                  },
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _drawCircle(int length)
  {
    return PageViewIndicator(
      pageIndexNotifier: _PageViewNotifier,
      length: length,
      normalBuilder: (animationController, index) => Circle(
        size: 8.0,
        color: Colors.grey,
      ),
      highlightedBuilder: (animationController, index) => ScaleTransition(
        scale: CurvedAnimation(
          parent: animationController,
          curve: Curves.ease,
        ),
        child: Circle(
          size: 12.0,
          color: _color,
        ),
      ),
    );
  }

  void _updateSeen() async
  {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool('seen', true);
  }
}



