import 'package:evika/models/chat/chat_model.dart';
import 'package:evika/models/chat/chat_page_model.dart';

abstract class LoginApiInterface {
  Future<Map<String, dynamic>>? userSignin(Map data);
  Future<Map<String, dynamic>>? userSignup(Map data);
}

abstract class PostApiInterface {
  Future<Map<String, dynamic>>? getAllPosts();
  Future<Map<String, dynamic>>? likePost(String id);
}

abstract class CommoApiInterface {
  Future<List<String>>? userLikedPosts();
}

abstract class ChatApiInterface {
  Future<Map<String, dynamic>>? getUserChat(String receiverUserId);
  Future<Map<String, dynamic>>? sendMessageToUser(
      String receiverUserId, String message);
  Future<Map<String, dynamic>>? getAllChatUsers();
}
