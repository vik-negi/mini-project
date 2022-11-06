import 'package:evika/models/user/user_chat_model.dart';
import 'package:evika/models/user/user_model.dart';
import 'package:evika/views/user_Chat_page.dart';
import "package:flutter/material.dart";

class CustomUser extends StatelessWidget {
  final UserChatModel userChatModel;
  const CustomUser({Key? key, required this.userChatModel}) : super(key: key);

  // late  userChatModel sourceChat;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        if (1 == 1) {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => UserChatPage(
                isWeb: (MediaQuery.of(context).size.width > 700) ? true : false,
                userModel: userChatModel,
                sourceChat: userChatModel,
              ),
            ),
          );
        }
      },
      child: CustomUserCard(
        isContactPage: false,
        userChatModel: userChatModel,
        iconSize: 22,
        isChatPage: true,
        fontW: FontWeight.w400,
      ),
    );
  }
}

class CustomUserCard extends StatelessWidget {
  const CustomUserCard({
    Key? key,
    required this.isContactPage,
    required this.userChatModel,
    required this.iconSize,
    required this.isChatPage,
    required this.fontW,
  }) : super(key: key);

  final bool isContactPage;
  final UserChatModel userChatModel;
  final double? iconSize;
  final bool isChatPage;
  final FontWeight? fontW;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ListTile(
          minVerticalPadding: isContactPage ? 15 : 4,
          leading: CircularAvatarWidget(
            userChatModel: userChatModel,
            radiusOfAvatar: iconSize ?? 25,
            isChatPage: isChatPage,
            isContactPage: isContactPage,
          ),
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                userChatModel.name,
                style: TextStyle(
                  fontWeight: (isContactPage) ? fontW : FontWeight.w600,
                  fontSize: 17,
                ),
              ),
              isChatPage
                  ? Text(
                      userChatModel.id.toString(),
                      style: const TextStyle(
                        color: Colors.grey,
                        fontSize: 14.0,
                      ),
                    )
                  : Container(),
            ],
          ),
          subtitle: Container(
            padding: const EdgeInsets.only(top: 5),
            child: Row(
              children: [
                Text(
                  "${userChatModel.name}: ",
                  style: const TextStyle(
                    fontSize: 16.0,
                  ),
                ),
                // : isChatPage
                //     ? const Icon(
                //         Icons.done_all_rounded,
                //         size: 17,
                //       )
                //     : Container(),
                isChatPage
                    ? Text(
                        userChatModel.message!,
                        style: const TextStyle(
                          color: Colors.grey,
                          fontSize: 14.0,
                        ),
                      )
                    : Container(),
                isContactPage
                    ? userChatModel.status != null
                        ? SizedBox(
                            width: MediaQuery.of(context).size.width * 0.70,
                            child: Text(
                              userChatModel.status!,
                              maxLines: 1,
                            ))
                        : Container()
                    : Container(),
              ],
            ),
          ),
        )
      ],
    );
  }
}

class CircularAvatarWidget extends StatelessWidget {
  const CircularAvatarWidget({
    Key? key,
    required this.userChatModel,
    required this.radiusOfAvatar,
    required this.isChatPage,
    required this.isContactPage,
  }) : super(key: key);
  final double radiusOfAvatar;
  final bool isChatPage;
  final bool isContactPage;

  final UserChatModel userChatModel;

  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      radius: radiusOfAvatar,
      foregroundColor: Theme.of(context).primaryColor,
      backgroundColor: const Color.fromARGB(255, 218, 218, 218),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(50),
        clipBehavior: Clip.hardEdge,
        child: Image.asset(userChatModel.avatarUrl ?? "assets/svgs/person.svg"),
        // Icon(
        //   userChatModel.isgroup ? Icons.group_rounded : Icons.person,
        //   color: Colors.white,
        //   size: 40,
        // ),
      ),
    );
  }
}
