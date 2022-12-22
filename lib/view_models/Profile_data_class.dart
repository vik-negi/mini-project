import 'package:evika/models/user/post_model.dart';
import 'package:evika/models/user/user_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ProfileData extends GetxController {
  String baseCheck = "ProfileVM";
  UserData? userData;
  UserData? otherUserData;
  bool isProfileLoading = false;
  List<PostData> userPostList = [];
  PostData? individualPostData;
  List<PostData> otherUserPostList = [];
}
