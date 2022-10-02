import 'package:get/get.dart';

class NavigationController extends GetxController {
  RxInt index = 0.obs;

  void changeIndex(int index) {
    this.index.value = index;
  }
}
