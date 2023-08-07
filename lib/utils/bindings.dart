import 'package:evika/view_models/common_viewmodel.dart';
import 'package:evika/view_models/home_viewmodel.dart/post_viewmodel.dart';
import 'package:evika/view_models/profile_viewmodels/profile_viewmodel.dart';
import 'package:evika/view_models/signin_signup_viewmodel.dart/signin_viewmodel.dart';
import 'package:evika/view_models/signin_signup_viewmodel.dart/signup_viewmodel.dart';
import 'package:evika/views/create_post/create_post_viewmodel.dart';
import 'package:evika/views/description/description_viewmodel.dart';
import 'package:evika/views/mypost/my_post_viewmodel.dart';
import 'package:evika/views/settings/settingvm.dart';
import 'package:get/get.dart';

class MyPostDetailsBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(MyPostDetailsViewModel());
  }
}

class CreatePostBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(CreatePostVM());
  }
}

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

class SigninBindings extends Bindings {
  @override
  void dependencies() {
    Get.put(SigninVM());
  }
}

class ProfileBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(ProfileVM());
  }
}

class DescriptionBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(DescriptionVM());
  }
}

class SettingsBinging extends Bindings {
  @override
  void dependencies() {
    Get.put(SettingVM());
  }
}
