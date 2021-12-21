import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:imagetotext/models/themeProvider.dart';
import 'package:imagetotext/utils/colors.dart';
import 'package:imagetotext/utils/myIcons.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';


class NoInternetBox extends StatefulWidget {

  @override
  _NoInternetBoxState createState() => _NoInternetBoxState();
}

class _NoInternetBoxState extends State<NoInternetBox> {
  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(Constants.padding),
      ),
      elevation: 0,
      backgroundColor: Colors.transparent,
      child: contentBox(context),
    );
  }
  contentBox(context){
    final themeProvider = Provider.of<ThemeProvider>(context);
    return Stack(
      children: <Widget>[
        Container(
          padding: EdgeInsets.only(left: Constants.padding,top: Constants.avatarRadius
              + Constants.padding, right: Constants.padding,bottom: Constants.padding
          ),
          margin: EdgeInsets.only(top: Constants.avatarRadius),
          decoration: BoxDecoration(
              shape: BoxShape.rectangle,
              color: themeProvider.isLightTheme ? white : darkBlue,
              borderRadius: BorderRadius.circular(Constants.padding),
              boxShadow: [
                BoxShadow(color: Colors.black,offset: Offset(0,10),
                    blurRadius: 10
                ),
              ]
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Container(
                height: 250,
                child: Lottie.asset("assets/noInternet.json", ),
              ),
              SizedBox(height: 20,),
              Text("No Internet !!!",
                style: GoogleFonts.ubuntu(
                    fontSize: 23,
                    fontWeight: FontWeight.w600,
                  color: themeProvider.isLightTheme ? Colors.redAccent : Colors.amberAccent,
                ),
              ),
              SizedBox(height: 10,),
              Align(
                alignment: Alignment.bottomRight,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      primary: themeProvider.isLightTheme ? blueColor : yellow,),
                    onPressed: (){
                      Navigator.of(context).pop();
                    },
                    child: Padding(
                      padding: const EdgeInsets.only(left: 8, right: 8),
                      child: Text("Retry",
                        style: GoogleFonts.ubuntu(
                            fontSize: 18,
                          color: themeProvider.isLightTheme ? white : black,
                        ),
                      ),
                    )
                ),
              ),
              SizedBox(height: 5,),
            ],
          ),
        ),
        Positioned(
          left: Constants.padding,
          right: Constants.padding,
          child: CircleAvatar(
            backgroundColor: themeProvider.isLightTheme ? blueColor : yellow,
            radius: Constants.avatarRadius,
            child: Icon(
              MyIcons.translator, size: 45,
              color: themeProvider.isLightTheme ? white : black,
            )

            // ClipRRect(
            //     borderRadius: BorderRadius.all(Radius.circular(Constants.avatarRadius)),
            //
            // ),
          ),
        ),
      ],
    );
  }
}