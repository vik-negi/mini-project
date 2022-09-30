import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:awesome_loader/awesome_loader.dart';
import 'package:evika/home.dart';
import 'package:evika/pages/auth/login.dart';
import 'package:flutter/material.dart';
import 'package:splashscreen/splashscreen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        home: SplashScreen(
          seconds: 5,
          image: Image(image: AssetImage('assets/sss.gif')),
          title: const Text(
            "𝑒ｖᎥⓀ𝐚",
            style: TextStyle(
                fontSize: 60,
                fontFamily: 'Pacifico',
                fontWeight: FontWeight.bold,
                color: Color.fromARGB(221, 135, 251, 100)),
          ),
          photoSize: 170,
          navigateAfterSeconds: LoginPage(),
          useLoader: false,
          loaderColor: Colors.black54,
        ));
  }
}
