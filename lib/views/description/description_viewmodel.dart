import 'package:get/get.dart';
import 'package:vibration/vibration.dart';

class DescriptionVM extends GetxController {
  bool notificationSet = false;

  void toggleNotification() async {
    notificationSet = !notificationSet;
    if (await Vibration.hasVibrator() ?? false) {
      Vibration.vibrate(duration: 100);
    }
    update();
  }
}
