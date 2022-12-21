import 'dart:convert';

import 'package:evika/models/user/post_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:vibration/vibration.dart';

class DescriptionVM extends GetxController {
  bool notificationSet = false;
  String? imageTag;
  PostData? postData;
  @override
  void onInit() {
    super.onInit();
    getParameters();
  }

  void toggleNotification() async {
    notificationSet = !notificationSet;
    if (await Vibration.hasVibrator() ?? false) {
      Vibration.vibrate(duration: 100);
    }
    update();
  }

  getParameters() {
    var tag = Get.arguments['tag'];
    if (tag != null) {
      imageTag = tag;
    }

    var post = Get.arguments["post"];
    if (post != null) {
      postData = post;
      debugPrint("Post Data Datetime ${postData!.eventEndAt}");
    }
  }
}
