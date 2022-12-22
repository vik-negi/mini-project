import 'dart:convert';

import 'package:evika/models/user/post_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class MyPostDetailsViewModel extends GetxController {
  int activeImageNumber = 0;
  double fullCommentShown = 0;
  Map<String, dynamic>? postData;
  String? tag;

  @override
  void onInit() {
    super.onInit();
    getArguments();
  }

  getArguments() {
    String? i = Get.arguments['tag'];
    if (i != null) {
      tag = i;
    }
  }

  toggleCommentVisibility() {
    debugPrint("Comment Visibility: $fullCommentShown");
    if (fullCommentShown == 0) {
      fullCommentShown = double.maxFinite;
    } else {
      fullCommentShown = 0;
    }
    update();
  }
}
