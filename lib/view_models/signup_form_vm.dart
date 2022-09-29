import 'package:flutter/material.dart';
import 'package:frontend/models/user/user_model.dart';
import 'package:get/get.dart';

class SignUpFormVM extends GetxController {
  RxInt activeStepIndex = 0.obs;
  UserModel userPersonalModel = Get.put(UserModel());
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController confirmPasswordController =
      TextEditingController();
  final TextEditingController mobileController = TextEditingController();

  void incrementActiveStep(formStepLength) {
    if (activeStepIndex < formStepLength) {
      activeStepIndex++;
    }
    update();
  }

  void clearAllFields() {
    emailController.clear();
    passwordController.clear();
    usernameController.clear();
    nameController.clear();
    confirmPasswordController.clear();
    mobileController.clear();
  }
}
