import 'package:get/get.dart';
import 'package:vibration/vibration.dart';

class DescriptionVM extends GetxController {
  bool notificationSet = false;
  String? imageTag;

  @override
  void onInit() {
    super.onInit();
    getParameters();
  }

  void toggleNotification() async {
    notificationSet = !notificationSet;
    if (await Vibration.hasVibrator() ?? false) {
      Vibration.vibrate(duration: 100);
    }
    update();
  }

  getParameters() {
    var tag = Get.parameters['tag'];
    if (tag != null) {
      imageTag = tag;
    }
  }
}
