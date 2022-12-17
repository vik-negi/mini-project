import 'dart:convert';

import 'package:evika/data/remote/api_services/chat_api_Services.dart';
import 'package:evika/models/chat/chat_model.dart';
import 'package:evika/models/chat/chat_page_model.dart';
import 'package:evika/repositories/chat_repo/chat_repo.dart';
import 'package:flutter/cupertino.dart';

class ChatRepoImp extends ChatRepo {
  ChatApiServices chatApiServices = ChatApiServices();
  @override
  Future<List<ChatModel>>? getUserChat(String receiverUserId) async {
    Map<String, dynamic>? res =
        await chatApiServices.getUserChat(receiverUserId);
    List<ChatModel> chatUsers = [];
    debugPrint("common Repo Imp $res");
    if (res != null && res.isNotEmpty) {
      for (var i in res["data"]) {
        chatUsers.add(ChatModel.fromJson(jsonEncode(i)));
      }
      return chatUsers;
    }
    return [];
  }

  @override
  Future<List<ChatUsers>> getAllChatUsers() async {
    Map<String, dynamic>? res = await chatApiServices.getAllChatUsers();
    List<ChatUsers> chatUsers = [];
    debugPrint("getAllChatUsers response : $res");
    if (res != null && res.isNotEmpty) {
      for (var i in res["data"]) {
        chatUsers.add(ChatUsers.fromJson(jsonEncode(i)));
      }
      return chatUsers;
    }
    return [];
  }

  @override
  Future<Map<String, dynamic>> sendMessageToUser(
      String receiverUserId, String message) async {
    Map<String, dynamic>? res =
        await chatApiServices.sendMessageToUser(receiverUserId, message);
    debugPrint("send message Repo Imp $res");
    if (res != null && res.isNotEmpty) {
      return res["data"];
    }
    return {};
  }

  @override
  Future<Map<String, dynamic>> deleteChat(String chatId) async {
    Map<String, dynamic>? res = await chatApiServices.deleteChat(chatId);
    debugPrint("chat detele Repo Imp $res");
    if (res != null && res.isNotEmpty) {
      return res;
    }
    return {};
  }

  @override
  Future<Map<String, dynamic>> functionality(String chatId, Map body) async {
    Map<String, dynamic>? res =
        await chatApiServices.functionality(chatId, body);
    debugPrint("chat functionality Repo Imp $res");
    if (res != null && res.isNotEmpty) {
      return res;
    }
    return {};
  }
}
