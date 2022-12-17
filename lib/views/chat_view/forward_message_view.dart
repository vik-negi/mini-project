import 'package:evika/models/chat/chat_page_model.dart';
import 'package:evika/utils/widgets/chat/bottomTextMessaging.dart';
import 'package:evika/view_models/user_chat_home_vm.dart';
import 'package:evika/view_models/user_chat_viewmodal.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ForwardView extends StatefulWidget {
  const ForwardView({Key? key}) : super(key: key);

  @override
  State<ForwardView> createState() => _ForwardView();
}

class _ForwardView extends State<ForwardView> {
  List<ChatUsers> forwardToList = [];
  UserChatHomeVM vm = Get.find();
  @override
  Widget build(BuildContext context) {
    return GetBuilder<UserChatHomeVM>(builder: (vm) {
      return Scaffold(
        appBar: AppBar(
            title: Text(
                forwardToList.isEmpty
                    ? "Froward to..."
                    : "${forwardToList.length} selected",
                style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w500
                    // fontSize:
                    )),
            actions: [
              IconButton(
                onPressed: () {},
                icon: const Icon(Icons.search),
              ),
            ]),
        body: Stack(
          children: [
            ListView.builder(
                itemCount: vm.chatUsersList.length + 1,
                itemBuilder: (context, i) {
                  if (i == 0) {
                    return Container(
                      height: forwardToList.isEmpty ? 0 : 90,
                    );
                  }
                  return InkWell(
                    onTap: () {
                      if (vm.chatUsersList[i - 1].select == false) {
                        setState(() {
                          vm.chatUsersList[i - 1].select = true;
                          forwardToList.add(vm.chatUsersList[i - 1]);
                        });
                      } else {
                        setState(() {
                          vm.chatUsersList[i - 1].select = false;
                          forwardToList.remove(vm.chatUsersList[i - 1]);
                        });
                      }
                    },
                    child: userContact(vm.chatUsersList[i - 1]),
                  );
                }),
            forwardToList.isNotEmpty
                ? Column(
                    children: [
                      Container(
                          height: 95,
                          color: Colors.white,
                          child: ListView.builder(
                              scrollDirection: Axis.horizontal,
                              itemCount: vm.chatUsersList.length,
                              itemBuilder: (context, i) {
                                if (vm.chatUsersList[i].select == true) {
                                  return InkWell(
                                    onTap: () {
                                      setState(() {
                                        vm.chatUsersList[i].select = false;
                                        forwardToList
                                            .remove(vm.chatUsersList[i]);
                                      });
                                    },
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Container(
                                          margin: const EdgeInsets.symmetric(
                                              vertical: 2, horizontal: 9),
                                          width: 67,
                                          child: Stack(
                                            children: [
                                              CircleAvatar(
                                                radius: 30,
                                                backgroundColor:
                                                    Colors.blueGrey,
                                                // child: SvgPicture.asset("assets/svgs/person.svg", height: 30,width:30, color: Colors.white),
                                                child: ClipRRect(
                                                  borderRadius:
                                                      BorderRadius.circular(50),
                                                  clipBehavior: Clip.hardEdge,
                                                  child: Image.network(vm
                                                      .chatUsersList[i]
                                                      .profilePic),
                                                ),
                                                // Icon(
                                                // Icons.person,
                                                // color: Colors.white,
                                                // size: 45,
                                                // )
                                              ),
                                              const Positioned(
                                                  bottom: 0,
                                                  right: 0,
                                                  child: CircleAvatar(
                                                    radius: 13,
                                                    backgroundColor:
                                                        Colors.white,
                                                    child: CircleAvatar(
                                                      radius: 11,
                                                      backgroundColor:
                                                          Colors.grey,
                                                      child: Icon(Icons.clear,
                                                          size: 18,
                                                          color: Colors.white),
                                                    ),
                                                  ))
                                            ],
                                          ),
                                        ),
                                        Text.rich(
                                          TextSpan(
                                              text: vm.chatUsersList[i].name
                                                  .split(' ')[0]),
                                          textAlign: TextAlign.center,
                                          style: const TextStyle(
                                            fontSize: 13,
                                          ),
                                          maxLines: 1,
                                        ),
                                      ],
                                    ),
                                  );
                                } else {
                                  return Container();
                                }
                              })),
                      Container(height: 2, color: Colors.grey[200]),
                      // const Divider(thickness: 2,)
                    ],
                  )
                : Container(),
          ],
        ),
        bottomNavigationBar: GetBuilder<UserChatVM>(builder: (ucVM) {
          return Container(
            height: 60,
            color: Colors.white,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                TextButton(
                  onPressed: () {},
                  child: const Text(
                    "Cancel",
                    style: TextStyle(color: Colors.black),
                  ),
                ),
                TextButton(
                  onPressed: () {
                    ucVM.forwardToAll(forwardToList);
                    Get.back();
                  },
                  child: const Text(
                    "Forward",
                    style: TextStyle(color: Colors.blue),
                  ),
                ),
              ],
            ),
          );
        }),
      );
    });
  }

  userContact(ChatUsers userModel) {
    return SizedBox(
      height: 64,
      child: ListTile(
        minVerticalPadding: 0,
        leading: SizedBox(
          // color: Colors.black,
          height: 48,
          width: 45,
          child: Stack(
            children: [
              CircleAvatar(
                radius: 20,
                backgroundColor: Colors.blueGrey[200],
                // child: SvgPicture.asset("assets/svgs/person.svg", height: 30,width:30, color: Colors.white),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(50),
                  clipBehavior: Clip.hardEdge,
                  child: Image.network(userModel.profilePic),
                ),
              ),
              // const Icon(Icons.person, color: Colors.white)),
              if (userModel.select != null && userModel.select == true)
                const Positioned(
                    bottom: 2,
                    right: 3,
                    child: CircleAvatar(
                      radius: 11,
                      backgroundColor: Colors.teal,
                      child: Icon(Icons.check, size: 18, color: Colors.white),
                    ))
              else
                Container(),
            ],
          ),
        ),
        title: Text(
          userModel.name,
          style: const TextStyle(fontSize: 17, fontWeight: FontWeight.w500),
        ),
        subtitle: Text.rich(
          TextSpan(text: userModel.lastMessage),
          maxLines: 1,
          softWrap: false,
        ),
      ),
    );
  }
}
