import 'package:evika/utils/user_functionality.dart';
import 'package:get/get.dart';

class NavigationController extends GetxController {
  RxInt index = 0.obs;
  bool isUserLoggedIn = false;

  void changeIndex(int index) {
    this.index.value = index;
  }

  @override
  void onInit() async {
    super.onInit();
    isUserLoggedIn = await UserFunctions.isUserLoggedInFun();
    update();
  }
}
