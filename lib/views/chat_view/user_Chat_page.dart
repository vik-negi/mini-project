// import 'package:emoji_picker_flutter/emoji_picker_flutter.dart';
// import 'package:evika/data/user_chat.dart';
// import 'package:evika/models/user/user_chat_model.dart';
// import 'package:evika/utils/widgets/MoreOptionToSend.dart';
// import 'package:evika/utils/widgets/OtherSideMsg.dart';
// import 'package:evika/utils/widgets/OwnMsgCard.dart';
// import 'package:evika/utils/widgets/PopUpMenuBtn.dart';
// import 'package:evika/utils/widgets/custom_user_chat.dart';
// import 'package:evika/views/Individual%20_user_details.dart';
// import 'package:flutter/material.dart';

// // import 'package:intl/intl.dart';
// // import 'package:socket_io_client/socket_io_client.dart' as io;
// class MoreOption {
//   final String name;
//   final IconData iconName;
//   final Color color;

//   MoreOption({required this.name, required this.iconName, required this.color});
// }

// class MessageModel {
//   String type;
//   String msg;
//   String time;
//   MessageModel({required this.msg, required this.type, required this.time});
// }

// class UserChatPage extends StatefulWidget {
//   const UserChatPage({
//     Key? key,
//     required this.userModel,
//     required this.sourceChat,
//     this.isWeb,
//   }) : super(key: key);
//   final UserChatModel userModel;
//   final UserChatModel sourceChat;
//   final bool? isWeb;

//   @override
//   State<UserChatPage> createState() => _UserChatPageState();
// }

// class _UserChatPageState extends State<UserChatPage> {
//   List<String> userChatMenuBtn = [
//     "view contact",
//     "Media, links, and docs",
//     "Search",
//     "Mute notifications",
//     "Disappering messages",
//     "Wallpaper",
//     "More"
//   ];
//   List<MoreOption> moreOptionsToSend = [
//     MoreOption(
//         name: "Document",
//         iconName: Icons.insert_drive_file,
//         color: Colors.indigo),
//     MoreOption(
//         name: "Document",
//         iconName: Icons.insert_drive_file,
//         color: Colors.indigo),
//     MoreOption(name: "Camera", iconName: Icons.camera_alt, color: Colors.pink),
//     MoreOption(
//         name: "Audio", iconName: Icons.headset_rounded, color: Colors.orange),
//     MoreOption(
//         name: "Payment", iconName: Icons.currency_rupee, color: Colors.teal),
//     MoreOption(
//         name: "Location", iconName: Icons.location_pin, color: Colors.green),
//     MoreOption(name: "Contact", iconName: Icons.person, color: Colors.blue)
//   ];
//   List<MoreOption> moreOptionsToSendWeb = [
//     MoreOption(name: "Contact", iconName: Icons.person, color: Colors.blue),
//     MoreOption(
//         name: "Document",
//         iconName: Icons.insert_drive_file,
//         color: Colors.indigo),
//     MoreOption(
//         name: "Camera", iconName: Icons.photo_camera, color: Colors.pink),
//     MoreOption(
//         name: "Sticker", iconName: Icons.memory, color: Colors.blue.shade600),
//     MoreOption(
//         name: "Photos & Video", iconName: Icons.photo, color: Colors.purple),
//   ];

//   List<MessageModel> messages = [];

//   bool showEnojiOption = false;
//   bool sendButton = false;
//   final ScrollController _scrollController = ScrollController();
//   FocusNode focusNode = FocusNode();
//   final TextEditingController _txtController = TextEditingController();
//   // late io.Socket socket;
//   @override
//   void initState() {
//     super.initState();
//     // initSocket();
//     focusNode.addListener(() {
//       if (focusNode.hasFocus) {
//         setState(() {
//           showEnojiOption = false;
//         });
//       }
//     });
//   }

//   // void initSocket() {
//   //   socket = io.io(
//   //       // "http://172.11.11.137:5000" //college wifi
//   //       // "http://192.168.100.113:5000" //wifi
//   //       "http://192.168.43.65:5000" // mobile internet
//   //       ,
//   //       <String, dynamic>{
//   //         "transports": ["websocket"],
//   //         "autoConnect": false,
//   //       });
//   //   socket.connect();
//   //   socket.onConnect((data) {
//   //     print("connected");
//   //     socket.onConnect((msg) {
//   //       print(msg);
//   //       setMessage("destination", msg["msg"]);
//   //     });
//   //   });
//   //   print(socket.connected);
//   //   socket.emit("signin", widget.sourceChat.id);
//   // }

//   // void sendMsg(String msg, int sourceId, int targetId) {
//   //   setMessage("source", msg);
//   //   socket
//   //       .emit("msg", {"msg": msg, "sourceId": sourceId, "targetId": targetId});
//   // }

//   // String time = DateFormat.jm().format(DateTime.now()).toString();
//   // void setMessage(String type, String msg) {
//   //   MessageModel messageModel = MessageModel(
//   //       msg: msg,
//   //       type: type,
//   //       time: DateTime.now().toString().substring(10, 16));
//   //   setState(() {
//   //     setState(() {
//   //       messages.add(messageModel);
//   //     });
//   //   });
//   // }

//   @override
//   Widget build(BuildContext context) {
//     return Stack(
//       children: [
//         Image.asset(
//           "assets/img/whatsappbg.png",
//           width: MediaQuery.of(context).size.width,
//           height: MediaQuery.of(context).size.height,
//           fit: BoxFit.cover,
//         ),
//         Scaffold(
//           backgroundColor: Colors.transparent,
//           appBar: userChatAppBar(context),
//           body: SizedBox(
//             width: MediaQuery.of(context).size.width,
//             height: MediaQuery.of(context).size.height,
//             child: WillPopScope(
//               child: Column(
//                 children: [
//                   Expanded(
//                     child: ListView.builder(
//                       controller: _scrollController,
//                       // itemCount: messages.length,
//                       itemCount: 5,
//                       itemBuilder: (context, i) {
//                         if (i == messages.length) {
//                           return Container(
//                             height: 60,
//                           );
//                         }
//                         if (messages[i].type == "source") {
//                           return OwnMsgCard(
//                               text: messages[i].msg, time: messages[i].time);
//                         } else {
//                           return OtherSideMsgCard(
//                               text: messages[i].msg, time: messages[i].time);
//                         }
//                       },
//                     ),
//                   ),
//                   bottomTextMessaging(context)
//                 ],
//               ),
//               onWillPop: () {
//                 if (showEnojiOption == true) {
//                   setState(() {
//                     showEnojiOption = false;
//                   });
//                 } else {
//                   Navigator.pop(context);
//                 }
//                 return Future.value(false);
//               },
//             ),
//           ),
//         ),
//       ],
//     );
//   }

//   Align bottomTextMessaging(BuildContext context) {
//     return Align(
//       alignment: Alignment.bottomCenter,
//       child: SizedBox(
//         // height: widget.isWeb! ? 70 : 500,
//         // width: widget.isWeb!
//         //     ? MediaQuery.of(context).size.width - 400
//         //     : MediaQuery.of(context).size.width - 55,
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.end,
//           children: [
//             Container(
//               padding: const EdgeInsets.only(left: 2.0, right: 2),
//               color:
//                   widget.isWeb! ? const Color(0xfff0f2f5) : Colors.transparent,
//               child: Row(
//                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                 children: [
//                   widget.isWeb!
//                       ? IconButton(
//                           icon: const Icon(
//                             Icons.emoji_emotions_outlined,
//                             size: 28,
//                             color: Colors.grey,
//                           ),
//                           onPressed: () {
//                             focusNode.unfocus();
//                             focusNode.canRequestFocus = false;
//                             setState(() {
//                               showEnojiOption = !showEnojiOption;
//                             });
//                           },
//                         )
//                       : const SizedBox(),
//                   widget.isWeb!
//                       ? IconBtn(
//                           icon: Icons.attach_file,
//                           iconOnPress: () {
//                             showModalBottomSheet(
//                               elevation: 0,
//                               barrierColor: Colors.transparent,
//                               backgroundColor: Colors.transparent,
//                               anchorPoint: const Offset(0, 0),
//                               context: context,
//                               builder: (builder) {
//                                 return const MoreOptionsToSend();
//                                 // return MotsWeb(list: moreOptionsToSendWeb);
//                               },
//                             );
//                           },
//                         )
//                       : const SizedBox(),
//                   SizedBox(
//                     width: widget.isWeb!
//                         ? MediaQuery.of(context).size.width - 535
//                         : MediaQuery.of(context).size.width - 55,
//                     child: Card(
//                       margin:
//                           const EdgeInsets.only(left: 4, right: 2, bottom: 6),
//                       shape: RoundedRectangleBorder(
//                           borderRadius: widget.isWeb!
//                               ? BorderRadius.circular(10)
//                               : BorderRadius.circular(25)),
//                       child: TextFormField(
//                         onChanged: (value) {
//                           value.isNotEmpty
//                               ? setState(() {
//                                   sendButton = true;
//                                 })
//                               : setState(() {
//                                   sendButton = false;
//                                 });
//                         },
//                         controller: _txtController,
//                         focusNode: focusNode,
//                         textAlignVertical: TextAlignVertical.center,
//                         maxLines: 5,
//                         minLines: 1,
//                         decoration: InputDecoration(
//                           border: InputBorder.none,
//                           hintText: "Message",
//                           hintStyle: const TextStyle(fontSize: 18),
//                           prefixIcon: !widget.isWeb!
//                               ? IconButton(
//                                   icon: const Icon(
//                                     Icons.emoji_emotions_outlined,
//                                     size: 28,
//                                     color: Colors.grey,
//                                   ),
//                                   onPressed: () {
//                                     focusNode.unfocus();
//                                     focusNode.canRequestFocus = false;
//                                     setState(() {
//                                       showEnojiOption = !showEnojiOption;
//                                     });
//                                   },
//                                 )
//                               : null,
//                           contentPadding: widget.isWeb!
//                               ? const EdgeInsets.symmetric(
//                                   vertical: 10, horizontal: 15)
//                               : const EdgeInsets.all(5),
//                           suffixIcon: !widget.isWeb!
//                               ? Padding(
//                                   padding: const EdgeInsets.only(right: 10.0),
//                                   child: Row(
//                                     mainAxisSize: MainAxisSize.min,
//                                     children: [
//                                       SizedBox(
//                                         width:
//                                             MediaQuery.of(context).size.width *
//                                                 0.09,
//                                         child: IconBtn(
//                                           icon: Icons.attach_file,
//                                           iconOnPress: () {
//                                             showModalBottomSheet(
//                                               backgroundColor:
//                                                   Colors.transparent,
//                                               context: context,
//                                               builder: (builder) {
//                                                 return const MoreOptionsToSend();
//                                                 // return Mots(
//                                                 //   height: 380,
//                                                 //   // list: moreOptionsToSend,
//                                                 //   borderR: 15,
//                                                 // );
//                                               },
//                                             );
//                                           },
//                                         ),
//                                       ),
//                                       SizedBox(
//                                         width:
//                                             MediaQuery.of(context).size.width *
//                                                 0.09,
//                                         child: const IconBtn(
//                                           icon: Icons.currency_rupee,
//                                         ),
//                                       ),
//                                       SizedBox(
//                                         width:
//                                             MediaQuery.of(context).size.width *
//                                                 0.09,
//                                         child: const IconBtn(
//                                           icon: Icons.camera_alt,
//                                         ),
//                                       ),
//                                     ],
//                                   ),
//                                 )
//                               : null,
//                         ),
//                       ),
//                     ),
//                   ),
//                   Padding(
//                     padding: const EdgeInsets.only(bottom: 6.0),
//                     child: CircleAvatar(
//                       radius: 24.5,
//                       backgroundColor: !widget.isWeb!
//                           ? const Color(0xff128c7E)
//                           : const Color.fromARGB(128, 255, 255, 255),
//                       child: IconButton(
//                           onPressed: () {
//                             if (sendButton) {
//                               // _scrollController.animateTo(
//                               //     _scrollController.position.maxScrollExtent,
//                               //     duration: const Duration(milliseconds: 300),
//                               //     curve: Curves.easeOut);
//                               // sendMsg(_txtController.text, widget.sourceChat.id,
//                               //     widget.userModel.id);
//                               // _txtController.clear();
//                               setState(() {
//                                 sendButton = false;
//                               });
//                             }
//                           },
//                           icon: Icon(sendButton ? Icons.send : Icons.mic,
//                               color: widget.isWeb!
//                                   ? Colors.grey.shade800
//                                   : Colors.white,
//                               size: sendButton ? 23 : 25)),
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//             showEnojiOption ? emojiOptions() : Container(),
//           ],
//         ),
//       ),
//     );
//   }

//   SizedBox emojiOptions() {
//     return SizedBox(
//       height: 250,
//       child: EmojiPicker(
//         onEmojiSelected: (category, emoji) {
//           setState(() {
//             _txtController.text = _txtController.text + emoji.emoji;
//           });
//         },
//         onBackspacePressed: () {},
//         config: const Config(
//           columns: 8,
//           // emojiSizeMax: 32 * (Platform.isIOS ? 1.30 : 1.0), // Issue: https://github.com/flutter/flutter/issues/28894
//           verticalSpacing: 0,
//           horizontalSpacing: 0,
//           gridPadding: EdgeInsets.zero,
//           initCategory: Category.RECENT,
//           bgColor: Color(0xFFF2F2F2),
//           indicatorColor: Colors.blue,
//           iconColor: Colors.grey,
//           iconColorSelected: Colors.blue,
//           // progressIndicatorColor: Colors.blue,
//           backspaceColor: Colors.blue,
//           skinToneDialogBgColor: Colors.white,
//           skinToneIndicatorColor: Colors.grey,
//           enableSkinTones: true,
//           showRecentsTab: true,
//           recentsLimit: 28,
//           noRecents: Text(
//             'No Recents',
//             style: TextStyle(fontSize: 20, color: Colors.black26),
//             textAlign: TextAlign.center,
//           ),
//           tabIndicatorAnimDuration: kTabScrollDuration,
//           categoryIcons: CategoryIcons(),
//           buttonMode: ButtonMode.MATERIAL,
//         ),
//       ),
//     );
//   }

//   AppBar userChatAppBar(BuildContext context) {
//     return AppBar(
//       backgroundColor: widget.isWeb!
//           ? const Color(0xfff0f2f5)
//           : Theme.of(context).primaryColor,
//       leadingWidth: widget.isWeb! ? 55 : 75,
//       toolbarHeight: widget.isWeb! ? 65 : 55,
//       titleSpacing: 0,
//       elevation: 0,
//       leading: Padding(
//         padding: widget.isWeb!
//             ? const EdgeInsets.only(right: 1, left: 1, top: 10, bottom: 10)
//             // only(left: 4.0)
//             : const EdgeInsets.only(left: 0),
//         child: InkWell(
//           onTap: () {
//             if (widget.isWeb == false) {
//               Navigator.pop(context);
//             }
//           },
//           child:
//               Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
//             !widget.isWeb!
//                 ? SizedBox(
//                     width: 25,
//                     child: IconButton(
//                       onPressed: () {},
//                       icon: Icon(
//                         Icons.arrow_back,
//                       ),
//                     ),
//                   )
//                 : Container(width: 1),
//             CircularAvatarWidget(
//               isContactPage: true,
//               isChatPage: false,
//               userChatModel: userChatModelList[0],
//               radiusOfAvatar: 20,
//             ),
//           ]),
//         ),
//       ),
//       title: userChatTitle(),
//       actions: [
//         if (!widget.isWeb!)
//           IconButton(onPressed: () {}, icon: const Icon(Icons.videocam)),
//         !widget.isWeb!
//             ? IconButton(onPressed: () {}, icon: const Icon(Icons.call))
//             : IconButton(
//                 onPressed: () {},
//                 icon: Icon(Icons.search,
//                     color:
//                         widget.isWeb! ? Colors.grey.shade800 : Colors.white)),
//         PopupMenuBtn(items: userChatMenuBtn)
//       ],
//     );
//   }

//   Padding userChatTitle() {
//     return Padding(
//       padding: !widget.isWeb!
//           ? EdgeInsets.all(8)
//           : EdgeInsets.only(left: 8, top: 8, bottom: 8, right: 8),
//       child: InkWell(
//         onTap: () {
//           Navigator.push(
//               context,
//               MaterialPageRoute(
//                   builder: (context) =>
//                       IndividualUserDetails(userChatModel: widget.userModel)));
//         },
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Text(
//               widget.userModel.name,
//               style: TextStyle(
//                   fontSize: 18.5,
//                   fontWeight: widget.isWeb! ? FontWeight.w100 : FontWeight.bold,
//                   color: widget.isWeb! ? Colors.black : Colors.white),
//             ),
//             Text(
//               widget.isWeb!
//                   ? "Click here for contact info"
//                   : "Last seen today at 5:04",
//               style: TextStyle(
//                   fontSize: 13,
//                   fontWeight: widget.isWeb! ? FontWeight.w200 : FontWeight.w400,
//                   color: widget.isWeb! ? Colors.black : Colors.white),
//             ),
//           ],
//         ),
//       ),
//     );
//   }

//   // Widget sendFiles(){
//   //   return ;
//   // }
// }

// class IconBtn extends StatelessWidget {
//   const IconBtn({
//     Key? key,
//     this.iconColor,
//     this.iconSize,
//     required this.icon,
//     this.iconOnPress,
//   }) : super(key: key);

//   // final List<MoreOption> moreOptionsToSend;
//   final IconData icon;
//   final Color? iconColor;
//   final double? iconSize;
//   final void Function()? iconOnPress;

//   @override
//   Widget build(BuildContext context) {
//     return IconButton(
//         onPressed: iconOnPress ?? () {},
//         icon: Icon(
//           icon,
//           color: iconColor ?? Colors.grey,
//           size: iconSize ?? 24,
//         ));
//   }
// }
