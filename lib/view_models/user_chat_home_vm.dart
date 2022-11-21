import 'package:evika/models/chat/chat_page_model.dart';
import 'package:evika/repositories/chat_repo/chat_repo_imp.dart';
import 'package:get/get.dart';

class UserChatHomeVM extends GetxController {
  List<ChatUsers> chatUsersList = [];
  bool loading = false;
  ChatRepoImp chatRepoImp = ChatRepoImp();

  void getAllChatUsers() async {
    loading = true;
    update();
    List<ChatUsers> chatList = await chatRepoImp.getAllChatUsers();
    chatUsersList = chatList;
    loading = false;
    update();
  }

  @override
  onInit() {
    getAllChatUsers();
    super.onInit();
  }

  String convertDateTime(DateTime dateTime) {
    print("ttttttttttttttt");
    print("dateTime : $dateTime");
    dateTime = dateTime.toUtc().toLocal();
    String date = dateTime.toString().substring(8, 10);
    String month = dateTime.toString().substring(5, 7);
    String year = dateTime.toString().substring(2, 4);
    String time = dateTime.toString().substring(11, 16);
    // function to convert time in 12 hours format
    String hour = time.substring(0, 2);
    String min = time.substring(3, 5);
    String ampm = "AM";
    if (int.parse(hour) > 12) {
      hour = (int.parse(hour) - 12).toString();
      ampm = "PM";
    }
    return "$hour:$min $ampm";
  }
}
