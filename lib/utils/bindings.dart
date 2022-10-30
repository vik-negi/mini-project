import 'package:evika/view_models/home_viewmodel.dart/post_viewmodel.dart';
import 'package:evika/view_models/signin_signup_viewmodel.dart/signup_viewmodel.dart';
import 'package:get/get.dart';

class FeedBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(PostVM());
  }
}

class SignupBindings extends Bindings {
  @override
  void dependencies() {
    Get.put(SignupVM());
  }
}
