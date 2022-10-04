import 'package:evika/view_models/home_viewmodel.dart/post_viewmodel.dart';
import 'package:get/get.dart';

class FeedBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(PostVM());
  }
}
