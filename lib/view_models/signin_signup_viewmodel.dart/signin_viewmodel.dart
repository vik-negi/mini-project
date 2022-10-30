import 'dart:convert';
import 'package:evika/data/remote/api_responce.dart';
import 'package:evika/models/user/user_model.dart';
import 'package:evika/repositories/login_repo/login_repo_imp.dart';
import 'package:evika/utils/sharedPreferenced.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SigninVM extends GetxController {
  ApiResponce<Map> response = ApiResponce.loading();
  SharedPrefs sharedPrefs = SharedPrefs();
  final LoginRepoImp loginRepo = LoginRepoImp();
  final storage = const FlutterSecureStorage();

  UserModel userModel = Get.put(UserModel());
  bool isSigninClickedBool = false;
  void isSigninClicked() {
    isSigninClickedBool = !isSigninClickedBool;
    update();
  }

  bool rememberMeBool = false;
  bool showPasswordBool = false;
  void showPassword() {
    showPasswordBool = !showPasswordBool;
    update();
  }

  void rememberMe() {
    rememberMeBool = !rememberMeBool;
    update();
  }

  final TextEditingController usernameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  Future<Map?> userSignin(String username, String password) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();

    Map data = {'username': username, 'password': password};
    debugPrint(data.toString());
    Map<dynamic, dynamic>? response = await loginRepo.userSignin(data);
    debugPrint("ppppppppppppppppppppppp");
    debugPrint(data.toString());

    debugPrint(response.toString());
    if (response!["status"] == "success") {
      await sharedPreferences.setString("token", response["token"]);
      await sharedPreferences.setBool("isLoggedIn", true);
      await storage.write(key: "evikaToken", value: response["token"]);
      String userData = jsonEncode(response);
<<<<<<< HEAD
      // debugPrint(response.toString());
=======
      // await sharedPrefs.setString("user_id", response["data"]["_id"]);
      await sharedPreferences.setString("user_id", response["data"]["_id"]);
      await sharedPrefs.setString("username", response["data"]["username"]);
      // print(response.toString());
>>>>>>> 05c0ceb568dbd2097dc3e71706c62f250909a253

      // userModel = userModelFromJson(userData);
      userModel = UserModel.fromJson(userData);
      update();
      debugPrint(userModel.toString());
      // _isSigninClicked.value = false;
      return response;
    }
    return null;
  }
}
