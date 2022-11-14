import 'package:evika/view_models/common_viewmodel.dart';
import 'package:evika/view_models/home_viewmodel.dart/post_viewmodel.dart';
import 'package:evika/view_models/profile_viewmodels/profile_viewmodel.dart';
import 'package:evika/view_models/signin_signup_viewmodel.dart/signup_viewmodel.dart';
import 'package:get/get.dart';

class FeedBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(PostVM());
    Get.put(CommonVM());
  }
}

class SignupBindings extends Bindings {
  @override
  void dependencies() {
    Get.put(SignupVM());
    Get.put(CommonVM());
  }
}

class ProfileBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(ProfileVM());
    // Get.put(CommonVM());
  }
}
