import 'dart:async';
import 'dart:convert';

import 'package:evika/data/remote/api_responce.dart';
import 'package:evika/models/user/post_model.dart';
import 'package:evika/models/user/user_model.dart';
import 'package:evika/repositories/common_repo/common_repo_imp.dart';
import 'package:evika/utils/sharedPreferenced.dart';
import 'package:evika/views/profile/profile_pageRepo_imp.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CommonVM extends GetxController {
  List userLikedPostList = [];
  List<Comment> commentList = [];
  bool isLoading = false;
  UserData? userData;
  bool isProfileLoading = false;
  CommonRepoImp commonRepoImp = CommonRepoImp();
  ApiResponce<Map<dynamic, dynamic>?> response = ApiResponce.loading();
  bool isErrorOnFetchingData = false;
  bool isPostFetched = false;
  ProfileRepoImp profileRepoImp = ProfileRepoImp();
  bool tapOnLikedButton = false;
  List<PostData> userPostList = [];
  // SharedPreferences sharedPreferences = SharedPreferences as SharedPreferences;
  bool isLikedPost(String postId) {
    return userLikedPostList.contains(postId);
  }

  void tapOnLikedButtonFun() async {
    Timer(const Duration(seconds: 5), () {
      tapOnLikedButton = false;
      update();
    });
  }

  @override
  void onInit() async {
    super.onInit();

    debugPrint("Common VM oninit function called");
    await getUserFromSharedPrefes();
    likedPost();
  }

  printing() {}

  setProfileLoading(bool value) {
    isProfileLoading = value;
    update();
  }

  Future getUserFromSharedPrefes() async {
    setProfileLoading(true);
    debugPrint("function call getuserformsharedprefes");
    String? user = await SharedPrefs.getString("user");
    debugPrint(user);
    if (user != null) {
      Map<String, dynamic> userDataMap = jsonDecode(user);
      userData = UserData.fromMap(userDataMap);
      if (userData != null) {
        getUserPost(userData?.id);
      }
    }
    setProfileLoading(false);
  }

  logout() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    sharedPreferences.clear();
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

  // late final Future? futurePosts;

  getUserPost(String? id) async {
    debugPrint("Get user Post function called");
    if (id == null) return;
    response = ApiResponce.loading();
    isErrorOnFetchingData = false;
    isPostFetched = false;
    update();
    Map<dynamic, dynamic>? data = await profileRepoImp.getUserPost(id);
    debugPrint("Get user post data printing");
    debugPrint(data.toString());

    try {
      if (data != null) {
        List<dynamic> list = data['data'];
        response = ApiResponce.completed(data);
        update();
        // postList = parsePhotos(postdata);
        userPostList = [];
        for (int i = 0; i < list.length; i++) {
          String postdataStr = jsonEncode(list[i]);
          PostData postData = PostData.fromJson(postdataStr);

          userPostList.add(postData);
          // print("llllllllllllll");
          // print(userPostList[i].eventId);
          isPostFetched = true;
          update();
        }
        print("UserPost Length: ${userPostList.length}");
        update();
        // return userPostList;
      } else {
        isPostFetched = false;
        isErrorOnFetchingData = true;
        response = ApiResponce.error("No data found");
        update();
        // return null;
      }
    } catch (e) {
      debugPrint(e.toString());
      isPostFetched = false;
      isErrorOnFetchingData = true;
      response = ApiResponce.error("No data found");
      update();
      return null;
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
