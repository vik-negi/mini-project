import 'package:emoji_picker_flutter/emoji_picker_flutter.dart';
import 'package:evika/data/user_chat.dart';
import 'package:evika/models/user/user_chat_model.dart';
import 'package:evika/utils/sharedPreferenced.dart';
import 'package:evika/utils/widgets/MoreOptionToSend.dart';
import 'package:evika/utils/widgets/OtherSideMsg.dart';
import 'package:evika/utils/widgets/OwnMsgCard.dart';
import 'package:evika/utils/widgets/PopUpMenuBtn.dart';
import 'package:evika/utils/widgets/custom_user_chat.dart';
import 'package:evika/view_models/user_chat_home_vm.dart';
import 'package:evika/view_models/user_chat_viewmodal.dart';
import 'package:evika/views/Individual%20_user_details.dart';
import 'package:flutter/material.dart';
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
      return Stack(
        children: [
          Image.asset(
            "assets/img/whatsappbg.png",
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            fit: BoxFit.cover,
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
                                text: vm.individualchats[i].message,
                                time: vm.getDateTime(
                                    vm.individualchats[i].createdAt));
                          } else {
                            print(
                                "isit chala ${vm.individualchats[i].id}, ${vm.senderUserId}");
                            return OtherSideMsgCard(
                                text: vm.individualchats[i].message,
                                time: vm.getDateTime(
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
                    bottomTextMessaging(context)
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
          ),
        ],
      );
    });
  }

  Align bottomTextMessaging(BuildContext context) {
    return Align(
      alignment: Alignment.bottomCenter,
      child: GetBuilder<UserChatVM>(builder: (vm) {
        return SizedBox(
          // height: widget.isWeb! ? 70 : 500,
          // width: widget.isWeb!
          //     ? MediaQuery.of(context).size.width - 400
          //     : MediaQuery.of(context).size.width - 55,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Container(
                padding: const EdgeInsets.only(left: 2.0, right: 2),
                color: widget.isWeb!
                    ? const Color(0xfff0f2f5)
                    : Colors.transparent,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    widget.isWeb!
                        ? IconButton(
                            icon: const Icon(
                              Icons.emoji_emotions_outlined,
                              size: 28,
                              color: Colors.grey,
                            ),
                            onPressed: () {
                              vm.focusNode.unfocus();
                              vm.focusNode.canRequestFocus = false;
                              vm.showEnojiOption = !vm.showEnojiOption;
                              vm.update();
                            },
                          )
                        : const SizedBox(),
                    widget.isWeb!
                        ? IconBtn(
                            icon: Icons.attach_file,
                            iconOnPress: () {
                              showModalBottomSheet(
                                elevation: 0,
                                barrierColor: Colors.transparent,
                                backgroundColor: Colors.transparent,
                                anchorPoint: const Offset(0, 0),
                                context: context,
                                builder: (builder) {
                                  // return const MoreOptionsToSend();
                                  return MotsWeb(list: vm.moreOptionsToSendWeb);
                                },
                              );
                            },
                          )
                        : const SizedBox(),
                    SizedBox(
                      width: widget.isWeb!
                          ? MediaQuery.of(context).size.width - 535
                          : MediaQuery.of(context).size.width - 55,
                      child: Card(
                        margin:
                            const EdgeInsets.only(left: 4, right: 2, bottom: 6),
                        shape: RoundedRectangleBorder(
                            borderRadius: widget.isWeb!
                                ? BorderRadius.circular(10)
                                : BorderRadius.circular(25)),
                        child: TextFormField(
                          onChanged: (value) {
                            value.isNotEmpty
                                ? vm.sendButton = true
                                : vm.sendButton = false;
                            vm.update();
                          },
                          controller: vm.txtController,
                          focusNode: vm.focusNode,
                          textAlignVertical: TextAlignVertical.center,
                          maxLines: 5,
                          minLines: 1,
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            hintText: "Message",
                            hintStyle: const TextStyle(fontSize: 18),
                            prefixIcon: !widget.isWeb!
                                ? IconButton(
                                    icon: const Icon(
                                      Icons.emoji_emotions_outlined,
                                      size: 28,
                                      color: Colors.grey,
                                    ),
                                    onPressed: () {
                                      vm.focusNode.unfocus();
                                      vm.focusNode.canRequestFocus = false;
                                      vm.showEnojiOption = !vm.showEnojiOption;
                                      vm.update();
                                    },
                                  )
                                : null,
                            contentPadding: widget.isWeb!
                                ? const EdgeInsets.symmetric(
                                    vertical: 10, horizontal: 15)
                                : const EdgeInsets.all(5),
                            suffixIcon: !widget.isWeb!
                                ? Padding(
                                    padding: const EdgeInsets.only(right: 10.0),
                                    child: Row(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        SizedBox(
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width *
                                              0.09,
                                          child: IconBtn(
                                            icon: Icons.attach_file,
                                            iconOnPress: () {
                                              showModalBottomSheet(
                                                backgroundColor:
                                                    Colors.transparent,
                                                context: context,
                                                builder: (builder) {
                                                  // return const MoreOptionsToSend();
                                                  return Mots(
                                                    height: 380,
                                                    list: vm.moreOptionsToSend,
                                                    borderR: 15,
                                                  );
                                                },
                                              );
                                            },
                                          ),
                                        ),
                                        SizedBox(
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width *
                                              0.09,
                                          child: const IconBtn(
                                            icon: Icons.currency_rupee,
                                          ),
                                        ),
                                        SizedBox(
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width *
                                              0.09,
                                          child: const IconBtn(
                                            icon: Icons.camera_alt,
                                          ),
                                        ),
                                      ],
                                    ),
                                  )
                                : null,
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(bottom: 6.0),
                      child: CircleAvatar(
                        radius: 24.5,
                        backgroundColor: !widget.isWeb!
                            ? const Color(0xff128c7E)
                            : const Color.fromARGB(128, 255, 255, 255),
                        child: IconButton(
                            onPressed: () {
                              if (vm.sendButton) {
                                vm.scrollController.animateTo(
                                    vm.scrollController.position
                                        .maxScrollExtent,
                                    duration: const Duration(milliseconds: 300),
                                    curve: Curves.easeOut);
                                // vm.sendMessage(vm.txtController.text,
                                //     vm.senderUserId!, widget.receiverId);

                                vm.sendMessageToUser();
                                // vm.txtController.clear();
                                vm.sendButton = false;
                                vm.update();
                              }
                            },
                            icon: Icon(vm.sendButton ? Icons.send : Icons.mic,
                                color: widget.isWeb!
                                    ? Colors.grey.shade800
                                    : Colors.white,
                                size: vm.sendButton ? 23 : 25)),
                      ),
                    ),
                  ],
                ),
              ),
              vm.showEnojiOption ? emojiOptions() : Container(),
            ],
          ),
        );
      }),
    );
  }

  GetBuilder emojiOptions() {
    return GetBuilder<UserChatVM>(builder: (vm) {
      return SizedBox(
        height: 250,
        child: EmojiPicker(
          onEmojiSelected: (category, emoji) {
            vm.txtController.text = vm.txtController.text + emoji.emoji;
            vm.update();
          },
          onBackspacePressed: () {},
          config: const Config(
            columns: 8,
            // emojiSizeMax: 32 * (Platform.isIOS ? 1.30 : 1.0), // Issue: https://github.com/flutter/flutter/issues/28894
            verticalSpacing: 0,
            horizontalSpacing: 0,
            gridPadding: EdgeInsets.zero,
            initCategory: Category.RECENT,
            bgColor: Color(0xFFF2F2F2),
            indicatorColor: Colors.blue,
            iconColor: Colors.grey,
            iconColorSelected: Colors.blue,
            // progressIndicatorColor: Colors.blue,
            backspaceColor: Colors.blue,
            skinToneDialogBgColor: Colors.white,
            skinToneIndicatorColor: Colors.grey,
            enableSkinTones: true,
            showRecentsTab: true,
            recentsLimit: 28,
            noRecents: Text(
              'No Recents',
              style: TextStyle(fontSize: 20, color: Colors.black26),
              textAlign: TextAlign.center,
            ),
            tabIndicatorAnimDuration: kTabScrollDuration,
            categoryIcons: CategoryIcons(),
            buttonMode: ButtonMode.MATERIAL,
          ),
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
