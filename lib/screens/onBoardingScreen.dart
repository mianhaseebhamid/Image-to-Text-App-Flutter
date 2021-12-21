import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:imagetotext/screens/homeScreen.dart';
import 'package:imagetotext/utils/colors.dart';
import 'package:imagetotext/utils/myIcons.dart';

class OnBoardingScreen extends StatefulWidget {
  static const String idScreen = 'onBoardingScreen';

  @override
  _OnBoardingScreenState createState() => _OnBoardingScreenState();
}

class _OnBoardingScreenState extends State<OnBoardingScreen> {
  final int _numPages = 3;
  var _pageController = PageController(initialPage: 0, keepPage: false);
  int _currentPage = 0;
  var controller;

  List<Widget> _buildPageIndicator() {
    List<Widget> list = [];
    for (int i = 0; i < _numPages; i++) {
      list.add(i == _currentPage ? _indicator(true) : _indicator(false));
    }
    return list;
  }

  Widget _indicator(bool isActive) {
    return AnimatedContainer(
      duration: Duration(milliseconds: 150),
      margin: EdgeInsets.symmetric(horizontal: 8.0),
      height: 10,
      width: isActive ? 40 : 10,
      decoration: BoxDecoration(
        color: isActive ? darkBlue : blueColor,
        borderRadius: BorderRadius.all(Radius.circular(50)),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    controller = _pageController.toString();
    return Scaffold(
      body: AnnotatedRegion<SystemUiOverlayStyle>(
        value: SystemUiOverlayStyle.light,
        child: Container(
          color: Colors.white,
          child: Padding(
            padding: EdgeInsets.symmetric(vertical: 40.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                Container(
                  alignment: Alignment.centerRight,
                ),
                Container(
                  height: 600.0,
                  child: PageView(
                    physics: ClampingScrollPhysics(),
                    controller: _pageController,
                    onPageChanged: (int page) {
                      setState(() {
                        _currentPage = page;
                      });
                    },
                    children: <Widget>[
                      Padding(
                        padding: EdgeInsets.only(top:20, left: 40, right: 40, bottom: 40
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: <Widget>[
                            Center(
                              child: Text("Scan",
                              style: GoogleFonts.ubuntu(
                                fontSize: 30,
                                fontWeight: FontWeight.w700
                              ),),
                            ),
                            SizedBox(height: 5,),
                            Center(
                              child: Text("Select & Scan Any type of Image",
                                style: GoogleFonts.ubuntu(
                                    fontSize: 16,
                                ),),
                            ),
                            SizedBox(height: 50,),
                            Center(
                              child: Icon(
                                MyIcons.scan,
                                size: 250,
                                color: darkBlue,
                              ),
                            ),
                          ],
                        ),
                      ),

                      Padding(
                        padding: EdgeInsets.only(top:20, left: 40, right: 40, bottom: 40
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: <Widget>[
                            Center(
                              child: Text("OCR",
                                style: GoogleFonts.ubuntu(
                                    fontSize: 30,
                                    fontWeight: FontWeight.w700
                                ),),
                            ),
                            SizedBox(height: 5,),
                            Center(
                              child: Text("Detect Text from Scanned Image",
                                style: GoogleFonts.ubuntu(
                                  fontSize: 16,
                                ),),
                            ),
                            SizedBox(height: 50,),
                            Center(
                              child: Icon(
                                MyIcons.ocr,
                                size: 250,
                                color: darkBlue,
                              ),
                            ),
                          ],
                        ),
                      ),

                      Padding(
                        padding: EdgeInsets.only(top:20, left: 40, right: 40, bottom: 40
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: <Widget>[
                            Center(
                              child: Text("Share",
                                style: GoogleFonts.ubuntu(
                                    fontSize: 30,
                                    fontWeight: FontWeight.w700
                                ),),
                            ),
                            SizedBox(height: 5,),
                            Center(
                              child: Text("Save & Share Detected Text",
                                style: GoogleFonts.ubuntu(
                                  fontSize: 16,
                                ),),
                            ),
                            SizedBox(height: 50,),
                            Center(
                              child: Icon(
                                MyIcons.share,
                                size: 250,
                                color: darkBlue,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: _buildPageIndicator(),
                ),
                _currentPage != _numPages - 1
                    ? Expanded(
                  child: Align(
                    alignment: FractionalOffset.bottomRight,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        TextButton(
                          onPressed: () {
                            _pageController.animateToPage(2, duration: Duration(milliseconds: 500),
                              curve: Curves.ease,);
                          },
                          child: Text('Skip',
                              style: GoogleFonts.ubuntu(
                                  color:darkBlue,
                                  fontSize: 17,
                                  fontWeight: FontWeight.w500
                              )
                          ),
                        ),
                        TextButton(
                          onPressed: () {
                            _pageController.nextPage(
                              duration: Duration(milliseconds: 500),
                              curve: Curves.ease,
                            );
                          },
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            mainAxisSize: MainAxisSize.min,
                            children: <Widget>[
                              Text('Next',
                                  style: GoogleFonts.ubuntu(
                                      color: darkBlue,
                                      fontSize: 17,
                                      fontWeight: FontWeight.w500
                                  )),
                              SizedBox(width: 10.0),
                              Icon(
                                Icons.arrow_forward,
                                color: darkBlue,
                                size: 22,
                              ),
                              SizedBox(width: 10.0),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                )
                    : Text(''),
              ],
            ),
          ),
        ),
      ),
      bottomSheet: _currentPage == _numPages - 1
          ? Container(
        height: 70.0,
        width: double.infinity,
        decoration: BoxDecoration(
            color: darkBlue,
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(30),
                topRight: Radius.circular(30)
            )

        ),
        child: GestureDetector(
          onTap: () {
            Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(builder: (context) => HomeScreen()),
                    (route) => false);
          },
          child: Center(
            child: Text(
              'Get Started',
              textAlign: TextAlign.center,
              style: GoogleFonts.ubuntu(
                color: Colors.white,
                fontWeight: FontWeight.w500,
                fontSize: 20,
              ),
            ),
          ),
        ),
      )
          : Text(''),
    );
  }
}
