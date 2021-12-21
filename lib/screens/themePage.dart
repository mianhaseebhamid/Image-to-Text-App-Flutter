import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:imagetotext/models/themeProvider.dart';
import 'package:imagetotext/utils/animatedToggle.dart';
import 'package:imagetotext/utils/colors.dart';
import 'package:provider/provider.dart';

class ThemePage extends StatefulWidget {
  ThemePage({Key key}) : super(key: key);

  @override
  _ThemePageState createState() => _ThemePageState();
}

class _ThemePageState extends State<ThemePage>
    with SingleTickerProviderStateMixin {
  AnimationController _animationController;
  GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  @override
  void initState() {
    setState(() {
      _animationController =
          AnimationController(vsync: this, duration: Duration(milliseconds: 800));
    });
    super.initState();
  }

  // function to toggle circle animation
  changeThemeMode(bool theme) {
    if (!theme) {
      _animationController.forward(from: 0.0);
    } else {
      _animationController.reverse(from: 1.0);
    }
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    // Now we have access to the theme properties
    final themeProvider = Provider.of<ThemeProvider>(context);
    return Scaffold(
      key: _scaffoldKey,
      body: SafeArea(
        child: Container(
          alignment: Alignment.center,
          margin: EdgeInsets.only(top: height * 0.1),
          child: Column(
            children: [
              Icon(
                themeProvider.isLightTheme ?
                Icons.wb_sunny_rounded: CupertinoIcons.moon_fill ,
                size: 180,
                color: themeProvider.isLightTheme ? blueColor : yellow,
              ),

              SizedBox(height: height * 0.05),
              Text(
                'Choose a style',
                style: GoogleFonts.ubuntu(
                    fontSize: width * .1,
                    fontWeight: FontWeight.bold),
              ),
              SizedBox(height: height * 0.03),
              Container(
                width: width * .6,
                child: Text(
                  'We highly recommend you to use dark Mode. It will give relief to your Eyes and Battery. ',
                  style: GoogleFonts.ubuntu(
                    fontSize: 18
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
              SizedBox(height: height * 0.1),
              ZAnimatedToggle(
                values: ['Light', 'Dark'],
                onToggleCallback: (v) async {
                  await themeProvider.toggleThemeData();
                  setState(() {});
                  changeThemeMode(themeProvider.isLightTheme);
                },
              ),
              SizedBox(
                height: height * .05,
              ),
              // skip & next
              Expanded(
                child: Container(
                  margin: EdgeInsets.symmetric(
                      vertical: height * 0.02, horizontal: width * 0.04),
                  alignment: Alignment.bottomCenter,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      RaisedButton(
                        onPressed: () {
                          Navigator.pop(context, true);
                        },
                        shape: CircleBorder(),
                        color: themeProvider.isLightTheme
                            ? const Color(0xFFFFFFFF)
                            : const Color(0xFF35303f),
                        child: Padding(
                          padding: EdgeInsets.all(width * 0.05),
                          child: Icon(
                            Icons.arrow_back,
                            color: themeProvider.isLightTheme
                                ? const Color(0xFF000000)
                                : const Color(0xFFFFFFFF),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
