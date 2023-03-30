import 'dart:async';

import 'package:evika/utils/routes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

// i have chnaged somthing

class SplashScreen extends StatefulWidget {
  SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Timer(const Duration(seconds: 5), () {
      Get.offAllNamed(AppRotutes.screenNavigator);
      // isUserAuthenticated();
    });
  }

  void isUserAuthenticated() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var status = prefs.getBool('isLoggedIn') ?? false;
    if (status) {
      Get.offAllNamed(AppRotutes.screenNavigator);
    } else {
      // Get.offAllNamed(AppRotutes.signin);
      Get.offAllNamed(AppRotutes.screenNavigator);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
          color: Colors.white,
          width: Get.width,
          height: Get.height,
          child: Image.asset(
            'assets/gif/splashlogo.gif',
            fit: BoxFit.contain,
          ),
        ),
      ),
    );
  }
}
