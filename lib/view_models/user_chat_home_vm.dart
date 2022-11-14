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
}
