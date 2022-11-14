import 'package:evika/data/remote/api_responce.dart';
import 'package:evika/models/user/user_model.dart';
import 'package:evika/repositories/login_repo/login_repo_imp.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SignupVM extends GetxController {
  ApiResponce<Map> response = ApiResponce.loading();
  final LoginRepoImp loginRepo = LoginRepoImp();

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

  bool isNextClicked = false;
  List<String> userType = ['Individual', 'Organization'];
  String? selectedUserType;

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

  @override
  void onInit() {
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    emailController.clear();
    passwordController.clear();
    usernameController.clear();
    nameController.clear();
    confirmPasswordController.clear();
    mobileController.clear();
  }
}
