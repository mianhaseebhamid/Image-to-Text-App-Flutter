import 'package:admob_flutter/admob_flutter.dart';
import 'package:clipboard/clipboard.dart';
import 'package:connectivity/connectivity.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_native_admob/flutter_native_admob.dart';
import 'package:flutter_native_admob/native_admob_controller.dart';
import 'package:flutter_share/flutter_share.dart';
import 'package:flutter_text_to_speech/flutter_text_to_speech.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:imagetotext/utils/colors.dart';
import 'package:imagetotext/models/adsServices.dart';
import 'package:imagetotext/models/language.dart';
import 'package:imagetotext/models/themeProvider.dart';
import 'package:imagetotext/utils/noInternetBox.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:provider/provider.dart';
import 'package:translator/translator.dart';

class EditorPage extends StatefulWidget {

  final textFromImage;
  EditorPage ({
    this.textFromImage
  });

  @override
  _EditorPageState createState() => _EditorPageState();

}

class _EditorPageState extends State<EditorPage> {

  TextEditingController input = TextEditingController();

  Language _firstLang = Language('auto', 'Detect');
  Language _secondLang = Language('es', 'Spanish');

  final translator = GoogleTranslator();
  FocusNode focusNode = FocusNode();

  var output;

  AdmobInterstitial interstitial;
  AdmobReward reward;

  FlutterTts textToSpeech = FlutterTts();
  VoiceController controller = FlutterTextToSpeech.instance.voiceController();

  var _langName = ['Detect', 'Afrikaans', 'Albanian', 'Amharic', 'Arabic', 'Armenian', 'Azerbaijani', 'Basque', 'Belarusian', 'Bengali', 'Bosnian', 'Bulgarian', 'Catalan', 'Cebuano', 'Chichewa', 'Chinese', 'Corsican', 'Croatian', 'Czech', 'Danish', 'Dutch', 'English', 'Esperanto', 'Estonian', 'Filipino', 'Finnish', 'French', 'Frisian', 'Galician', 'Georgian', 'German', 'Greek', 'Gujarati', 'Haitian Creole', 'Hausa', 'Hawaiian', 'Hebrew', 'Hindi', 'Hmong', 'Hungarian', 'Icelandic', 'Igbo', 'Indonesian', 'Irish', 'Italian', 'Japanese', 'Javanese', 'Kannada', 'Kazakh', 'Khmer', 'Korean', 'Kurdish', 'Kyrgyz', 'Lao', 'Latin', 'Latvian', 'Lithuanian', 'Luxembourgish', 'Macedonian', 'Malagasy', 'Malay', 'Malayalam', 'Maltese', 'Maori', 'Marathi', 'Mongolian', 'Myanmar', 'Nepali', 'Norwegian', 'Pashto', 'Persian', 'Polish', 'Portuguese', 'Punjabi', 'Romanian', 'Russian', 'Samoan', 'Scots Gaelic', 'Serbian', 'Sesotho', 'Shona', 'Sindhi', 'Sinhala', 'Slovak', 'Slovenian', 'Somali', 'Spanish', 'Sundanese', 'Swahili', 'Swedish', 'Tajik', 'Tamil', 'Telugu', 'Thai', 'Turkish', 'Ukrainian', 'Urdu', 'Uzbek', 'Vietnamese', 'Welsh', 'Xhosa', 'Yiddish', 'Yoruba', 'Zulu'];

  final List<Language> _languageList = [
    Language('auto', 'Detect'),
    Language('af', 'Afrikaans'),
    Language('sq', 'Albanian'),
    Language('am', 'Amharic'),
    Language('ar', 'Arabic'),
    Language('hy', 'Armenian'),
    Language('az', 'Azerbaijani'),
    Language('eu', 'Basque'),
    Language('be', 'Belarusian'),
    Language('bn', 'Bengali'),
    Language('bs', 'Bosnian'),
    Language('bg', 'Bulgarian'),
    Language('ca', 'Catalan'),
    Language('ceb', 'Cebuano'),
    Language('ny', 'Chichewa'),
    Language('zh-cn', 'Chinese'),
    Language('co', 'Corsican'),
    Language('hr', 'Croatian'),
    Language('cs', 'Czech'),
    Language('da', 'Danish'),
    Language('nl', 'Dutch'),
    Language('en', 'English'),
    Language('eo', 'Esperanto'),
    Language('et', 'Estonian'),
    Language('tl', 'Filipino'),
    Language('fi', 'Finnish'),
    Language('fr', 'French'),
    Language('fy', 'Frisian'),
    Language('gl', 'Galician'),
    Language('ka', 'Georgian'),
    Language('de', 'German'),
    Language('el', 'Greek'),
    Language('gu', 'Gujarati'),
    Language('ht', 'Haitian Creole'),
    Language('ha', 'Hausa'),
    Language('haw', 'Hawaiian'),
    Language('iw', 'Hebrew'),
    Language('hi', 'Hindi'),
    Language('hmn', 'Hmong'),
    Language('hu', 'Hungarian'),
    Language('is', 'Icelandic'),
    Language('ig', 'Igbo'),
    Language('id', 'Indonesian'),
    Language('ga', 'Irish'),
    Language('it', 'Italian'),
    Language('ja', 'Japanese'),
    Language('jw', 'Javanese'),
    Language('kn', 'Kannada'),
    Language('kk', 'Kazakh'),
    Language('km', 'Khmer'),
    Language('ko', 'Korean'),
    Language('ku', 'Kurdish'),
    Language('ky', 'Kyrgyz'),
    Language('lo', 'Lao'),
    Language('la', 'Latin'),
    Language('lv', 'Latvian'),
    Language('lt', 'Lithuanian'),
    Language('lb', 'Luxembourgish'),
    Language('mk', 'Macedonian'),
    Language('mg', 'Malagasy'),
    Language('ms', 'Malay'),
    Language('ml', 'Malayalam'),
    Language('mt', 'Maltese'),
    Language('mi', 'Maori'),
    Language('mr', 'Marathi'),
    Language('mn', 'Mongolian'),
    Language('my', 'Myanmar'),
    Language('ne', 'Nepali'),
    Language('no', 'Norwegian'),
    Language('ps', 'Pashto'),
    Language('fa', 'Persian'),
    Language('pl', 'Polish'),
    Language('pt', 'Portuguese'),
    Language('ma', 'Punjabi'),
    Language('ro', 'Romanian'),
    Language('ru', 'Russian'),
    Language('sm', 'Samoan'),
    Language('gd', 'Scots Gaelic'),
    Language('sr', 'Serbian'),
    Language('st', 'Sesotho'),
    Language('sn', 'Shona'),
    Language('sd', 'Sindhi'),
    Language('si', 'Sinhala'),
    Language('sk', 'Slovak'),
    Language('sl', 'Slovenian'),
    Language('so', 'Somali'),
    Language('es', 'Spanish'),
    Language('su', 'Sundanese'),
    Language('sw', 'Swahili'),
    Language('sv', 'Swedish'),
    Language('tg', 'Tajik'),
    Language('ta', 'Tamil'),
    Language('te', 'Telugu'),
    Language('th', 'Thai'),
    Language('tr', 'Turkish'),
    Language('uk', 'Ukrainian'),
    Language('ur', 'Urdu'),
    Language('uz', 'Uzbek'),
    Language('vi', 'Vietnamese'),
    Language('cy', 'Welsh'),
    Language('xh', 'Xhosa'),
    Language('yi', 'Yiddish'),
    Language('yo', 'Yoruba'),
    Language('zu', 'Zulu'),
  ];

  @override
  void initState() {
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
    controller.init();
    if(widget.textFromImage.toString().isNotEmpty)
    {
      setState(() {
        input.text = widget.textFromImage;
      });
    }



  }

  checkInternetforTranslation() async {
    var connectivityResult = await (Connectivity().checkConnectivity());
    if (connectivityResult == ConnectivityResult.mobile ||
        connectivityResult == ConnectivityResult.wifi) {
      translate();
    } else {
      showDialog(
          context: context,
          builder: (BuildContext context) {
            return NoInternetBox();
          });
    }
  }

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    final size = MediaQuery.of(context).size;
    return Scaffold(

      appBar: AppBar(
        leading: IconButton(
          onPressed: (){
            Navigator.pop(context, true);
          },
          icon: Icon(
            Icons.arrow_back_outlined,
            color: Colors.white,
            size: 28,
          ),
        ),
        centerTitle: true,
        title: RichText(
          text: TextSpan(
              text: 'T',
              style: GoogleFonts.pacifico(
                  color:  yellow,
                  fontSize: 22,
                  fontWeight: FontWeight.w800
              ),
              children: [
                TextSpan(
                  text: 'ranslator',
                  style: GoogleFonts.ubuntu(
                      color: lBG,
                      fontSize: 22,
                      fontWeight: FontWeight.w800
                  ),
                ),
              ]
          ),
        ),
        backgroundColor: darkBlue,
        bottom: PreferredSize(
          preferredSize: Size.fromHeight(90.0),
          child: Padding(
            padding: EdgeInsets.fromLTRB(10, 10, 10, 20),
            child: Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  decoration: BoxDecoration(
                      color: darkBlue,
                      borderRadius: BorderRadius.circular(50),
                      border: Border.all(
                          width: 2,
                          color: yellow
                      )
                  ),
                  child: Padding(
                      padding: EdgeInsets.only(
                        left: 15,
                      ),
                      child: Container(
                        child: Center(child: listInput()),
                        width: size.width / 3.3,
                      )),
                ),
                CircleAvatar(
                  backgroundColor: dCC,
                  radius: 25,
                  child: Center(
                    child: IconButton(
                      onPressed: () {
                        setState(() {
                          Language temp = _firstLang;
                          _firstLang = _secondLang;
                          _secondLang = temp;
                        });
                      },
                      icon: Icon(
                        Icons.repeat,
                        color: white,
                        size: 30,
                      ),
                    ),
                  ),
                ),
                Container(
                  decoration: BoxDecoration(
                      color: darkBlue,
                      borderRadius: BorderRadius.circular(50),
                      border: Border.all(width: 2,
                          color: yellow
                      )
                  ),
                  child: Padding(
                      padding: const EdgeInsets.only(
                        left: 15,
                      ),
                      child: Container(
                        child: Center(child: listOutput()),
                        width: size.width / 3.3,
                      )),
                ),
              ],
            ),
          ),
        ),
      ),

      body: SingleChildScrollView(
        child: Container(
          child: Column(
            children: [

              Padding(
                padding: EdgeInsets.fromLTRB(15, 20, 15, 20),
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(7),
                    color: themeProvider.isLightTheme? lCC : dCC,
                  ),
                  height: 240,
                  child: Padding(
                    padding: EdgeInsets.fromLTRB(15, 10, 15, 15),
                    child: Column(
                      children: [
                        Container(
                          height: 165,
                          color: themeProvider.isLightTheme? lCC : dCC,
                          child: TextFormField(
                            controller: input,
                            autocorrect: true,
                            style: GoogleFonts.ubuntu(
                                fontSize: 20,
                                color: themeProvider.isLightTheme ? black : white
                            ),
                            keyboardType: TextInputType.multiline,
                            decoration: InputDecoration(
                              fillColor: themeProvider.isLightTheme? lCC : dCC,
                              hintText: 'Write Some Text Here',
                              hintStyle: GoogleFonts.ubuntu(
                                  fontSize: 19
                              ),
                              border: InputBorder.none,
                            ),
                            maxLines: 1000,
                            minLines: 5,
                          ),
                        ),

                        Row(
                          mainAxisAlignment:
                          MainAxisAlignment.spaceAround,
                          children: [

                            ElevatedButton.icon(
                              icon: Icon(
                                CupertinoIcons.speaker_2,
                                color: themeProvider.isLightTheme? blueColor : yellow,
                                size: 14.0,
                              ),
                              label: Text('Listen',
                                  style: GoogleFonts.ubuntu(
                                      color: themeProvider.isLightTheme ? black : white,
                                      fontSize: 12
                                  )
                              ),
                              style: ElevatedButton.styleFrom(
                                primary: themeProvider.isLightTheme? Colors.grey[100] : darkBlue,
                                shape: new RoundedRectangleBorder(
                                  borderRadius: new BorderRadius.circular(50.0),
                                ),
                              ),
                              onPressed: () async {
                                if(input.text.isNotEmpty){
                                  controller.speak("${input.text}");
                                }
                                else{
                                  ScaffoldMessenger
                                      .of(context)
                                      .showSnackBar(
                                      SnackBar(
                                        shape: new RoundedRectangleBorder(
                                          borderRadius: new BorderRadius.circular(30.0),
                                        ),
                                        width: size.width/2.2,
                                        duration: Duration(seconds: 3),
                                        behavior: SnackBarBehavior.floating,
                                        backgroundColor: themeProvider.isLightTheme ? blueColor : yellow,
                                        content: Text('No Text to Listen',
                                          textAlign: TextAlign.center,
                                          style: GoogleFonts.ubuntu(
                                            fontSize: 19,
                                            color: themeProvider.isLightTheme ? white : black,
                                          ),
                                        ),
                                      ));
                                }
                              },
                            ),

                            ElevatedButton.icon(
                              icon: Icon(
                                CupertinoIcons.doc_on_clipboard,
                                color: themeProvider.isLightTheme? blueColor : yellow,
                                size: 14.0,
                              ),
                              label: Text('Copy',
                                  style: GoogleFonts.ubuntu(
                                      color: themeProvider.isLightTheme ? black : white,
                                      fontSize: 12
                                  )
                              ),
                              style: ElevatedButton.styleFrom(
                                primary: themeProvider.isLightTheme? Colors.grey[100] : darkBlue,
                                shape: new RoundedRectangleBorder(
                                  borderRadius: new BorderRadius.circular(50.0),
                                ),
                              ),
                              onPressed: () async {
                                FocusScope.of(context).unfocus();
                                if(input.text.isNotEmpty){
                                  FlutterClipboard.copy(
                                      input.text)
                                      .then((value) =>
                                      ScaffoldMessenger
                                          .of(context)
                                          .showSnackBar(
                                          SnackBar(
                                            shape: new RoundedRectangleBorder(
                                              borderRadius: new BorderRadius.circular(30.0),
                                            ),
                                            width: size.width/2.2,
                                            duration: Duration(seconds: 3),
                                            behavior: SnackBarBehavior.floating,
                                            backgroundColor: themeProvider.isLightTheme ? blueColor : yellow,
                                            content: Text('Text Copied',
                                              textAlign: TextAlign.center,
                                              style: GoogleFonts.ubuntu(
                                                fontSize: 19,
                                                color: themeProvider.isLightTheme ? white : black,
                                              ),
                                            ),
                                          )
                                      )
                                  );
                                }
                                else{
                                  ScaffoldMessenger
                                      .of(context)
                                      .showSnackBar(
                                      SnackBar(
                                        shape: new RoundedRectangleBorder(
                                          borderRadius: new BorderRadius.circular(30.0),
                                        ),
                                        width: size.width/2.2,
                                        duration: Duration(seconds: 3),
                                        behavior: SnackBarBehavior.floating,
                                        backgroundColor: themeProvider.isLightTheme ? blueColor : yellow,
                                        content: Text('No Text to Copy',
                                          textAlign: TextAlign.center,
                                          style: GoogleFonts.ubuntu(
                                            fontSize: 19,
                                            color: themeProvider.isLightTheme ? white : black,
                                          ),
                                        ),
                                      ));
                                }
                              },
                            ),

                            ElevatedButton.icon(
                              icon: Icon(
                                Icons.share_outlined,
                                color: themeProvider.isLightTheme? blueColor : yellow,
                                size: 14.0,
                              ),
                              label: Text('Share',
                                  style: GoogleFonts.ubuntu(
                                      color: themeProvider.isLightTheme ? black : white,
                                      fontSize: 12
                                  )
                              ),
                              style: ElevatedButton.styleFrom(
                                primary: themeProvider.isLightTheme? Colors.grey[100] : darkBlue,
                                shape: new RoundedRectangleBorder(
                                  borderRadius: new BorderRadius.circular(20.0),
                                ),
                              ),
                              onPressed: () async {
                                FocusScope.of(context).unfocus();
                                if (input.text.isNotEmpty){
                                  await FlutterShare.share(
                                      title: 'Translator',
                                      text: input.text,
                                      chooserTitle: 'Share to');
                                }
                                else {
                                  ScaffoldMessenger
                                      .of(context)
                                      .showSnackBar(
                                      SnackBar(
                                        shape: new RoundedRectangleBorder(
                                          borderRadius: new BorderRadius.circular(30.0),
                                        ),
                                        width: size.width/2.2,
                                        duration: Duration(seconds: 3),
                                        behavior: SnackBarBehavior.floating,
                                        backgroundColor: themeProvider.isLightTheme ? blueColor : yellow,
                                        content: Text('No Text to Share',
                                          textAlign: TextAlign.center,
                                          style: GoogleFonts.ubuntu(
                                            fontSize: 19,
                                            color: themeProvider.isLightTheme ? white : black,
                                          ),
                                        ),
                                      ));
                                }
                              },
                            ),

                            ElevatedButton.icon(
                              icon: Icon(
                                MdiIcons.eraser,
                                color: themeProvider.isLightTheme? blueColor : yellow,
                                size: 14.0,
                              ),
                              label: Text('Erase',
                                  style: GoogleFonts.ubuntu(
                                      color: themeProvider.isLightTheme ? black : white,
                                      fontSize: 12
                                  )
                              ),
                              style: ElevatedButton.styleFrom(
                                primary: themeProvider.isLightTheme? Colors.grey[100] : darkBlue,
                                shape: new RoundedRectangleBorder(
                                  borderRadius: new BorderRadius.circular(50.0),
                                ),
                              ),
                              onPressed: () async {
                                if(input.text.isNotEmpty){
                                  setState(() {
                                    input.clear();
                                    setState(() {
                                      output = null;
                                    });
                                    ScaffoldMessenger
                                        .of(context)
                                        .showSnackBar(
                                        SnackBar(
                                          shape: new RoundedRectangleBorder(
                                            borderRadius: new BorderRadius.circular(30.0),
                                          ),
                                          width: size.width/2.2,
                                          duration: Duration(seconds: 3),
                                          behavior: SnackBarBehavior.floating,
                                          backgroundColor: themeProvider.isLightTheme ? blueColor : yellow,
                                          content: Text('Text Erased',
                                            textAlign: TextAlign.center,
                                            style: GoogleFonts.ubuntu(
                                              fontSize: 19,
                                              color: themeProvider.isLightTheme ? white : black,
                                            ),
                                          ),
                                        ));
                                  });
                                }
                                else{
                                  ScaffoldMessenger
                                      .of(context)
                                      .showSnackBar(
                                      SnackBar(
                                        shape: new RoundedRectangleBorder(
                                          borderRadius: new BorderRadius.circular(30.0),
                                        ),
                                        width: size.width/2.2,
                                        duration: Duration(seconds: 3),
                                        behavior: SnackBarBehavior.floating,
                                        backgroundColor: themeProvider.isLightTheme ? blueColor : yellow,
                                        content: Text('Already Empty',
                                          textAlign: TextAlign.center,
                                          style: GoogleFonts.ubuntu(
                                            fontSize: 19,
                                            color: themeProvider.isLightTheme ? white : black,
                                          ),
                                        ),
                                      ));
                                }
                              },
                            ),

                          ],
                        )
                      ],
                    ),
                  ),
                ),
              ),

              SizedBox(height: 5,),

              Center(
                child:  ElevatedButton(
                  child: Text('Translate',
                      style: GoogleFonts.ubuntu(
                          color: themeProvider.isLightTheme ? white : black,
                          fontSize: 22,
                          fontWeight: FontWeight.w600
                      )
                  ),
                  style: ElevatedButton.styleFrom(
                    primary: themeProvider.isLightTheme ? blueColor : yellow,
                    padding: EdgeInsets.fromLTRB(20, 10, 20, 10),
                    shape: new RoundedRectangleBorder(
                      borderRadius: new BorderRadius.circular(20.0),
                    ),
                  ),
                  onPressed: () async {
                    FocusScope.of(context).unfocus();
                    if (await reward.isLoaded) {
                      reward.show();
                      checkInternetforTranslation();
                    }
                    else {
                      reward.load();
                      setState(() {
                        reward.show();
                        checkInternetforTranslation();
                      });
                    }

                  },
                ),
              ),

              SizedBox(height: 5,),

              Padding(
                padding: EdgeInsets.fromLTRB(15, 20, 15, 20),
                child:
                output == null
                    ? Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(7),
                    color: themeProvider.isLightTheme? lCC : dCC,
                  ),
                  height: 240,
                  child: NativeAdmob(
                    adUnitID: AdManager.nativeAdId,
                    numberAds: 3,
                    controller: NativeAdmobController(),
                    type: NativeAdmobType.full,
                  ),

                )
                    : Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(7),
                    color: themeProvider.isLightTheme? lCC : dCC,
                  ),
                  height: 240,
                  child: Padding(
                    padding: EdgeInsets.fromLTRB(15, 10, 15, 15),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          height: 165,
                          color: themeProvider.isLightTheme? lCC : dCC,
                          child: SingleChildScrollView(
                            child: Padding(
                              padding: const EdgeInsets.only(top:10),
                              child: Text(
                                output.toString(),
                                style: GoogleFonts.ubuntu(
                                  color: themeProvider.isLightTheme ? black : white,
                                  fontSize: 20,
                                ),
                              ),
                            ),
                          ),
                        ),
                        Row(
                          mainAxisAlignment:
                          MainAxisAlignment.spaceAround,
                          children: [
                            ElevatedButton.icon(
                              icon: Icon(
                                CupertinoIcons.speaker_2,
                                color: themeProvider.isLightTheme? blueColor : yellow,
                                size: 14.0,
                              ),
                              label: Text('Listen',
                                  style: GoogleFonts.ubuntu(
                                      color: themeProvider.isLightTheme ? black : white,
                                      fontSize: 12
                                  )
                              ),
                              style: ElevatedButton.styleFrom(
                                primary: themeProvider.isLightTheme? Colors.grey[100] : darkBlue,
                                shape: new RoundedRectangleBorder(
                                  borderRadius: new BorderRadius.circular(20.0),
                                ),
                              ),
                              onPressed: () async {
                                controller.speak("${output.text}");
                              },
                            ),

                            ElevatedButton.icon(
                              icon: Icon(
                                CupertinoIcons.doc_on_clipboard,
                                color: themeProvider.isLightTheme? blueColor : yellow,
                                size: 14.0,
                              ),
                              label: Text('Copy',
                                  style: GoogleFonts.ubuntu(
                                      color: themeProvider.isLightTheme ? black : white,
                                      fontSize: 12
                                  )
                              ),
                              style: ElevatedButton.styleFrom(
                                primary: themeProvider.isLightTheme? Colors.grey[100] : darkBlue,
                                shape: new RoundedRectangleBorder(
                                  borderRadius: new BorderRadius.circular(20.0),
                                ),
                              ),
                              onPressed: () async {
                                FlutterClipboard.copy(
                                    output.text)
                                    .then((value) =>
                                    ScaffoldMessenger
                                        .of(context)
                                        .showSnackBar(
                                        SnackBar(
                                          shape: new RoundedRectangleBorder(
                                            borderRadius: new BorderRadius.circular(30.0),
                                          ),
                                          width: size.width/2.2,
                                          duration: Duration(seconds: 3),
                                          behavior: SnackBarBehavior.floating,
                                          backgroundColor: themeProvider.isLightTheme ? blueColor : yellow,
                                          content: Text('Text Copied',
                                            textAlign: TextAlign.center,
                                            style: GoogleFonts.ubuntu(
                                              fontSize: 19,
                                              color: themeProvider.isLightTheme ? white : black,
                                            ),
                                          ),
                                        )
                                    )
                                );
                              },
                            ),

                            ElevatedButton.icon(
                              icon: Icon(
                                Icons.share_outlined,
                                color: themeProvider.isLightTheme? blueColor : yellow,
                                size: 14.0,
                              ),
                              label: Text('Share',
                                  style: GoogleFonts.ubuntu(
                                      color: themeProvider.isLightTheme ? black : white,
                                      fontSize: 12
                                  )
                              ),
                              style: ElevatedButton.styleFrom(
                                primary: themeProvider.isLightTheme? Colors.grey[100] : darkBlue,
                                shape: new RoundedRectangleBorder(
                                  borderRadius: new BorderRadius.circular(20.0),
                                ),
                              ),
                              onPressed: () async {
                                await FlutterShare.share(
                                    title: 'Translator',
                                    text: output.text,
                                    chooserTitle: 'Share to');
                              },
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
  void translate() {
    translator
        .translate (
        input.text,
        from: _firstLang.code,
        to: _secondLang.code)
        .then((value) {
      setState(() {
        output = value;
      });
    });
  }

  Widget listInput() {
    var dd = DropdownButton<String>(
      isExpanded: true,
      dropdownColor: darkBlue,
      underline: SizedBox(),
      icon: SizedBox(),
      items: _langName.map((String val) {
        return DropdownMenuItem<String>(
          value: val,
          child: Text(val, style: listStyle),
        );
      }).toList(), //map
      value: _firstLang.name,
      onChanged: (String newVal) {
        setState(() {
          int x = _langName.indexOf(newVal);
          _firstLang = _languageList.elementAt(x);
        });
      },
    ); //dropdown
    return dd;
  }

  Widget listOutput() {
    var dd = DropdownButton<String>(
      isExpanded: true,
      dropdownColor: darkBlue,
      underline: SizedBox(),
      icon: SizedBox(),
      items: _langName.map(
            (String val) {
          return DropdownMenuItem<String>(
            value: val,
            child: Text(val, style: listStyle),
          );
        },
      ).toList(), //map
      value: _secondLang.name,
      onChanged: (String newVal) {
        setState(() {
          int x = _langName.indexOf(newVal);
          _secondLang = _languageList.elementAt(x);
        });
      },
    ); //dropdown
    return dd;
  }

}
