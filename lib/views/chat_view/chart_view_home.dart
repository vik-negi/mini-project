import 'package:evika/utils/widgets/PopUpMenuBtn.dart';
import 'package:evika/view_models/user_chat_home_vm.dart';
import 'package:evika/views/chat_view/chart.dart';
import 'package:evika/views/profile/profile.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ChatHomeView extends StatefulWidget {
  const ChatHomeView({super.key});

  @override
  State<ChatHomeView> createState() => _ChatHomeViewState();
}

class _ChatHomeViewState extends State<ChatHomeView>
    with SingleTickerProviderStateMixin {
  TabController? _tabController;
  List<String> homePagePopUpMenu = [
    "New group",
    "New broadcast",
    "Linked device",
    "Starred messages",
    "Payment",
    "Setting",
  ];
  // late double widthSize;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, initialIndex: 0, vsync: this);
  }

  int contrr = 1;
  final controller = ScrollController();
  UserChatHomeVM userChatHomeVM = Get.put(UserChatHomeVM());

  @override
  Widget build(BuildContext context) {
    return GetBuilder<UserChatHomeVM>(
      builder: (vm) {
        return Scaffold(
            body: DefaultTabController(
                length: 2,
                child: NestedScrollView(
                    headerSliverBuilder: (context, value) {
                      return [
                        SliverAppBar(
                          flexibleSpace: Container(
                            decoration: BoxDecoration(
                              // LinearGradient
                              gradient: LinearGradient(
                                // colors for gradient
                                begin: Alignment.topLeft,
                                end: Alignment.bottomRight,
                                colors: [
                                  Colors.grey.shade900,
                                  Colors.grey.shade500,
                                ],
                              ),
                            ),
                          ),

                          // backgroundColor: Colors.purple,
                          // backgroundColor: LinearGradient(colors: [Colors.blue, Colors.purple, Colors.red])
                          elevation: 0,
                          pinned: true,
                          floating: true,
                          actions: [
                            IconButton(
                                onPressed: () {},
                                icon: const Icon(Icons.search)),
                            PopupMenuBtn(items: homePagePopUpMenu)
                          ],
                          bottom: TabBar(
                            isScrollable: true,
                            controller: _tabController,
                            indicatorColor: Colors.white,
                            labelPadding:
                                const EdgeInsets.symmetric(horizontal: 0.0),
                            tabs: <Widget>[
                              Container(
                                width: MediaQuery.of(context).size.width * 0.5,
                                alignment: Alignment.center,
                                child: Tab(
                                  child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: const [
                                        Text("CHATS"),
                                        SizedBox(
                                          width: 4,
                                        ),
                                        CircleAvatar(
                                          radius: 10,
                                          backgroundColor: Colors.white,
                                          child: Text("11",
                                              style: TextStyle(
                                                  fontSize: 11,
                                                  fontWeight: FontWeight.w600)),
                                        )
                                      ]),
                                ),
                              ),
                              SizedBox(
                                width: MediaQuery.of(context).size.width * 0.5,
                                child: const Tab(
                                  child: Text("PROFILE"),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ];
                    },
                    body: TabBarView(
                        controller: _tabController,
                        children: [const Chats(), ProfilePage()]))));
      },
    );
  }
}
