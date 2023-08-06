import 'package:evika/utils/widgets/custom_user_chat.dart';
import 'package:evika/view_models/user_chat_home_vm.dart';
import 'package:evika/views/chat_view/forward_message_view.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Chats extends StatefulWidget {
  const Chats({Key? key}) : super(key: key);

  @override
  State<Chats> createState() => _ChatsState();
}

class _ChatsState extends State<Chats> {
  final ScrollController controller = ScrollController();
  UserChatHomeVM userChatHomeVM = Get.find();
  @override
  Widget build(BuildContext context) {
    return GetBuilder<UserChatHomeVM>(builder: (vm) {
      return Scaffold(
        body: SingleChildScrollView(
          child: ListView.builder(
            padding: const EdgeInsets.all(0),
            // controller: widget.controller,
            shrinkWrap: true,
            scrollDirection: Axis.vertical,
            physics: const NeverScrollableScrollPhysics(),
            // itemCount: widget.userModelChat.length,
            itemCount: vm.chatUsersList.length,
            itemBuilder: (context, i) => Padding(
                padding: EdgeInsets.only(
                    top: 2,
                    bottom: i == vm.chatUsersList.length - 1 ? 65.0 : 2.0),
                child: CustomUser(
                  userChatModel: vm.chatUsersList[i],
                  index: i,
                )),
          ),
        ),
        floatingActionButton: FloatingActionButton(
          // backgroundColor: Theme.of(context).colorScheme.primary,
          backgroundColor: Theme.of(context).colorScheme.background,
          child: const Icon(Icons.message),
          onPressed: () {
            // Get.to(() => ForwardView());
          },
        ),
      );
    });
  }
}
