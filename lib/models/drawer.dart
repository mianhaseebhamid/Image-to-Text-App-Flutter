import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_share/flutter_share.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:imagetotext/models/themeProvider.dart';
import 'package:imagetotext/screens/themePage.dart';
import 'package:imagetotext/utils/colors.dart';
import 'package:imagetotext/utils/myIcons.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

class DrawerWidget extends StatefulWidget {

  @override
  _DrawerWidgetState createState() => _DrawerWidgetState();
}

class _DrawerWidgetState extends State<DrawerWidget> {

  String rateApp = 'http://play.google.com/store/apps/details?id=com.haksstudio.imagetotext';
  String moreApps = 'https://play.google.com/store/apps/dev?id=8834244566646861018';

  Future<void> share() async {
    await FlutterShare.share(
        title: 'Image to Text',
        text:
        'Hi I found the Best OCR Scanner App in Market with Advanced Features for free. Download it from the Given Link Below',
        linkUrl:
        'http://play.google.com/store/apps/details?id=com.haksstudio.imagetotext',
        chooserTitle: 'Share to');
  }

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    return Drawer(
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(bottom: 30),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 60),
              Center(
                child: RichText(
                  text: TextSpan(
                      text: 'OCR ',
                      style: GoogleFonts.pacifico(
                          color: themeProvider.isLightTheme ? blueColor : yellow,
                          fontSize: 28,
                          fontWeight: FontWeight.w800
                      ),
                      children: [
                        TextSpan(
                          text: ' Scanner',
                          style: GoogleFonts.ubuntu(
                              color: themeProvider.isLightTheme ? dBG : lBG,
                              fontSize: 25,
                              fontWeight: FontWeight.w800
                          ),
                        ),
                      ]
                  ),



                ),
              ),
              SizedBox(height: 40),
              Padding(
                padding: const EdgeInsets.only(left: 20, ),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text("Settings",
                          style: GoogleFonts.ubuntu(
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                              color: themeProvider.isLightTheme ? Colors.grey[900] :Colors.grey
                          ),),
                        Container(
                          width: 185,
                          height: 2.0,
                          color: themeProvider.isLightTheme ? Colors.grey[900] :Colors.grey,
                        )

                      ],
                    ),

                    SizedBox(height: 40,),

                    InkWell(
                      onTap: (){
                        Navigator.of(context).pop();
                      },
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Icon(
                            CupertinoIcons.house_fill,
                            color: themeProvider.isLightTheme ? blueColor :yellow,
                          ),
                          SizedBox(width: 15,),
                          Text("Home",
                            style: GoogleFonts.ubuntu(
                                fontSize: 18,
                                fontWeight: FontWeight.w500,
                                color: themeProvider.isLightTheme ? black :white
                            ),
                          ),

                        ],
                      ),
                    ),

                    SizedBox(height: 40,),

                    InkWell(
                      onTap:() async{
                        Navigator.push(context,
                            MaterialPageRoute(builder:
                                (context) => ThemePage()
                            )
                        );
                      },
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Icon(
                            CupertinoIcons.moon_fill,
                            color: themeProvider.isLightTheme ? blueColor :yellow,
                          ),
                          SizedBox(width: 15,),
                          Text("Select Theme",
                            style: GoogleFonts.ubuntu(
                                fontSize: 18,
                                fontWeight: FontWeight.w500,
                                color: themeProvider.isLightTheme ? black :white
                            ),
                          ),

                        ],
                      ),
                    ),

                    SizedBox(height: 40,),

                    InkWell(
                      onTap: (){
                        showAboutDialog(
                            context: context,
                            applicationIcon: CircleAvatar(
                              radius: 35,
                              backgroundColor: Colors.white,
                              child: Image.asset('assets/splash.png',
                                fit:BoxFit.fill,),
                            ),
                            applicationName: "OCR Scanner",
                            applicationVersion: "1.0.0",
                            applicationLegalese: "Free Mobile Application Software developed by HAKS Studio.",
                            children: [
                              SizedBox(height: 15,),
                              Text('OCR Scanner is a free software developed for daily usage for Scanning Texts from Images for Sharing Copying or Translating them into different languages ',
                                style: GoogleFonts.ubuntu(
                                    fontSize: 16
                                ),)
                            ]
                        );
                      },
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Icon(
                            MyIcons.about,
                            color: themeProvider.isLightTheme ? blueColor :yellow,
                          ),
                          SizedBox(width: 15,),
                          Text("About & Policy",
                            style: GoogleFonts.ubuntu(
                                fontSize: 18,
                                fontWeight: FontWeight.w500,
                                color: themeProvider.isLightTheme ? black :white
                            ),
                          ),

                        ],
                      ),
                    ),

                    SizedBox(height: 60,),

                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text("Support",
                          style: GoogleFonts.ubuntu(
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                              color: themeProvider.isLightTheme ? Colors.grey[900] :Colors.grey
                          ),),
                        Container(
                          width: 185,
                          height: 2.0,
                          color: themeProvider.isLightTheme ? Colors.grey[900] :Colors.grey,
                        )

                      ],
                    ),

                    SizedBox(height: 40,),

                    InkWell(
                      onTap:() async{
                        share();
                      },
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.mobile_screen_share_rounded,
                            color: themeProvider.isLightTheme ? blueColor :yellow,
                          ),
                          SizedBox(width: 15,),
                          Text("Share to Friends",
                            style: GoogleFonts.ubuntu(
                                fontSize: 18,
                                fontWeight: FontWeight.w500,
                                color: themeProvider.isLightTheme ? black :white
                            ),
                          ),

                        ],
                      ),
                    ),

                    SizedBox(height: 40,),

                    InkWell(
                      onTap: () async {
                        if (await canLaunch(rateApp)) {
                          await launch(
                            rateApp,
                            forceSafariVC: false,
                            forceWebView: false,
                            headers: <String, String>{'my_header_key': 'my_header_value'},
                          );
                        } else {
                          throw 'Could not launch $rateApp';
                        }
                      },

                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Icon(
                            MyIcons.rate,
                            color: themeProvider.isLightTheme ? blueColor :yellow,
                          ),
                          SizedBox(width: 15,),
                          Text("Rate Us",
                            style: GoogleFonts.ubuntu(
                                fontSize: 18,
                                fontWeight: FontWeight.w500,
                                color: themeProvider.isLightTheme ? black :white
                            ),),

                        ],
                      ),
                    ),

                    SizedBox(height: 40,),

                    InkWell(
                      onTap: () async {
                        if (await canLaunch(rateApp)) {
                          await launch(
                            rateApp,
                            forceSafariVC: false,
                            forceWebView: false,
                            headers: <String, String>{'my_header_key': 'my_header_value'},
                          );
                        } else {
                          throw 'Could not launch $rateApp';
                        }
                      },
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Icon(
                            MyIcons.update,
                            color: themeProvider.isLightTheme ? blueColor :yellow,
                          ),
                          SizedBox(width: 15,),
                          Text("Check Updates",
                            style: GoogleFonts.ubuntu(
                                fontSize: 18,
                                fontWeight: FontWeight.w500,
                                color: themeProvider.isLightTheme ? black :white
                            ),
                          ),

                        ],
                      ),
                    ),

                    SizedBox(height: 40,),

                    InkWell(
                      onTap: () async {
                        if (await canLaunch(moreApps)) {
                          await launch(
                            moreApps,
                            forceSafariVC: false,
                            forceWebView: false,
                            headers: <String, String>{'my_header_key': 'my_header_value'},
                          );
                        } else {
                          throw 'Could not launch $moreApps';
                        }
                      },
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Icon(
                            MyIcons.more,
                            color: themeProvider.isLightTheme ? blueColor :yellow,
                          ),
                          SizedBox(width: 15,),
                          Text("More Apps",
                            style: GoogleFonts.ubuntu(
                                fontSize: 18,
                                fontWeight: FontWeight.w500,
                                color: themeProvider.isLightTheme ? black :white
                            ),),

                        ],
                      ),
                    ),

                    SizedBox(height: 40,),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
