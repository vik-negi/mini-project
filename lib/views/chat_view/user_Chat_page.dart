import 'package:emoji_picker_flutter/emoji_picker_flutter.dart';
import 'package:evika/data/user_chat.dart';
import 'package:evika/models/user/user_chat_model.dart';
import 'package:evika/utils/sharedPreferenced.dart';
import 'package:evika/utils/widgets/MoreOptionToSend.dart';
import 'package:evika/utils/widgets/OtherSideMsg.dart';
import 'package:evika/utils/widgets/OwnMsgCard.dart';
import 'package:evika/utils/widgets/PopUpMenuBtn.dart';
import 'package:evika/utils/widgets/chat/bottomTextMessaging.dart';
import 'package:evika/utils/widgets/custom_user_chat.dart';
import 'package:evika/view_models/user_chat_home_vm.dart';
import 'package:evika/view_models/user_chat_viewmodal.dart';
import 'package:evika/views/Individual%20_user_details.dart';
import 'package:evika/views/chat_view/forward_message_view.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

import 'package:intl/intl.dart';
import 'package:socket_io_client/socket_io_client.dart' as io;
import "package:evika/data/remote/api_services/post_api_service.dart" as api;

class MoreOption {
  final String name;
  final IconData iconName;
  final Color color;

  MoreOption({required this.name, required this.iconName, required this.color});
}

class MessageModel {
  String type;
  String msg;
  String time;
  MessageModel({required this.msg, required this.type, required this.time});
}

class UserChatPage extends StatefulWidget {
  const UserChatPage({
    Key? key,
    required this.receiverId,
    required this.i,
    this.isWeb,
  }) : super(key: key);
  final String receiverId;
  final bool? isWeb;
  final int i;

  @override
  State<UserChatPage> createState() => _UserChatPageState();
}

class _UserChatPageState extends State<UserChatPage> {
  // @override
  // void initState() {
  //   super.initState();
  //   print("isit chala");
  //   initSocket();
  //   focusNode.addListener(() {
  //     if (focusNode.hasFocus) {
  //       setState(() {
  //         showEnojiOption = false;
  //       });
  //     }
  //   });
  // }
  UserChatVM vm = Get.put(UserChatVM());
  UserChatHomeVM chatHomeVM = Get.put(UserChatHomeVM());

  @override
  Widget build(BuildContext context) {
    return GetBuilder<UserChatVM>(builder: (vm) {
      return GestureDetector(
        onTap: () {
          if (vm.focusNode.hasFocus) {
            vm.focusNode.unfocus();
          }
          if (vm.showEnojiOption) {
            vm.showEnojiOption = false;
          }
          vm.showBottomNavigation = false;
          vm.update();
        },
        child: Stack(
          children: [
            // Image.asset(
            //   "assets/img/whatsappbg.png",
            //   width: MediaQuery.of(context).size.width,
            //   height: MediaQuery.of(context).size.height,
            //   fit: BoxFit.cover,
            // ),
            Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
              color: Colors.white.withOpacity(0.9),
            ),
            Scaffold(
              backgroundColor: Colors.transparent,
              appBar: userChatAppBar(context),
              body: SizedBox(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height,
                child: WillPopScope(
                  child: Column(
                    children: [
                      Expanded(
                        child: ListView.builder(
                          controller: vm.scrollController,
                          // itemCount: messages.length,
                          itemCount: vm.individualchats.length,
                          itemBuilder: (context, i) {
                            if (i == vm.individualchats.length) {
                              return Container(
                                height: 60,
                              );
                            }
                            if (vm.individualchats[i].receiverUserId !=
                                vm.senderUserId) {
                              return OwnMsgCard(
                                  chatId: vm.individualchats[i].id,
                                  text: vm.individualchats[i].message,
                                  index: i,
                                  time: vm.convertDateTime(
                                      vm.individualchats[i].createdAt));
                            } else {
                              print(
                                  "isit chala ${vm.individualchats[i].id}, ${vm.senderUserId}");
                              return OtherSideMsgCard(
                                  chatId: vm.individualchats[i].id,
                                  text: vm.individualchats[i].message,
                                  time: vm.convertDateTime(
                                      vm.individualchats[i].createdAt));
                              // if (vm.messages[i].type == "source") {
                              //   return OwnMsgCard(
                              //       text: vm.messages[i].msg,
                              //       time: vm.messages[i].time);
                              // } else {
                              //   return OtherSideMsgCard(
                              //       text: vm.messages[i].msg,
                              //       time: vm.messages[i].time);
                            }
                          },
                        ),
                      ),
                      vm.showBottomNavigation
                          ? const SizedBox(
                              height: 0,
                            )
                          : BottomTextMessaging()
                    ],
                  ),
                  onWillPop: () {
                    if (vm.showEnojiOption == true) {
                      setState(() {
                        vm.showEnojiOption = false;
                      });
                    } else {
                      Navigator.pop(context);
                    }
                    return Future.value(false);
                  },
                ),
              ),
              bottomNavigationBar: vm.showBottomNavigation
                  ? bottomNavigationMsgOption()
                  // Container(
                  //     height: 120,
                  //     width: Get.width,
                  //     child: Container(
                  //       height: 100,
                  //       width: Get.width * 0.8,
                  //       decoration: BoxDecoration(
                  //         color: Colors.white,
                  //         borderRadius: BorderRadius.circular(10),
                  //       ),
                  //       child: Column(
                  //         children: [
                  //           const SizedBox(
                  //             height: 10,
                  //           ),
                  //           Center(
                  //               child: Container(
                  //             height: 5,
                  //             width: 50,
                  //             decoration: BoxDecoration(
                  //               color: Colors.grey.shade800,
                  //               borderRadius: BorderRadius.circular(10),
                  //             ),
                  //           )),
                  //           Row(
                  //             children: [
                  //               IconButton(
                  //                   onPressed: () {
                  //                     vm.deleteChat(vm.selectedChatId);
                  //                     Navigator.pop(context);
                  //                   },
                  //                   icon: const Icon(Icons.delete)),
                  //               IconButton(
                  //                   onPressed: () {
                  //                     Navigator.pop(context);
                  //                   },
                  //                   icon: const Icon(Icons.delete)),
                  //             ],
                  //           ),
                  //         ],
                  //       ),
                  //     ),
                  //   )
                  : Container(
                      height: 0,
                    ),
            ),
          ],
        ),
      );
    });
  }

  AppBar userChatAppBar(BuildContext context) {
    return AppBar(
      backgroundColor: widget.isWeb!
          ? const Color(0xfff0f2f5)
          : Theme.of(context).primaryColor,
      leadingWidth: widget.isWeb! ? 55 : 75,
      toolbarHeight: widget.isWeb! ? 65 : 55,
      titleSpacing: 0,
      elevation: 0,
      leading: Padding(
        padding: widget.isWeb!
            ? const EdgeInsets.only(right: 1, left: 1, top: 10, bottom: 10)
            // only(left: 4.0)
            : const EdgeInsets.only(left: 0),
        child: InkWell(
          onTap: () {
            if (widget.isWeb == false) {
              Navigator.pop(context);
            }
          },
          child:
              Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
            !widget.isWeb!
                ? SizedBox(
                    width: 25,
                    child: IconButton(
                      onPressed: () {},
                      icon: const Icon(
                        Icons.arrow_back,
                      ),
                    ),
                  )
                : Container(width: 1),
            GetBuilder<UserChatHomeVM>(builder: (vm) {
              return CircularAvatarWidget(
                isContactPage: true,
                isChatPage: false,
                userChatModel: vm.chatUsersList[widget.i],
                radiusOfAvatar: 20,
              );
            })
          ]),
        ),
      ),
      title: userChatTitle(),
      actions: [
        if (!widget.isWeb!)
          IconButton(onPressed: () {}, icon: const Icon(Icons.videocam)),
        !widget.isWeb!
            ? IconButton(onPressed: () async {}, icon: const Icon(Icons.call))
            : IconButton(
                onPressed: () async {},
                icon: Icon(Icons.search,
                    color:
                        widget.isWeb! ? Colors.grey.shade800 : Colors.white)),
        GetBuilder<UserChatVM>(builder: (vm) {
          return PopupMenuBtn(items: vm.userChatMenuBtn);
        })
      ],
    );
  }

  GetBuilder userChatTitle() {
    return GetBuilder<UserChatHomeVM>(builder: (vm) {
      return Padding(
        padding: !widget.isWeb!
            ? const EdgeInsets.all(8)
            : const EdgeInsets.only(left: 8, top: 8, bottom: 8, right: 8),
        child: InkWell(
          onTap: () {
            Get.to(() => const IndividualUserDetails());
          },
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                vm.chatUsersList[widget.i].name,
                style: TextStyle(
                    fontSize: 18.5,
                    fontWeight:
                        widget.isWeb! ? FontWeight.w100 : FontWeight.bold,
                    color: widget.isWeb! ? Colors.black : Colors.white),
              ),
              Text(
                widget.isWeb!
                    ? "Click here for contact info"
                    : "Last seen today at ${vm.chatUsersList[widget.i].lastMessageTime}",
                style: TextStyle(
                    fontSize: 13,
                    fontWeight:
                        widget.isWeb! ? FontWeight.w200 : FontWeight.w400,
                    color: widget.isWeb! ? Colors.black : Colors.white),
              ),
            ],
          ),
        ),
      );
    });
  }

  // Widget sendFiles(){
  //   return ;
  // }
}

class bottomNavigationMsgOption extends StatelessWidget {
  bottomNavigationMsgOption({
    Key? key,
  }) : super(key: key);

  UserChatVM vm = Get.find();

  @override
  Widget build(BuildContext context) {
    return GetBuilder<UserChatVM>(builder: (vm) {
      return Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Container(
            height: 6,
          ),
          SizedBox(
              height: (56 * 7).toDouble(),
              child: Container(
                  alignment: Alignment.bottomCenter,
                  color: Colors.transparent,
                  child: Stack(
                    alignment: const Alignment(0, 0.5),
                    // alignment: Alignment.bottomCenter,
                    children: [
                      Container(
                        height: 56 * 7,
                      ),
                      Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(16),
                          color: const Color(0xff344955),
                        ),
                        width: Get.width * 0.95,
                        height: 56 * 6.3,
                        child: ListView(
                          physics: const NeverScrollableScrollPhysics(),
                          children: <Widget>[
                            Container(
                              height: 20,
                            ),
                            ListTile(
                              title: const Text(
                                "Copy",
                                style: TextStyle(color: Colors.white),
                              ),
                              leading: const Icon(
                                Icons.copy,
                                color: Colors.white,
                              ),
                              onTap: () {
                                Clipboard.setData(
                                  ClipboardData(
                                      text: vm
                                          .individualchats[vm.selectedIndex!]
                                          .message),
                                );
                                vm.showBottomNavigation = false;
                                vm.update();
                                Get.snackbar(
                                  "Copied",
                                  "",
                                  snackPosition: SnackPosition.BOTTOM,
                                  backgroundColor: Colors.white,
                                  colorText: Colors.black,
                                  maxWidth: 100,
                                  margin:
                                      EdgeInsets.only(bottom: Get.height * 0.1),
                                  borderRadius: 16,
                                  duration: const Duration(seconds: 2),
                                );
                              },
                            ),
                            ListTile(
                              title: const Text(
                                "React",
                                style: TextStyle(color: Colors.white),
                              ),
                              leading: const Icon(
                                Icons.add_reaction,
                                color: Colors.white,
                              ),
                              onTap: () {},
                            ),
                            ListTile(
                              title: const Text(
                                "Forword",
                                style: TextStyle(color: Colors.white),
                              ),
                              leading: const Icon(
                                CupertinoIcons.arrowshape_turn_up_right_fill,
                                color: Colors.white,
                              ),
                              onTap: () {
                                vm.showBottomNavigation = false;
                                vm.frowardedText = vm
                                    .individualchats[vm.selectedIndex!].message;
                                vm.update();
                                Get.to(() => const ForwardView());
                              },
                            ),
                            ListTile(
                              title: const Text(
                                "Starred",
                                style: TextStyle(color: Colors.white),
                              ),
                              leading: Icon(
                                vm.individualchats[vm.selectedIndex!].isPinned
                                    ? Icons.star
                                    : Icons.star_border,
                                color: vm.individualchats[vm.selectedIndex!]
                                        .isPinned
                                    ? Colors.yellow
                                    : Colors.white,
                              ),
                              onTap: () {
                                vm.functionality(
                                    vm.selectedChatId,
                                    "isPinned",
                                    vm.individualchats[vm.selectedIndex!]
                                            .isPinned
                                        ? "false"
                                        : "true");
                                vm.showBottomNavigation = false;
                                vm.update();
                              },
                            ),
                            ListTile(
                              title: const Text(
                                "Trash",
                                style: TextStyle(color: Colors.white),
                              ),
                              leading: const Icon(
                                Icons.delete_outline,
                                color: Colors.white,
                              ),
                              onTap: () {
                                vm.deleteChat(vm.selectedChatId);
                                vm.showBottomNavigation = false;
                                vm.update();
                              },
                            ),
                            ListTile(
                              title: const Text(
                                "Spam",
                                style: TextStyle(color: Colors.white),
                              ),
                              leading: const Icon(
                                Icons.error,
                                color: Colors.white,
                              ),
                              onTap: () {},
                            ),
                          ],
                        ),
                      ),
                      Positioned(
                        top: 0,
                        child: Container(
                          decoration: const BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(50)),
                            color: Colors.black,
                          ),
                          child: Container(
                            decoration: BoxDecoration(
                                borderRadius:
                                    const BorderRadius.all(Radius.circular(50)),
                                border: Border.all(
                                    // color: const Color(0xff344955),
                                    color: Colors.white.withOpacity(0.9),
                                    width: 10)),
                            child: Center(
                              child: ClipOval(
                                child: Image.network(
                                  "https://i.stack.imgur.com/S11YG.jpg?s=64&g=1",
                                  fit: BoxFit.cover,
                                  height: 45,
                                  width: 45,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ))),
          // Container(
          //   height: 56,
          //   color: const Color(0xff4a6572),
          // )
        ],
      );
    });
  }
}

class IconBtn extends StatelessWidget {
  const IconBtn({
    Key? key,
    this.iconColor,
    this.iconSize,
    required this.icon,
    this.iconOnPress,
  }) : super(key: key);

  // final List<MoreOption> moreOptionsToSend;
  final IconData icon;
  final Color? iconColor;
  final double? iconSize;
  final void Function()? iconOnPress;

  @override
  Widget build(BuildContext context) {
    return IconButton(
        onPressed: iconOnPress ?? () {},
        icon: Icon(
          icon,
          color: iconColor ?? Colors.grey,
          size: iconSize ?? 24,
        ));
  }
}
