import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:unscript_rookies_app/Utils.dart';
import 'HomePage.dart';

Future main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    theme: ThemeData(
        brightness: Brightness.light
    ),
    darkTheme: ThemeData(
        brightness: Brightness.dark
    ),
    themeMode: ThemeMode.system,
    home: HomePage(),
    scaffoldMessengerKey: messengerKey,
  ));
}

