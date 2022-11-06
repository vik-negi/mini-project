import 'dart:async';

import 'package:evika/repositories/common_repo/common_repo_imp.dart';
import 'package:get/get.dart';

class CommonVM extends GetxController {
  List userLikedPostList = [];
  CommonRepoImp commonRepoImp = CommonRepoImp();
  bool isLikedPost(String postId) {
    return userLikedPostList.contains(postId);
  }

  bool tapOnLikedButton = false;
  void tapOnLikedButtonFun() async {
    Timer(const Duration(seconds: 5), () {
      tapOnLikedButton = false;
      update();
    });
  }

  @override
  void onInit() {
    super.onInit();
    likedPost();
  }

  likedPost() async {
    List? response = await commonRepoImp.userLikedPost();
    if (response != null) {
      userLikedPostList = response;
      update();
    } else {
      userLikedPostList = response ?? [];
    }
    update();
  }
}
