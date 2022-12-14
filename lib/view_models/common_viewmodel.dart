import 'dart:async';

import 'package:evika/models/user/post_model.dart';
import 'package:evika/repositories/common_repo/common_repo_imp.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shared_preferences/shared_preferences.dart';

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
      var response = await commonRepoImp.getAndAddComments(postId, null);
      print("response $response");
      commentList = response;
    } catch (e) {
      print(e);
    }
    isLoading = false;
    update();
  }

  Future getSharedPref(String key, String type) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    if (type == "String") {
      return prefs.getString(key);
    } else if (type == "bool") {
      return prefs.getBool(key);
    } else if (type == "int") {
      return prefs.getInt(key);
    } else if (type == "double") {
      return prefs.getDouble(key);
    } else if (type == "StringList") {
      return prefs.getStringList(key);
    }
  }

  void addComment(String postId, String text) async {
    // isLoading = true;
    Comment comment = Comment(
      createdAt: DateTime.now(),
      id: '',
      text: text,
      name: await getSharedPref('name', "String"),
      isEdited: false,
      userImage: 'https://www.w3schools.com/howto/img_avatar.png',
      userId: await getSharedPref('userId', "String"),
      username: await getSharedPref('username', "String"),
    );
    commentList.add(comment);
    update();
    try {
      List<Comment>? response =
          await commonRepoImp.getAndAddComments(postId, text);
      print("response $response");
      commentList.removeLast();
      if (response != null) {
        commentList = response;
        update();
      }
    } catch (e) {
      commentList.removeLast();
      update();
      Get.snackbar("Error", "Something went wrong");
      print(e);
    }
    // isLoading = false;
    update();
  }
}
