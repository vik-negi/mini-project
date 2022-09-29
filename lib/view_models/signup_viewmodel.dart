import 'dart:convert';
import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:frontend/data/remote/api_responce.dart';
import 'package:frontend/models/user/user_model.dart';
import 'package:frontend/resources/login_repo/login_repo.dart';
import 'package:frontend/resources/login_repo/login_repo_imp.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SignupVM extends GetxController {
  ApiResponce<Map> response = ApiResponce.loading();
  final LoginRepo loginRepo = LoginRepoImp();

  UserModel userModel = Get.put(UserModel());
  RxInt _currentStep = 0.obs;
  RxBool _isSignup = false.obs;
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _mobileController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();
  final TextEditingController _accountTypeController = TextEditingController();

  TextEditingController get nameController => _nameController;
  TextEditingController get usernameController => _usernameController;
  TextEditingController get emailController => _emailController;
  TextEditingController get mobileController => _mobileController;
  TextEditingController get passwordController => _passwordController;
  TextEditingController get confirmPasswordController =>
      _confirmPasswordController;
  TextEditingController get accountTypeController => _accountTypeController;

  int get currentStep => _currentStep.value;
  bool get isSignup => _isSignup.value;

  void onTapped(int step) {
    _currentStep.value = step;
    update();
  }

  void onStepCancel() {
    if (_currentStep.value > 0) {
      _currentStep.value = _currentStep.value - 1;
    } else {
      _currentStep.value = 0;
    }
    update();
  }

  void onStepContinue() {
    if (_currentStep.value < 2) {
      _currentStep.value = _currentStep.value + 1;
    } else {
      _currentStep.value = 2;
    }
    update();
  }

  Future<Map?> userSignup(
      String name,
      String username,
      String email,
      String moile,
      String password,
      String confirmPassword,
      String accountType) async {
    Map data = {
      'name': name,
      'username': username,
      'email': email,
      'mobile': moile,
      'password': password,
      'confirmPassword': confirmPassword,
      'accountType': accountType,
    };
    Map<dynamic, dynamic>? response = await loginRepo.userSignup(data);

    if (response!["status"] == "success") {
      _isSignup.value = true;
    }
    return null;
  }

  Future<Map?> userSignin(String username, String password) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();

    Map data = {'username': username, 'password': password};
    Map<dynamic, dynamic>? response = await loginRepo.userSignin(data);

    print(response);
    if (response!["status"] == "success") {
      sharedPreferences.setString("token", response["token"]);
      _isSignup.value = true;
      String userData = jsonEncode(response);
      // print(response.toString());

      // userModel = userModelFromJson(userData);
      userModel = UserModel.fromJson(userData);
      update();
      print(userModel);
      return response;
    }
    return null;
  }

  @override
  void onInit() {
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {}
}
