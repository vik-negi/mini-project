import 'package:emoji_picker_flutter/emoji_picker_flutter.dart';
// import 'package:evika/utils/widgets/MoreOptionToSend.dart';
import 'package:evika/view_models/user_chat_viewmodal.dart';
import 'package:evika/views/chat_view/user_Chat_page.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class BottomTextMessaging extends StatelessWidget {
  BottomTextMessaging({super.key});
  final UserChatVM vm =
      Get.isRegistered<UserChatVM>() ? Get.find() : Get.put(UserChatVM());

  @override
  Widget build(BuildContext context) {
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
                color: Colors.transparent,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SizedBox(
                      width: MediaQuery.of(context).size.width - 55,
                      child: Card(
                        margin:
                            const EdgeInsets.only(left: 4, right: 2, bottom: 6),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(25)),
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
                            prefixIcon: IconButton(
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
                            ),
                            contentPadding: const EdgeInsets.all(5),
                            suffixIcon: Padding(
                              padding: const EdgeInsets.only(right: 10.0),
                              child: SizedBox(
                                width: MediaQuery.of(context).size.width * 0.09,
                                child: const IconBtn(
                                  icon: Icons.camera_alt,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(bottom: 6.0),
                      child: CircleAvatar(
                        radius: 24.5,
                        backgroundColor: const Color(0xff128c7E),
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
                                color: Colors.white,
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
            // showRecentsTab: true,
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
}
