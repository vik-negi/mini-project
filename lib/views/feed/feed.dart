import 'package:evika/auth/signup.dart';
import 'package:evika/utils/constants.dart';
import 'package:evika/utils/routes.dart';
import 'package:evika/utils/user_functionality.dart';
import 'package:evika/utils/widgets/login_first_dialogbox.dart';
import 'package:evika/view_models/chat_bot.dart';
import 'package:evika/view_models/common_viewmodel.dart';
import 'package:evika/view_models/home_viewmodel.dart/post_viewmodel.dart';
import 'package:evika/view_models/navigation.dart/navigation_viewmodel.dart';
import 'package:evika/views/chat_view/chart_view_home.dart';
import 'package:evika/views/home.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:hexcolor/hexcolor.dart';

class FeedView extends StatelessWidget {
  const FeedView({super.key});

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return GetBuilder<PostVM>(builder: (vm) {
      return GetBuilder<CommonVM>(builder: (commonVM) {
        return Scaffold(
          body: NestedScrollView(
              headerSliverBuilder: (context, value) {
                return [
                  Get.width > Constants.webWidth
                      ? const SliverAppBar(
                          toolbarHeight: 0,
                        )
                      : SliverAppBar(
                          pinned: true,
                          floating: true,
                          backgroundColor: Colors.white,
                          elevation: 0,
                          title: const Text(
                            "Feeds",
                            style: TextStyle(color: Colors.black),
                          ),
                          actions: [
                            IconButton(
                              onPressed: () async {
                                if (!await UserFunctions.isUserLoggedInFun()) {
                                  loginFirstDialog(context);
                                  return;
                                }
                                Get.to(const ChatHomeView());
                              },
                              icon: Icon(CupertinoIcons.chat_bubble_2_fill,
                                  color: Colors.grey.shade800),
                            ),
                          ],
                          bottom: Get.width > Constants.webWidth
                              ? PreferredSize(
                                  preferredSize: const Size(500, 40),
                                  child: Suggessions(),
                                )
                              : PreferredSize(
                                  preferredSize: Size(Get.width, 40),
                                  child: Suggessions(),
                                ),
                        ),
                ];
              },
              body: RefreshIndicator(
                onRefresh: () async {
                  await vm.getAllPost();
                },
                child: vm.isPostFetched.value
                    ? Container(
                        width: width,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            width < Constants.webWidth
                                ? const SizedBox()
                                : Row(
                                    children: [
                                      const WebSideBarWidget(),
                                      Divider(
                                        color: Colors.grey.shade800,
                                        thickness: 5,
                                      )
                                    ],
                                  ),
                            Container(
                              width: Get.width < Constants.webWidth
                                  ? width
                                  : vm.showWebCommentSection
                                      ? width -
                                          Constants.commentSectionWidth -
                                          Constants.sizeBarWidth
                                      : width - Constants.sizeBarWidth,
                              child: Center(
                                child: Container(
                                  padding:
                                      const EdgeInsets.symmetric(vertical: 20),
                                  width: Get.width < Constants.mwidth
                                      ? width
                                      : 560,
                                  child: Center(
                                    child: HomePage(),
                                  ),
                                ),
                              ),
                            ),
                            (!vm.showWebCommentSection || width < 1260)
                                ? const SizedBox()
                                : Container(
                                    width: Constants.commentSectionWidth,
                                    child: commonVM.isLoading
                                        ? ConstrainedBox(
                                            constraints: BoxConstraints(
                                              minHeight: height,
                                              minWidth:
                                                  width < Constants.webWidth
                                                      ? width
                                                      : Constants
                                                          .commentSectionWidth,
                                            ),
                                            child: const Center(
                                              child:
                                                  CircularProgressIndicator(),
                                            ),
                                          )
                                        : Column(
                                            children: [
                                              Padding(
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                        vertical: 20.0),
                                                child: TextFormFieldContainer(
                                                    width: Get.width <
                                                            Constants.webWidth
                                                        ? width - 20
                                                        : Constants
                                                                .commentSectionWidth -
                                                            20,
                                                    icon: Icons.add_reaction,
                                                    hintText: "Add Comment",
                                                    function: () {},
                                                    controller:
                                                        vm.commentController,
                                                    isMobileNumber: false,
                                                    suffix: InkWell(
                                                      onTap: () async {
                                                        if (!await UserFunctions
                                                            .isUserLoggedInFun()) {
                                                          loginFirstDialog(
                                                              context);
                                                          return;
                                                        }
                                                        commonVM.addComment(
                                                            vm
                                                                .postList[vm
                                                                    .selectedPostForComment]
                                                                .id!,
                                                            vm.commentController
                                                                .text
                                                                .trim());
                                                      },
                                                      child: const Icon(
                                                        Icons.send,
                                                        color: Colors.blue,
                                                      ),
                                                    )),
                                              ),
                                              Container(
                                                  height: height - 200,
                                                  width: Constants
                                                      .commentSectionWidth,
                                                  decoration: const BoxDecoration(
                                                      color: Colors.white,
                                                      borderRadius:
                                                          BorderRadius.only(
                                                              topLeft: Radius
                                                                  .circular(20),
                                                              topRight: Radius
                                                                  .circular(
                                                                      20))),
                                                  child: !commonVM.isLoading
                                                      ? ListView.builder(
                                                          physics:
                                                              BouncingScrollPhysics(),
                                                          itemCount: commonVM
                                                                  .commentList
                                                                  .isEmpty
                                                              ? 1
                                                              : commonVM
                                                                  .commentList
                                                                  .length,
                                                          itemBuilder:
                                                              (BuildContext
                                                                      context,
                                                                  int index) {
                                                            return commonVM
                                                                    .commentList
                                                                    .isNotEmpty
                                                                ? Container(
                                                                    margin: const EdgeInsets
                                                                            .symmetric(
                                                                        vertical:
                                                                            10,
                                                                        horizontal:
                                                                            10),
                                                                    child: Row(
                                                                        mainAxisAlignment:
                                                                            MainAxisAlignment
                                                                                .start,
                                                                        crossAxisAlignment:
                                                                            CrossAxisAlignment.start,
                                                                        children: [
                                                                          CircleAvatar(
                                                                            radius:
                                                                                25,
                                                                            backgroundImage:
                                                                                NetworkImage(commonVM.commentList[index].userImage),
                                                                          ),
                                                                          const SizedBox(
                                                                            width:
                                                                                10,
                                                                          ),
                                                                          GestureDetector(
                                                                            onLongPress:
                                                                                () {
                                                                              showDialog(
                                                                                  context: context,
                                                                                  builder: (context) {
                                                                                    return AlertDialog(
                                                                                      content: const Text("Do you want to delete this comment?"),
                                                                                      actions: [
                                                                                        TextButton(
                                                                                            onPressed: () {
                                                                                              Navigator.pop(context);
                                                                                            },
                                                                                            child: const Text("No")),
                                                                                        TextButton(
                                                                                            onPressed: () {
                                                                                              commonVM.commentFuntionality(commonVM.commentList[index].postId, "delete", commonVM.commentList[index].id);
                                                                                              Navigator.pop(context);
                                                                                            },
                                                                                            child: const Text("Yes")),
                                                                                      ],
                                                                                    );
                                                                                  });
                                                                            },
                                                                            child: Container(
                                                                                width: Get.width < Constants.webWidth ? width - 80 : Constants.commentSectionWidth - 80,
                                                                                child: Column(
                                                                                  crossAxisAlignment: CrossAxisAlignment.start,
                                                                                  children: [
                                                                                    Text(
                                                                                      commonVM.commentList[index].username,
                                                                                      style: const TextStyle(fontSize: 15, fontWeight: FontWeight.w400),
                                                                                    ),
                                                                                    RichText(
                                                                                        text: TextSpan(
                                                                                      text: commonVM.commentList[index].text,
                                                                                      style: const TextStyle(color: Colors.black, fontSize: 15, fontWeight: FontWeight.w400),
                                                                                    )),
                                                                                    Row(
                                                                                      children: [
                                                                                        TextButton.icon(
                                                                                            label: Text("${commonVM.commentList[index].likes}"),
                                                                                            onPressed: () {
                                                                                              commonVM.commentFuntionality(commonVM.commentList[index].postId, "likes", commonVM.commentList[index].id);
                                                                                            },
                                                                                            icon: Icon(
                                                                                              Icons.thumb_up,
                                                                                              color: Colors.grey.shade600,
                                                                                              size: 20,
                                                                                            )),
                                                                                        TextButton(onPressed: () {}, child: const Text("Reply")),
                                                                                      ],
                                                                                    ),
                                                                                    index == commonVM.commentList.length - 1
                                                                                        ? const SizedBox(
                                                                                            height: 40,
                                                                                          )
                                                                                        : const SizedBox()
                                                                                  ],
                                                                                )),
                                                                          )
                                                                        ]),
                                                                  )
                                                                : const Text(
                                                                    "No Comments",
                                                                    style:
                                                                        TextStyle(
                                                                      fontSize:
                                                                          20,
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .w400,
                                                                    ),
                                                                  );
                                                          },
                                                        )
                                                      : const Center(
                                                          child:
                                                              CircularProgressIndicator(
                                                            color: Colors.blue,
                                                          ),
                                                        )),
                                            ],
                                          ),
                                  )
                          ],
                        ),
                      )
                    : vm.isErrorOnFetchingData.value
                        ? Center(
                            child: SizedBox(
                            height: 100,
                            child: Column(
                              children: [
                                const Text(
                                  "No data found",
                                  style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.w500),
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                TextButton(
                                  style: ButtonStyle(
                                      shape: MaterialStateProperty.all<
                                          RoundedRectangleBorder>(
                                        RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(18.0),
                                        ),
                                      ),
                                      backgroundColor:
                                          MaterialStateProperty.all(
                                              Colors.blueGrey[800]),
                                      foregroundColor:
                                          MaterialStateProperty.all(
                                              Colors.white)),
                                  onPressed: () {
                                    vm.getAllPost();
                                  },
                                  child: const Padding(
                                    padding: EdgeInsets.symmetric(
                                        vertical: 8.0, horizontal: 16),
                                    child: Text(
                                      "Try again",
                                      style: TextStyle(
                                        fontSize: 14,
                                      ),
                                    ),
                                  ),
                                )
                              ],
                            ),
                          ))
                        : const Center(
                            child: CircularProgressIndicator(),
                          ),
              )),
        );
      });
    });
  }
}

class WebSideBarWidget extends StatelessWidget {
  const WebSideBarWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    NavigationController nv = Get.find<NavigationController>();
    return Container(
      width: Constants.sizeBarWidth,
      decoration: const BoxDecoration(
        // color: Colors.grey.shade900,
        color: Colors.white,
      ),
      child: Column(children: [
        const SizedBox(height: 20),
        Text("Evika",
            style: TextStyle(
                color: HexColor('#224957').withOpacity(0.7),
                fontFamily: 'LexendDeca',
                fontSize: 28,
                fontWeight: FontWeight.bold)),
        const SizedBox(height: 30),
        InkWell(
          onTap: () {
            nv.changeIndex(0);
            debugPrint("Called side navigation");
          },
          child: WebSideBar(title: 'Home', icon: Icons.home),
        ),
        InkWell(
          onTap: () {
            nv.changeIndex(1);
            debugPrint("Called side navigation");
          },
          child: WebSideBar(title: 'Trending', icon: Icons.trending_up),
        ),
        InkWell(
          onTap: () {
            if (!nv.isUserLoggedIn) {
              loginFirstDialog(context);
              return;
            }
            nv.changeIndex(3);
            debugPrint("Called side navigation");
          },
          child: WebSideBar(title: 'Profile', icon: Icons.person),
        ),
        InkWell(
          onTap: () {
            if (!nv.isUserLoggedIn) {
              loginFirstDialog(context);
              return;
            }
            Get.to(const ChatHomeView());
            debugPrint("Called side navigation");
          },
          child: WebSideBar(
              title: 'Chat', icon: CupertinoIcons.chat_bubble_2_fill),
        ),
        WebSideBar(title: 'Create', icon: CupertinoIcons.add_circled_solid),
        WebSideBar(title: 'Settings', icon: Icons.settings),
      ]),
    );
  }
}

class WebSideBar extends StatelessWidget {
  WebSideBar({
    super.key,
    required this.title,
    required this.icon,
  });
  String title;
  IconData icon;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      child: InkWell(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 8.0),
          child: ListTile(
            hoverColor: Colors.grey.shade600,
            leading: InkWell(
              onTap: () {},
              child: Icon(
                icon,
              ),
            ),
            title: Text(
              title,
              style: const TextStyle(fontSize: 16),
            ),
          ),
        ),
      ),
    );
  }
}
