import 'dart:async';
import 'dart:io';
import 'dart:ui';
import 'package:admob_flutter/admob_flutter.dart';
import 'package:firebase_ml_vision/firebase_ml_vision.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:imagetotext/models/adsServices.dart';
import 'package:imagetotext/models/themeProvider.dart';
import 'package:imagetotext/screens/editorPage.dart';
import 'package:imagetotext/utils/colors.dart';
import 'package:imagetotext/utils/myIcons.dart';
import 'package:provider/provider.dart';

class ImageDetailsPage extends StatefulWidget {
  final String imagePath;
  ImageDetailsPage(this.imagePath);

  @override
  _ImageDetailsPageState createState() => _ImageDetailsPageState(imagePath);
}

class _ImageDetailsPageState extends State<ImageDetailsPage> {
  _ImageDetailsPageState(this.path);

  final String path;

  Size _imageSize;
  String recognizedText = "Loading ...";
  String onlymailText = "";
  String allText = '';
  File image;
  AdmobInterstitial interstitial;

  Future getImage() async {

    final File imageFile = File(path);
    if (imageFile != null)  {
      await _getImageSize(imageFile);
      setState(() {
        image = imageFile;
      });
    }

  }

  Future scanImage() async {

    if(image != null) {
      final FirebaseVisionImage visionImage =
      FirebaseVisionImage.fromFile(image);

      final TextRecognizer textRecognizer =
      FirebaseVision.instance.textRecognizer();

      final VisionText visionText =
      await textRecognizer.processImage(visionImage);

      for (TextBlock block in visionText.blocks) {
        for (TextLine line in block.lines) {
          allText += line.text;
        }
      }

      if(await interstitial.isLoaded){
        interstitial.show();
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => EditorPage(
                  textFromImage: allText,
                )
            )
        );
      }

      else{
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => EditorPage(
                  textFromImage: allText,
                )
            )
        );
      }

    }

  }

  Future<void> _getImageSize(File imageFile) async {
    final Completer<Size> completer = Completer<Size>();

    // Fetching image from path
    final Image image = Image.file(imageFile);

    // Retrieving its size
    image.image.resolve(const ImageConfiguration()).addListener(
      ImageStreamListener((ImageInfo info, bool _) {
        completer.complete(Size(
          info.image.width.toDouble(),
          info.image.height.toDouble(),
        ));
      }),
    );
    final Size imageSize = await completer.future;
    setState(() {
      _imageSize = imageSize;
    });
  }

@override
  void initState(){
    getImage();
    interstitial = AdmobInterstitial(adUnitId: AdManager.interstitialId);
    interstitial.load();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    return Scaffold(

      appBar: AppBar(
        backgroundColor: darkBlue,
        elevation: 1,
        centerTitle: true,
        leading: IconButton(
          onPressed: (){
            Navigator.pop(context, true);
          },
          icon: Icon(Icons.arrow_back,
          color: Colors.white,
          ),
        ),

        title: RichText(
          text: TextSpan(
              text: 'I',
              style: GoogleFonts.pacifico(
                  color:  yellow,
                  fontSize: 24,
                  fontWeight: FontWeight.w800
              ),
              children: [
                TextSpan(
                  text: 'mage ',
                  style: GoogleFonts.ubuntu(
                      color: lBG,
                      fontSize: 22,
                      fontWeight: FontWeight.w800
                  ),
                ),
                TextSpan(
                    text: 'T',
                    style: GoogleFonts.pacifico(
                        color:  yellow,
                        fontSize: 24,
                        fontWeight: FontWeight.w800
                    )
                ),
                TextSpan(
                  text: 'o ',
                  style: GoogleFonts.ubuntu(
                      color: lBG,
                      fontSize: 22,
                      fontWeight: FontWeight.w800
                  ),
                ),
                TextSpan(
                    text: 'T',
                    style: GoogleFonts.pacifico(
                        color:  yellow,
                        fontSize: 24,
                        fontWeight: FontWeight.w800
                    )
                ),
                TextSpan(
                  text: 'ext ',
                  style: GoogleFonts.ubuntu(
                      color: lBG,
                      fontSize: 22,
                      fontWeight: FontWeight.w800
                  ),
                ),
              ]
          ),
        ),
      ),

      body: _imageSize != null
          ? Stack(
        children: <Widget>[
          Center(
            child: Container(
              width: double.maxFinite,
              color: Colors.black,
              child: AspectRatio(
                aspectRatio: _imageSize.aspectRatio,
                child: Image.file(
                  File(path),
                ),
              ),
            ),
          ),

          Align(
            alignment: Alignment.bottomCenter,
            child: Padding(
              padding: EdgeInsets.all(15.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Container(
                    padding: const EdgeInsets.only(bottom: 8.0),
                    width: 200,
                    child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          primary: themeProvider.isLightTheme ? blueColor : yellow,
                          padding: EdgeInsets.fromLTRB(5, 15, 5, 15),
                          shape: new RoundedRectangleBorder(
                            borderRadius: new BorderRadius.circular(20.0),
                          ),
                        ),
                        onPressed: () {
                          scanImage();
                        },
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              MyIcons.scan
                            ),
                            SizedBox(width: 10,),
                            Text(
                              "Scan Text",
                              style: GoogleFonts.ubuntu(
                                  fontSize: 28,
                                fontWeight: FontWeight.w800
                              ),
                            ),
                          ],
                        )
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      )
          : Container(
        child: Center(
          child: SpinKitFoldingCube(
            color: blueColor,
            size: 80,
          ),
        ),
      ),
    );
  }
}
