import 'dart:convert';
import 'package:evika/data/remote/api_responce.dart';
import 'package:evika/models/user/user_model.dart';
import 'package:evika/repositories/login_repo/login_repo_imp.dart';
import 'package:evika/utils/routes.dart';
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

  UserModel? userModel;
  bool isSigninClickedBool = false;

  bool rememberMeBool = false;
  bool isPasswordVisible = true;
  void switchPasswordVisibility() {
    // debugPrint("Password visibility change");
    isPasswordVisible = !isPasswordVisible;
    update();
  }

  void switchRememberMe() {
    rememberMeBool = !rememberMeBool;
    update();
  }

  final TextEditingController usernameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  String? usernameErrorText;
  String? passwordErrorText;

  bool checkInputs() {
    if (usernameController.text.trim().isEmpty) {
      usernameErrorText = "Please enter username";
      update();
      return false;
    } else if (passwordController.text.trim().isEmpty) {
      passwordErrorText = "Please enter password";
      update();
      return false;
    } else {
      usernameErrorText = null;
      passwordErrorText = null;
      update();
      return true;
    }
  }

  userSignin() async {
    isSigninClickedBool = true;
    debugPrint("Signin Clicked");
    update();
    if (checkInputs()) {
      Map data = {
        'username': usernameController.text.trim(),
        'password': passwordController.text
      };
      debugPrint(data.toString());
      Map<dynamic, dynamic>? response = await loginRepo.userSignin(data);
      debugPrint("ppppppppppppppppppppppp");
      debugPrint(data.toString());

      debugPrint((response == null).toString());
      if (response!["status"] == "success") {
        await SharedPrefs.setString("user", jsonEncode(response["data"]));
        await SharedPrefs.setString("token", response["token"]);
        await SharedPrefs.setString("name", response["data"]["name"]);
        await SharedPrefs.setString("email", response["data"]["email"]);
        await SharedPrefs.setString("mobile", response["data"]["mobile"]);
        await SharedPrefs.setBool("isVerified", response["data"]["isVerified"]);
        await SharedPrefs.setString(
            "accountType", response["data"]["accountType"]);
        await SharedPrefs.setBool("isLoggedIn", true);
        await storage.write(key: "evikaToken", value: response["token"]);
        String userData = jsonEncode(response);
        // await sharedPrefs.setString("user_id", response["data"]["_id"]);
        await SharedPrefs.setString("userId", response["data"]["_id"]);
        await SharedPrefs.setString("username", response["data"]["username"]);
        print(response.toString());

        // userModel = userModelFromJson(userData);
        var userModel = UserModel.fromJson(userData);
        isSigninClickedBool = false;
        update();
        debugPrint(userModel.toString());
        Get.offAllNamed(AppRotutes.screenNavigator);
      }
    } else {
      isSigninClickedBool = false;
      update();
    }
  }
}
