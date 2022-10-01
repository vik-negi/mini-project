import 'package:flutter/material.dart';
import "package:evika/views/sample_post.dart";
import 'package:get/get.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return const GetMaterialApp(
      debugShowCheckedModeBanner: false,
      home:
          // SplashScreen(
          //   seconds: 5,
          //   image: Image(image: AssetImage('assets/sss.gif')),
          //   title: const Text(
          //     "𝑒ｖᎥⓀ𝐚",
          //     style: TextStyle(
          //         fontSize: 60,
          //         fontFamily: 'Pacifico',
          //         fontWeight: FontWeight.bold,
          //         color: Color.fromARGB(221, 135, 251, 100)),
          //   ),
          //   photoSize: 170,
          //   navigateAfterSeconds: SigninPage(),
          //   useLoader: false,
          //   loaderColor: Colors.black54,
          // ),
          SamplePost(),
    );
  }
}
