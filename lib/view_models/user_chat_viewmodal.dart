import 'dart:convert';

import 'package:evika/repositories/chat_repo/chat_repo_imp.dart';
import 'package:evika/views/chat_view/user_Chat_page.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:socket_io_client/socket_io_client.dart' as io;
import 'package:evika/models/chat/chat_model.dart';
import "package:evika/data/remote/api_services/post_api_service.dart" as api;
// import 'package:web_socket_channel/io.dart';
// import 'package:web_socket_channel/status.dart' as status;

class UserChatVM extends GetxController {
  List<String> userChatMenuBtn = [
    "view contact",
    "Media, links, and docs",
    "Search",
    "Mute notifications",
    "Disappering messages",
    "Wallpaper",
    "More"
  ];
  List<MoreOption> moreOptionsToSend = [
    MoreOption(
        name: "Document",
        iconName: Icons.insert_drive_file,
        color: Colors.indigo),
    MoreOption(
        name: "Document",
        iconName: Icons.insert_drive_file,
        color: Colors.indigo),
    MoreOption(name: "Camera", iconName: Icons.camera_alt, color: Colors.pink),
    MoreOption(
        name: "Audio", iconName: Icons.headset_rounded, color: Colors.orange),
    MoreOption(
        name: "Payment", iconName: Icons.currency_rupee, color: Colors.teal),
    MoreOption(
        name: "Location", iconName: Icons.location_pin, color: Colors.green),
    MoreOption(name: "Contact", iconName: Icons.person, color: Colors.blue)
  ];
  List<MoreOption> moreOptionsToSendWeb = [
    MoreOption(name: "Contact", iconName: Icons.person, color: Colors.blue),
    MoreOption(
        name: "Document",
        iconName: Icons.insert_drive_file,
        color: Colors.indigo),
    MoreOption(
        name: "Camera", iconName: Icons.photo_camera, color: Colors.pink),
    MoreOption(
        name: "Sticker", iconName: Icons.memory, color: Colors.blue.shade600),
    MoreOption(
        name: "Photos & Video", iconName: Icons.photo, color: Colors.purple),
  ];

  List<MessageModel> messages = [];

  bool showEnojiOption = false;
  bool sendButton = false;
  final ScrollController scrollController = ScrollController();
  FocusNode focusNode = FocusNode();
  final TextEditingController txtController = TextEditingController();
  late io.Socket socket;
  String? senderUserId;

  @override
  void onInit() {
    super.onInit();
    print("isit chala");
    initSocket();
    // connectSocket();
    getUserChat();
    focusNode.addListener(() {
      if (focusNode.hasFocus) {
        showEnojiOption = false;
      }
      update();
    });
  }

  // var channel = IOWebSocketChannel.connect(Uri.parse('http://localhost:8000'));

  // final io.Socket socketIo = io.io('http://192.168.99.65:8000',
  //     io.OptionBuilder().setTransports(['websocket']).build());
  // connectSocket() {
  //   channel.stream.listen((message) {
  //     print(message);
  //   });
  //   socketIo.onConnect((data) {
  //     print("connected");
  //   });
  //   socketIo.onConnectError((data) {
  //     print("error $data");
  //   });
  //   socketIo.onDisconnect((data) {
  //     print("disconnected");
  //   });
  // }

  void initSocket() {
    print("init socket");
    socket = io.io(
        // "http://172.11.11.137:5000" //college wifi
        // "http://192.168.100.113:5000" //wifi
        // "http://192.168.43.65:5000", // mobile internet
        // "http://192.168.43.65:8000", // mobile internet
        "http://192.168.99.65:5000", // mobile internet
        // "http://172.11.10.136:8000",
        // "http://127.0.0.1:8000",

        // api.baseUrl,
        <String, dynamic>{
          "transports": ["websocket"],
          "autoConnect": false
        });
    socket.connect();
    socket.onConnect((data) {
      print("connected");
      socket.onConnect((message) {
        print("msg : $message");
        setMessage("destination", message["msg"]);
      });
    });
    socket.onDisconnect((_) => print('Connection Disconnection'));
    socket.onConnectError((err) => print(err));
    print("socket connection : ${socket.connected}");
    socket.emit("signin", senderUserId);
  }

  void sendMessage(String msg, String sourceId, String targetId) {
    setMessage("source", msg);
    socket
        .emit("msg", {"msg": msg, "sourceId": sourceId, "targetId": targetId});
  }

  String time = DateFormat.jm().format(DateTime.now()).toString();
  void setMessage(String type, String msg) {
    MessageModel messageModel = MessageModel(
        msg: msg,
        type: type,
        time: DateTime.now().toString().substring(10, 16));
    messages.add(messageModel);
    update();
  }

  ChatRepoImp chatRepoImp = ChatRepoImp();
  List<ChatModel> individualchats = [];

  void getUserChat() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    // String? resId = await SharedPrefs().getString("receiverUserId");
    String receiverUserId = Get.arguments["receiverUserId"];
    // String receiverUserId = "636fad6c94ce27828d7cec4e";
    senderUserId = sharedPreferences.getString("userId")!;
    // receiverUserId = resId;
    update();
    // receiverUserId = "636fad6c94ce27828d7cec4e";
    List<ChatModel>? chatModelList =
        await chatRepoImp.getUserChat(receiverUserId);
    print("chat list : $chatModelList");
    individualchats = chatModelList ?? [];
    update();
  }

  void sendMessageToUser() async {
    ChatModel chatModel = ChatModel(
        senderUserId: senderUserId!,
        receiverUserId: Get.arguments["receiverUserId"],
        message: txtController.text,
        createdAt: DateTime.now().toString(),
        id: senderUserId!,
        isDeleted: false,
        isPinned: false,
        isRead: true,
        isReceived: false,
        isSent: true,
        messageType: "text",
        recieveBy: "aaa",
        sendBy: "user");
    print("lllllllllllllll");
    print(individualchats.length);
    individualchats.add(chatModel);
    update();
    String receiverUserId = Get.arguments["receiverUserId"];
    String message = txtController.text;
    txtController.clear();
    print("message : $message");
    print("receiverUserId : $receiverUserId");
    Map<String, dynamic> res =
        await chatRepoImp.sendMessageToUser(receiverUserId, message);
    print("res : $res");
    if (res.isNotEmpty && res != {}) {
      ChatModel newChat = ChatModel.fromJson(jsonEncode(res));
      individualchats.removeAt(individualchats.length - 1);
      individualchats.add(newChat);
      update();
    }
    if (res["status"] == "success") {
      Get.snackbar("success", "Message sent successfully");
    } else {
      Get.snackbar("error", "Message not sent");
    }
    update();
  }

  String getDateTime(String datetime) {
    return DateFormat("h:mma").format(DateTime.parse(datetime));
  }

  @override
  void onClose() {
    socket.disconnect();
    socket.dispose();
    super.dispose();
  }
}
