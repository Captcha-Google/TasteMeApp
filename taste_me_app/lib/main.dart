import 'package:flutter/material.dart';
import 'package:taste_me_app/view/intro_screens.dart';
import 'package:taste_me_app/view/screens/home_screen.dart';
import 'package:taste_me_app/view/screens/login_screen.dart';
import 'package:flutter/services.dart';
import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final appDocumentDir = await getApplicationDocumentsDirectory();

  final SharedPreferences prefs = await SharedPreferences.getInstance();
  Hive.init(appDocumentDir.path);

  // Open the authTokenBox and retrieve the auth token value
  var authTokenBox = await Hive.openBox('authTokenBox');
  var authToken = authTokenBox.get('authToken') as String?;
  var isFirstTimeInstall = prefs.getBool('isFirstTimeInstall') ?? false;

  runApp(
    MyApp(
      authToken: authToken,
      isFirstTimeInstall: isFirstTimeInstall,
    ),
  );
}

class MyApp extends StatelessWidget {
  final String? authToken;
  final bool? isFirstTimeInstall;

  const MyApp({
    Key? key,
    required this.authToken,
    required this.isFirstTimeInstall,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'TasteMe',
      themeMode: ThemeMode.system,
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        brightness: Brightness.light,
        primaryColor: const Color(0XFFB70404),
      ),
      home: (isFirstTimeInstall == false)
          ? const IntroScreen()
          : (authToken == null)
              ? const LoginScreen()
              : const HomeScreen(),
    );
  }
}
