import 'dart:async';
import 'dart:convert';

import 'package:evika/models/user/post_model.dart';
import 'package:evika/utils/sharedPreferenced.dart';
import 'package:evika/view_models/common_viewmodel.dart';
import 'package:evika/view_models/home_viewmodel.dart/post_viewmodel.dart';
import 'package:evika/view_models/location.dart';
import 'package:evika/views/description/description_repo_imp.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:vibration/vibration.dart';

class DescriptionVM extends GetxController {
  bool notificationSet = false;
  GetLocation getLocation = GetLocation();
  String? userId;
  PostVM pvm = Get.find<PostVM>();
  CommonVM cvm = Get.find<CommonVM>();
  String? imageTag;
  int index = 0;
  // PostData? postData;
  DescriptionRepoImp descriptionRepoImp = DescriptionRepoImp();
  bool isLoading = false;
  @override
  void onInit() async {
    getParameters();
    await getAddress();
    super.onInit();
  }

  void toggleNotification() async {
    notificationSet = !notificationSet;
    if (await Vibration.hasVibrator() ?? false) {
      Vibration.vibrate(duration: 100);
    }
    update();
  }

  bool isRegistered() {
    debugPrint("UserID : $userId");
    bool x = pvm.postList[index].registration!.contains(userId);

    debugPrint("isRegistered: $x");
    return x;
  }

  registerUserInEvent() async {
    debugPrint("Register User function Called");
    isLoading = true;
    pvm.postList[index].registration!.add(userId);
    update();
    pvm.update();
    bool isRegistered =
        await descriptionRepoImp.registerUserInEvent(pvm.postList[index].id!);
    if (!isRegistered) {
      pvm.postList[index].registration!.remove(userId);
    }
    pvm.update();
    isLoading = false;
    update();
  }

  String address = "Loading...";

  Future getAddress() async {
    [83.185949499, 26.0739138];
    var x = await getLocation.findAdressByPosition(
        pvm.postList[index].eventLocation?.coordinates?[1] ?? 22.0,
        pvm.postList[index].eventLocation?.coordinates?[0] ?? 83.97);
    debugPrint("Address : ${Future.value(x)}");
    // address = "${x.}";
    address = "${x.address1} ${x.state} ${x.country} ${x.zipcode}";
    update();
  }

  getParameters() async {
    var tag = Get.arguments['tag'];
    if (tag != null) {
      imageTag = tag;
    }
    var argIndex = Get.arguments['index'];
    if (argIndex != null) {
      index = argIndex;
    }
    userId = Get.arguments["userId"];
    // userId = await SharedPrefs.getString("userId");
  }
}
