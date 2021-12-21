import 'dart:io';
import 'package:admob_flutter/admob_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_native_admob/flutter_native_admob.dart';
import 'package:flutter_native_admob/native_admob_controller.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:imagetotext/models/adsServices.dart';
import 'package:imagetotext/models/drawer.dart';
import 'package:imagetotext/models/themeProvider.dart';
import 'package:imagetotext/screens/editorPage.dart';
import 'package:imagetotext/screens/imageDetails.dart';
import 'package:imagetotext/utils/colors.dart';
import 'package:imagetotext/utils/myIcons.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

class HomeScreen extends StatefulWidget {
  static const String idScreen = 'homeScreen';
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  var scaffoldKey = GlobalKey<ScaffoldState>();
  String translator = 'https://play.google.com/store/apps/details?id=com.haksstudio.translate';
  String rate = 'https://play.google.com/store/apps/details?id=com.haksstudio.imagetotext';


  // PickedFile _image;
  final picker = ImagePicker();
  var imagePath;
  File image;

  AdmobInterstitial interstitial;
  AdmobReward reward;

  fromGallery() async {
    final pickedFile = await picker.getImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      image = File(pickedFile.path);
      cropImage(image);
    }
  }

  fromCamera() async {
    final pickedFile = await picker.getImage(source: ImageSource.camera);
    if (pickedFile != null) {
      image = File(pickedFile.path);
      cropImage(image);
    }
  }

  // the function will return cropped image
  Future cropImage(File image) async {
    File croppedFile = await ImageCropper.cropImage(
      sourcePath: image.path,
      aspectRatioPresets: Platform.isAndroid
      ? [
      CropAspectRatioPreset.square,
      CropAspectRatioPreset.ratio3x2,
      CropAspectRatioPreset.original,
      CropAspectRatioPreset.ratio4x3,
      CropAspectRatioPreset.ratio16x9
      ]
      : [
      CropAspectRatioPreset.original,
      CropAspectRatioPreset.square,
      CropAspectRatioPreset.ratio3x2,
      CropAspectRatioPreset.ratio4x3,
      CropAspectRatioPreset.ratio5x3,
      CropAspectRatioPreset.ratio5x4,
      CropAspectRatioPreset.ratio7x5,
      CropAspectRatioPreset.ratio16x9
      ],
      androidUiSettings: AndroidUiSettings(
          activeControlsWidgetColor: Colors.black,
          backgroundColor: Colors.white,
          cropFrameColor: Colors.black,
          cropFrameStrokeWidth: 10,
          toolbarTitle: 'Crop Image',
          toolbarColor: Colors.black,
          toolbarWidgetColor: Colors.white,
          initAspectRatio: CropAspectRatioPreset.original,
          lockAspectRatio: false),
    );
    if (croppedFile != null) {

      setState(() async {
        imagePath = croppedFile.path;
        if(await interstitial.isLoaded ){
          interstitial.show();
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => ImageDetailsPage(imagePath),
            ),
          );
        }
        else {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => ImageDetailsPage(imagePath),
            ),
          );
        }

      });
    }
  }

  @override
  void initState(){
    interstitial = AdmobInterstitial(
        adUnitId: AdManager.interstitialId
    );
    interstitial.load();

    reward = AdmobReward(
        adUnitId: AdManager.rewardId,
        listener: (event, args) {
          if(event == AdmobAdEvent.loaded )
          {
            setState(() {
              reward.show();
            });
          }
        });
    reward.load();
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final themeProvider = Provider.of<ThemeProvider>(context);
    return Scaffold(
      key: scaffoldKey,
      appBar: AppBar(
        backgroundColor: darkBlue,
        elevation: 0,
        leading: IconButton(icon:
        Icon(
          Icons.menu_outlined,
          size: 30,
          color: white ,
        ),
            onPressed:(){
              scaffoldKey.currentState.openDrawer();
            } ),
        title: RichText(
          text: TextSpan(
              text: 'OCR ',
              style: GoogleFonts.pacifico(
                  color:  yellow,
                  fontSize: 24,
                  fontWeight: FontWeight.w800
              ),
              children: [
                TextSpan(
                  text: 'Scanner',
                  style: GoogleFonts.ubuntu(
                      color: lBG,
                      fontSize: 22,
                      fontWeight: FontWeight.w800
                  ),
                ),
              ]
          ),
        ),
        centerTitle: true,
      ),

      drawer: DrawerWidget(),

      body: SingleChildScrollView(
        child: Container(
          child: Column(
            children: [

              Padding(
                padding: EdgeInsets.only(left: 15, right: 15, top: 10, bottom: 10),
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(7),
                    color: themeProvider.isLightTheme? lCC : dCC,
                  ),
                  height: size.height/3.5,
                  child: NativeAdmob(
                    adUnitID: AdManager.nativeAdId,
                    numberAds: 3,
                    controller: NativeAdmobController(),
                    type: NativeAdmobType.full,
                  ),

                ),
              ),

              Padding(
                padding: EdgeInsets.only(top: 20, left: 20, right: 20),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        InkWell(
                          onTap: () {
                            fromCamera();
                          },
                          child: Container(
                            height: 150,
                            width: size.width / 2.4,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.only(
                                    bottomRight: Radius.circular(30),
                                    topLeft: Radius.circular(30)),
                              color: themeProvider.isLightTheme ? lCC : dCC,
                            ),
                            child: Center(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Icon(
                                    MyIcons.camera,
                                    size: 36,
                                    color: themeProvider.isLightTheme ? blueColor : yellow ,
                                  ),
                                  SizedBox(
                                    height: 5,
                                  ),
                                  Text(
                                    'Camera',
                                    style: GoogleFonts.ubuntu(
                                      color: themeProvider.isLightTheme ? blueColor : yellow,
                                      fontSize: 19,
                                        fontWeight: FontWeight.w800
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                        InkWell(
                          onTap: () {
                            fromGallery();
                          },
                          child: Container(
                            height: 150,
                            width: size.width / 2.4,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.only(
                                    bottomLeft: Radius.circular(30),
                                    topRight: Radius.circular(30)),
                              color: themeProvider.isLightTheme ? lCC : dCC,),
                            child: Center(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Icon(
                                    MyIcons.gallery,
                                    size: 36,
                                    color: themeProvider.isLightTheme ? blueColor : yellow,
                                  ),
                                  SizedBox(
                                    height: 5,
                                  ),
                                  Text(
                                    'Gallery',
                                    style: GoogleFonts.ubuntu(
                                      color: themeProvider.isLightTheme ? blueColor : yellow,
                                      fontSize: 19,
                                        fontWeight: FontWeight.w800
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        InkWell(
                          onTap: () async {
                           reward.show();
                           Navigator.push(context,
                               MaterialPageRoute (
                                   builder: (context) => EditorPage()
                               )
                           );
                          },
                          child: Container(
                            height: 150,
                            width: size.width / 2.4,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.only(
                                    topRight: Radius.circular(30),
                                    bottomLeft: Radius.circular(30)
                                ),
                              color: themeProvider.isLightTheme ? lCC : dCC,
                            ),
                            child: Center(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Icon(
                                    MyIcons.translator,
                                    size: 36,
                                    color: themeProvider.isLightTheme ? blueColor : yellow,
                                  ),
                                  SizedBox(
                                    height: 5,
                                  ),
                                  Text(
                                    'Translator',
                                    style: GoogleFonts.ubuntu(
                                      color: themeProvider.isLightTheme ? blueColor : yellow,
                                      fontSize: 19,
                                        fontWeight: FontWeight.w800
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),

                        InkWell(
                          onTap: () async {
                            if (await canLaunch(rate)) {
                              await launch(
                                rate,
                                forceSafariVC: false,
                                forceWebView: false,
                                headers: <String, String>{'my_header_key': 'my_header_value'},
                              );
                            } else {
                              throw 'Could not launch $rate';
                            }
                          },
                          child: Container(
                            height: 150,
                            width: size.width / 2.4,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(30),
                                bottomRight: Radius.circular(30),
                              ),
                              color: themeProvider.isLightTheme ? lCC : dCC,
                            ),
                            child: Center(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Icon(
                                    MyIcons.like,
                                    size: 36,
                                    color: themeProvider.isLightTheme ? blueColor : yellow,
                                  ),
                                  SizedBox(
                                    height: 5,
                                  ),
                                  Text(
                                    'Rate Us',
                                    style: GoogleFonts.ubuntu(
                                      color: themeProvider.isLightTheme ? blueColor : yellow,
                                      fontSize: 19,
                                      fontWeight: FontWeight.w800
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
      bottomNavigationBar: Container(
        height: 60,
        color: darkBlue,
        child: AdmobBanner(
          adUnitId: AdManager.bannerId,
          adSize:AdmobBannerSize.FULL_BANNER,
        ),
      ),
    );
  }
}
