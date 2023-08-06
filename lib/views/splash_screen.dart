import 'dart:async';

import 'package:evika/utils/constants.dart';
import 'package:evika/utils/routes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

// i have chnaged somthing

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);
  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Timer(const Duration(seconds: 5), () {
      Get.offAllNamed(AppRotutes.screenNavigator);
      // isUserAuthenticated();
    });
  }

  void isUserAuthenticated() async {
    // SharedPreferences prefs = await SharedPreferences.getInstance();
    // var status = prefs.getBool('isLoggedIn') ?? false;
    if (Get.width > Constants.webWidth) {
      Get.offAllNamed(AppRotutes.feed);
    } else {
      // Get.offAllNamed(AppRotutes.signin);
      Get.offAllNamed(AppRotutes.screenNavigator);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: Get.width,
        color: Colors.white,
        child: Center(
          child: Container(
            color: Colors.white,
            width: Get.width > 300 ? 300 : Get.width,
            // width: Get.width,
            height: Get.height,
            child: Image.asset(
              'assets/gif/splashlogo.gif',
              fit: BoxFit.contain,
            ),
          ),
        ),
      ),
    );
  }
}
