import 'dart:convert';

import 'package:evika/data/remote/api_services/post_api_service.dart';
import 'package:evika/models/user/post_model.dart';
import 'package:evika/views/mypost/my_post_deatils_repo_imp.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class MyPostDetailsViewModel extends GetxController {
  int activeImageNumber = 0;

  double fullCommentShown = 0;
  List<Map<String, dynamic>?>? registrations;

  PostDetailsRepoImp postDetailsRepoImp = PostDetailsRepoImp();
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

  getRegisteredUsers(String postId) async {
    var temp = await postDetailsRepoImp.getPostRegistrations(postId);
    registrations = temp;
  }
}
