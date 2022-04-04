
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:whatsapp_clone/utils/constants.dart';

import 'views/login.dart';




void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  runApp( MaterialApp(
    debugShowCheckedModeBanner: false,
    theme: ThemeData(
      colorScheme: const ColorScheme( 
        brightness: Brightness.light,
        primary: kPrimaryColor,
        onPrimary: Colors.white,
        secondary: kPrimaryDarkColor,
        onSecondary: Colors.white,
        background: kPrimaryColor,
        onBackground: Colors.white,
        surface: kPrimaryColor,
        onSurface: Colors.white,
        error: Colors.redAccent,
        onError: Colors.white
      ),
    ),
    home: Login()
  ),);
}