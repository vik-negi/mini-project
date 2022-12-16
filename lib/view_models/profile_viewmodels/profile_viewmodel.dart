import 'dart:convert';

import 'package:evika/models/user/user_model.dart';
import 'package:evika/utils/sharedPreferenced.dart';
import 'package:flutter/cupertino.dart';
// import 'package:evika/utils/sharedPreferenced.dart';
// import 'package:evika/utils/sharedPreferenced.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
// import 'package:share_plus/share_plus.dart';

class ProfileVM extends GetxController {
  logout() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    sharedPreferences.clear();
  }

  UserData? userData;
  bool isLoading = false;

  setLoading(bool value) {
    isLoading = value;
    update();
  }

  Future getUserFromSharedPrefes() async {
    setLoading(true);
    debugPrint("function call getuserformsharedprefes");
    var user = await SharedPrefs.getString("user");
    debugPrint(user);
    if (user != null) {
      var userDataMap = jsonDecode(user);
      userData = UserData.fromMap(userDataMap);
    }
    setLoading(false);
  }

  @override
  onInit() async {
    debugPrint("onint in profile vm is running");
    super.onInit();
    // await getUserFromSharedPrefes();
  }

  hii() {
    debugPrint("onint in profile vm is running");
    // await getUserFromSharedPrefes();
  }

  // var userData = UserData(
  //     name: "Yashwant Sahu",
  //     email: "mlp.yashvantgupta@gmail.com",
  //     username: "@yash5626",
  //     password: "somepassword",
  //     id: "21",
  //     bio: "I am a Flutter Developer",
  //     profileImage:
  //         "https://images.unsplash.com/photo-1511367461989-f85a21fda167?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxzZWFyY2h8Mnx8cHJvZmlsZXxlbnwwfHwwfHw%3D&w=1000&q=80",
  //     isBlocked: false,
  //     isEmailVerified: true,
  //     isMobileVerified: true,
  //     mobile: "6306406076",
  //     gender: "male",
  //     location: [],
  //     follower: [
  //       1,
  //       1,
  //       1,
  //       1,
  //       1,
  //       1,
  //       1,
  //       1,
  //       1,
  //       1,
  //       1,
  //       1,
  //       1,
  //       1,
  //       1,
  //       1,
  //       1,
  //       1,
  //       1,
  //       1,
  //       1,
  //     ],
  //     following: [
  //       1,
  //       1,
  //       1,
  //       1,
  //       1,
  //       1,
  //       1,
  //       1,
  //       1,
  //       1,
  //       1,
  //       1,
  //       1,
  //       1,
  //       1,
  //       1,
  //       1,
  //       1,
  //       1,
  //       1,
  //       1,
  //       1,
  //       1,
  //       1,
  //       1,
  //       1,
  //       1,
  //       1,
  //       1,
  //       1,
  //       1,
  //       1,
  //     ],
  //     profileViews: 10232);
}
