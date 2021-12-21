import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:imagetotext/models/themeProvider.dart';
import 'package:imagetotext/screens/homeScreen.dart';
import 'package:imagetotext/screens/onBoardingScreen.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:path_provider/path_provider.dart' as pathProvider;

int initScreen;
Future <void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SharedPreferences prefs = await SharedPreferences.getInstance();
  initScreen = prefs.getInt("initScreen");
  await prefs.setInt("initScreen", 1);

  final appDocumentDirectory = await pathProvider.getApplicationDocumentsDirectory();
  Hive.init(appDocumentDirectory.path);
  final settings = await Hive.openBox('settings');
  bool isLightTheme = settings.get('isLightTheme') ?? false;

  runApp( ChangeNotifierProvider(

    create: (_) => ThemeProvider(isLightTheme: isLightTheme),
    child: AppStart(),


  ));
}

class AppStart extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    ThemeProvider themeProvider = Provider.of<ThemeProvider>(context);
    return MyApp(
      themeProvider: themeProvider,
    );
  }
}


class MyApp extends StatefulWidget {
  final ThemeProvider themeProvider;
  const MyApp({Key key, @required this.themeProvider}) : super(key: key);

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Translator',
        theme: widget.themeProvider.themeData(),
        debugShowCheckedModeBanner: false,

        initialRoute: initScreen == 0 || initScreen == null
            ? OnBoardingScreen.idScreen : HomeScreen.idScreen,
        routes: {
          OnBoardingScreen.idScreen: (context) => OnBoardingScreen(),
          HomeScreen.idScreen: (context) => HomeScreen(),
        }
    );
  }
}
