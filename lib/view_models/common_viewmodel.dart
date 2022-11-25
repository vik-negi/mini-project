import 'dart:async';

import 'package:evika/models/user/post_model.dart';
import 'package:evika/repositories/common_repo/common_repo_imp.dart';
import 'package:get/get.dart';

class CommonVM extends GetxController {
  List userLikedPostList = [];
  List<Comment> commentList = [];
  bool isLoading = false;
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

  void getComments(String postId) async {
    isLoading = true;
    update();
    try {
      var response = await commonRepoImp.getComments(postId);
      print("response $response");
      commentList = response;
    } catch (e) {
      print(e);
    }
    isLoading = false;
    update();
  }
}
