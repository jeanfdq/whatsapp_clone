
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:whatsapp_clone/utils/constants.dart';
import 'package:whatsapp_clone/utils/widget_function.dart';
import 'package:whatsapp_clone/views/signup.dart';

import 'views/home.dart';
import 'views/login.dart';




void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  final user = currentUser();

  runApp( GetMaterialApp(
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
    home: user == null ? Login() : const Home(),
    getPages: [
      GetPage(name: Home.id, page: () => const Home()) ,
      GetPage(name: Login.id, page: () => Login()) ,
      GetPage(name: SignUp.id, page: () => SignUp()) ,
    ],
  ),
  );
}