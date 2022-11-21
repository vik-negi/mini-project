import 'dart:convert';

import 'package:evika/models/chat/chat_page_model.dart';
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
  bool showBottomNavigation = false;

  bool showEnojiOption = false;
  String selectedChatId = "";
  int? selectedIndex;
  bool sendButton = false;
  String frowardedText = "";
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

  void deleteChat(String chatId) async {
    individualchats.removeWhere((element) => element.id == chatId);
    Map<String, dynamic>? deleteMessage = await chatRepoImp.deleteChat(chatId);
    update();
    print("chat list : $deleteMessage");
    if (deleteMessage == {} || deleteMessage["status"] == "failed") {
      Get.snackbar("Message Deleted",
          deleteMessage["message"] ?? "Error in Deleting Message");
    }
    if (deleteMessage["status"] == "success") {
      Get.snackbar("Success", "Message Deleted");
    }
    getUserChat();
    update();
  }

  void functionality(String chatId, String type, String trueFalse) async {
    Map body = {type: trueFalse};
    Map<String, dynamic>? deleteMessage =
        await chatRepoImp.functionality(chatId, body);
    update();
    print("chat list : $deleteMessage");
    if (deleteMessage == {} || deleteMessage["status"] == "failed") {
      Get.snackbar("Message Deleted",
          deleteMessage["message"] ?? "Error in Deleting Message");
    }
    if (deleteMessage["status"] == "success") {
      Get.snackbar("Success", "Message Deleted");
    }
    getUserChat();
    update();
  }

  void forwardToAll(List<ChatUsers> forwardedTo) async {
    for (var element in forwardedTo) {
      sendMessageToUser(receiverId: element.receiverId);
    }
  }

  void sendMessageToUser({String? receiverId}) async {
    ChatModel chatModel = ChatModel(
        senderUserId: senderUserId!,
        receiverUserId:
            receiverId != null ? receiverId : Get.arguments["receiverUserId"],
        message: txtController.text,
        createdAt: DateTime.now(),
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
    receiverId == null ? individualchats.add(chatModel) : null;
    update();
    String receiverUserId =
        receiverId != null ? receiverId : Get.arguments["receiverUserId"];
    String message = receiverId != null ? frowardedText : txtController.text;
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
    receiverId = null;
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
