import 'package:evika/models/chat/chat_model.dart';
import 'package:evika/models/chat/chat_page_model.dart';

abstract class ChatRepo {
  Future<List<ChatModel>>? getUserChat(String receiverUserId);
  Future<Map<String, dynamic>>? sendMessageToUser(
      String receiverUserId, String message);
  Future<List<ChatUsers>> getAllChatUsers();
  Future<Map<String, dynamic>> deleteChat(String chatId);
  Future<Map<String, dynamic>> functionality(String chatId, Map body);
}
