import 'package:evika/data/user_chat.dart';
import 'package:evika/models/user/user_model.dart';
import 'package:evika/utils/widgets/custom_user_chat.dart';
import 'package:flutter/material.dart';

class Chats extends StatefulWidget {
  const Chats({Key? key}) : super(key: key);

  @override
  State<Chats> createState() => _ChatsState();
}

class _ChatsState extends State<Chats> {
  final ScrollController controller = ScrollController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: ListView.builder(
          padding: const EdgeInsets.all(0),
          // controller: widget.controller,
          shrinkWrap: true,
          scrollDirection: Axis.vertical,
          physics: const NeverScrollableScrollPhysics(),
          // itemCount: widget.userModelChat.length,
          itemCount: 10,
          itemBuilder: (context, i) => Padding(
              padding: EdgeInsets.only(
                  top: 2,
                  bottom: i == userChatModelList.length - 1 ? 65.0 : 2.0),
              child: CustomUser(
                userChatModel: userChatModelList[i],
              )),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Theme.of(context).colorScheme.primary,
        child: const Icon(Icons.message),
        onPressed: () {},
      ),
    );
  }
}
