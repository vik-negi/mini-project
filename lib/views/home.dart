import 'package:cached_network_image/cached_network_image.dart';
import 'package:evika/auth/signup.dart';
import 'package:evika/utils/placeHolderImage.dart';
import 'package:evika/view_models/common_viewmodel.dart';
import 'package:evika/view_models/home_viewmodel.dart/post_viewmodel.dart';
import 'package:evika/view_models/signin_signup_viewmodel.dart/signin_viewmodel.dart';
import 'package:evika/views/demo.dart';
import 'package:evika/views/feed/show_files.dart';
import 'package:evika/views/profile/other_user_profile.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:share_plus/share_plus.dart';

class HomePage extends StatefulWidget {
  HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool showMore = false;

  CommonVM commonVM = Get.put(CommonVM());
  PostVM vm = Get.put(PostVM());
  @override
  Widget build(BuildContext context) {
    return GetBuilder<CommonVM>(builder: (commonVM) {
      return GetBuilder<PostVM>(builder: (vm) {
        return ListView.separated(
            reverse: true,
            physics: const BouncingScrollPhysics(),
            // physics: const NeverScrollableScrollPhysics(),
            itemCount: vm.postList.length,
            separatorBuilder: ((context, i) {
              return SizedBox(
                height: i == vm.postList.length - 1 ? 75 : 20,
              );
            }),
            itemBuilder: (context, i) {
              return Container(
                  margin: const EdgeInsets.symmetric(horizontal: 5),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Column(
                            children: [
                              GestureDetector(
                                onTap: () {
                                  commonVM
                                      .otherUsersData(vm.postList[i].userId!);
                                  Get.to(() => OtherProfilePage());
                                },
                                child: CircleAvatar(
                                  radius: 30,
                                  backgroundImage: NetworkImage(
                                      // 'https://www.w3schools.com/howto/img_avatar.png'
                                      vm.postList[i].profileImage ??
                                          'https://www.w3schools.com/howto/img_avatar.png'),
                                ),
                              ),
                              const SizedBox(
                                height: 50,
                              ),
                              CircleAvatar(
                                radius: 25,
                                backgroundColor: Colors.white,
                                child: IconButton(
                                    onPressed: () async {
                                      commonVM.tapOnLikedButton =
                                          !commonVM.tapOnLikedButton;
                                      commonVM.tapOnLikedButtonFun();
                                      commonVM.update();
                                      await vm.likePost(vm.postList[i].id);
                                      await commonVM.likedPost();
                                      // commonVM.update();
                                    },
                                    icon: Icon(
                                      commonVM.isLikedPost(
                                                  vm.postList[i].id!) ||
                                              commonVM.tapOnLikedButton
                                          ? CupertinoIcons.heart_fill
                                          : Icons.favorite_border,
                                      color: commonVM.isLikedPost(
                                                  vm.postList[i].id!) ||
                                              commonVM.tapOnLikedButton
                                          ? Colors.pink
                                          : Colors.grey.shade600,
                                      size: 30,
                                    )),
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              CircleAvatar(
                                radius: 25,
                                backgroundColor: Colors.white,
                                child: IconButton(
                                  onPressed: () async {
                                    await Share.share(
                                        "Hii! I am Joining this Event I want you to be part of this");
                                  },
                                  icon: Icon(
                                    CupertinoIcons.arrowshape_turn_up_right,
                                    color: Colors.grey.shade600,
                                    size: 30,
                                  ),
                                ),
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              CircleAvatar(
                                radius: 25,
                                backgroundColor: Colors.white,
                                child: IconButton(
                                  onPressed: () async {
                                    commonVM.getComments(
                                        postId: vm.postList[i].id!);
                                    bottomModelWidget(context, vm, i);
                                  },
                                  icon: Icon(
                                    Icons.comment,
                                    color: Colors.grey.shade600,
                                    size: 30,
                                  ),
                                ),
                              ),
                              CircleAvatar(
                                radius: 25,
                                backgroundColor: Colors.white,
                                child: IconButton(
                                  onPressed: () async {},
                                  icon: Icon(
                                    Icons.notifications_none_outlined,
                                    color: Colors.grey.shade600,
                                    size: 30,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            padding: const EdgeInsets.only(left: 8.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    Text(
                                      vm.postList[i].name!,
                                      style: const TextStyle(
                                          fontSize: 15,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    const SizedBox(
                                      width: 4,
                                    ),
                                    const Icon(
                                      Icons.verified,
                                      size: 22,
                                    ),
                                    const SizedBox(
                                      width: 5,
                                    ),
                                    Text(
                                      '@${vm.postList[i].username}',
                                      style: const TextStyle(fontSize: 15),
                                    ),
                                  ],
                                ),
                                RichText(
                                  text: TextSpan(
                                    // text: 'The FIFA World Cup Qatar 2022™',
                                    text: vm.postList[i].title,
                                    style: const TextStyle(
                                      color: Colors.black,
                                      fontSize: 17,
                                    ),
                                  ),
                                  // style: TextStyle(fontSize: 18),
                                ),
                                const SizedBox(
                                  height: 5,
                                ),
                                SizedBox(
                                  width: Get.width - 80,
                                  child: Stack(
                                    children: [
                                      Text(
                                        // "This is a record of France's results at the FIFA World Cup.",
                                        vm.postList[i].description!.length > 50
                                            ? vm.postList[i].description
                                                .toString()
                                                .substring(0, 50)
                                            : vm.postList[i].description
                                                .toString(),
                                        softWrap: true,
                                        style: const TextStyle(
                                          color: Colors.black,
                                          fontSize: 15,
                                        ),
                                      ),
                                      showMore
                                          ? Text(
                                              vm.postList[i].description!
                                                          .length >
                                                      50
                                                  ? vm.postList[i].description
                                                      .toString()
                                                      .substring(
                                                          50,
                                                          vm
                                                                  .postList[i]
                                                                  .description!
                                                                  .length -
                                                              1)
                                                  : "",
                                              style:
                                                  const TextStyle(fontSize: 15),
                                            )
                                          // ? const Text(
                                          //     "This is a record of France's results at the FIFA World Cup. France was one of the four European teams that participated at the inaugural World Cup in 1930 and have appeared in 15 FIFA World Cups, tied for the sixth most of any country.",
                                          //     style: TextStyle(fontSize: 15),
                                          //   )
                                          : const SizedBox(),
                                      Positioned(
                                        bottom: 0,
                                        right: 15,
                                        child: InkWell(
                                          onTap: () {
                                            setState(() {
                                              showMore = !showMore;
                                            });
                                          },
                                          child: Text(
                                            showMore ? 'less' : "more",
                                            style: const TextStyle(
                                              color: Colors.blue,
                                              fontSize: 15,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                const SizedBox(
                                  height: 20,
                                ),
                              ],
                            ),
                          ),
                          Container(
                            child: Column(children: [
                              Container(
                                width: Get.width * 0.82,
                                constraints: const BoxConstraints(
                                  // minHeight: 5.0,
                                  // minWidth: 5.0,
                                  maxHeight: 500.0,
                                ),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(16),
                                  color: Colors.red,
                                ),
                                child: InkWell(
                                  onTap: () {
                                    Get.to(
                                      () => ShowFiles(
                                        tag: i.toString(),
                                        file: vm.postList[i].image![0],
                                      ),
                                    );
                                  },
                                  child: Hero(
                                    tag: i.toString(),
                                    child: ClipRRect(
                                        borderRadius: BorderRadius.circular(16),
                                        child: CachedNetworkImage(
                                          imageUrl: vm.postList[i].image![0],
                                          fit: BoxFit.cover,
                                          placeholder: (context, url) =>
                                              showPlaceHolderImage(),
                                        )),
                                  ),
                                ),
                              ),
                            ]),
                          ),
                        ],
                      ),
                    ],
                  ));
            });
      });
    });
  }

  Future<dynamic> bottomModelWidget(BuildContext context, PostVM vm, int i) {
    return showModalBottomSheet(
        backgroundColor: Colors.transparent,
        context: context,
        isScrollControlled: true,
        builder: (context) {
          return
              // SizedBox.expand(
              // child:
              GetBuilder<CommonVM>(builder: (CommonVM) {
            return DraggableScrollableSheet(
              maxChildSize: 0.9,
              builder:
                  (BuildContext context, ScrollController scrollController) {
                return GestureDetector(
                  onTap: () {
                    FocusScope.of(context).unfocus();
                  },
                  child: SingleChildScrollView(
                    physics: const NeverScrollableScrollPhysics(),
                    child: Column(
                      children: [
                        // Column(
                        //   children: [
                        //     const SizedBox(
                        //       height: 30,
                        //     ),
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 20.0),
                          child: TextFormFieldContainer(
                              width: Get.width - 20,
                              icon: Icons.add_reaction,
                              hintText: "Add Comment",
                              function: () {},
                              controller: vm.commentController,
                              isMobileNumber: false,
                              suffix: InkWell(
                                onTap: () {
                                  commonVM.addComment(vm.postList[i].id!,
                                      vm.commentController.text.trim());
                                },
                                child: const Icon(
                                  Icons.send,
                                  color: Colors.blue,
                                ),
                              )),
                        ),
                        //     const SizedBox(
                        //       height: 15,
                        //     ),
                        //   ],
                        // ),
                        commonVM.isLoading
                            ? ConstrainedBox(
                                constraints: BoxConstraints(
                                  minHeight: Get.height,
                                  minWidth: Get.width,
                                ),
                                child: const Center(
                                  child: CircularProgressIndicator(),
                                ),
                              )
                            : Container(
                                height: Get.height * 0.8,
                                decoration: const BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.only(
                                        topLeft: Radius.circular(20),
                                        topRight: Radius.circular(20))),
                                child: !commonVM.isLoading
                                    ? ListView.builder(
                                        controller: scrollController,
                                        itemCount: CommonVM.commentList.isEmpty
                                            ? 1
                                            : CommonVM.commentList.length,
                                        itemBuilder:
                                            (BuildContext context, int index) {
                                          return
                                              // Column(
                                              // children: [
                                              // index == 0
                                              //     ? Column(
                                              //         children: [
                                              //           const SizedBox(
                                              //             height: 30,
                                              //           ),
                                              //           TextFormFieldContainer(
                                              //               width: Get.width - 20,
                                              //               icon:
                                              //                   Icons.add_reaction,
                                              //               hintText: "Add Comment",
                                              //               function: () {},
                                              //               controller: vm
                                              //                   .commentController,
                                              //               isMobileNumber: false,
                                              //               suffix: InkWell(
                                              //                 onTap: () {
                                              //                   commonVM.addComment(
                                              //                       vm.postList[i]
                                              //                           .id!,
                                              //                       vm.commentController
                                              //                           .text
                                              //                           .trim());
                                              //                 },
                                              //                 child: const Icon(
                                              //                   Icons.send,
                                              //                   color: Colors.blue,
                                              //                 ),
                                              //               )),
                                              //           const SizedBox(
                                              //             height: 15,
                                              //           ),
                                              //         ],
                                              //       )
                                              //     : const SizedBox(),
                                              CommonVM.commentList.isNotEmpty
                                                  ? Container(
                                                      margin: const EdgeInsets
                                                              .symmetric(
                                                          vertical: 10,
                                                          horizontal: 10),
                                                      child: Row(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .start,
                                                          crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .start,
                                                          children: [
                                                            CircleAvatar(
                                                              radius: 25,
                                                              backgroundImage:
                                                                  NetworkImage(CommonVM
                                                                      .commentList[
                                                                          index]
                                                                      .userImage),
                                                            ),
                                                            const SizedBox(
                                                              width: 10,
                                                            ),
                                                            GestureDetector(
                                                              onLongPress: () {
                                                                showDialog(
                                                                    context:
                                                                        context,
                                                                    builder:
                                                                        (context) {
                                                                      return AlertDialog(
                                                                        content:
                                                                            const Text("Do you want to delete this comment?"),
                                                                        actions: [
                                                                          TextButton(
                                                                              onPressed: () {
                                                                                Navigator.pop(context);
                                                                              },
                                                                              child: const Text("No")),
                                                                          TextButton(
                                                                              onPressed: () {
                                                                                commonVM.commentFuntionality(CommonVM.commentList[index].postId, "delete", CommonVM.commentList[index].id);
                                                                                Navigator.pop(context);
                                                                              },
                                                                              child: const Text("Yes")),
                                                                        ],
                                                                      );
                                                                    });
                                                              },
                                                              child: Container(
                                                                  width:
                                                                      Get.width -
                                                                          80,
                                                                  child: Column(
                                                                    crossAxisAlignment:
                                                                        CrossAxisAlignment
                                                                            .start,
                                                                    children: [
                                                                      Text(
                                                                        CommonVM
                                                                            .commentList[index]
                                                                            .username,
                                                                        style: const TextStyle(
                                                                            fontSize:
                                                                                15,
                                                                            fontWeight:
                                                                                FontWeight.w400),
                                                                      ),
                                                                      RichText(
                                                                          text:
                                                                              TextSpan(
                                                                        text: CommonVM
                                                                            .commentList[index]
                                                                            .text,
                                                                        style: const TextStyle(
                                                                            color: Colors
                                                                                .black,
                                                                            fontSize:
                                                                                15,
                                                                            fontWeight:
                                                                                FontWeight.w400),
                                                                      )),
                                                                      Row(
                                                                        children: [
                                                                          TextButton.icon(
                                                                              label: Text("${CommonVM.commentList[index].likes}"),
                                                                              onPressed: () {
                                                                                CommonVM.commentFuntionality(CommonVM.commentList[index].postId, "likes", CommonVM.commentList[index].id);
                                                                              },
                                                                              icon: Icon(
                                                                                Icons.thumb_up,
                                                                                color: Colors.grey.shade600,
                                                                                size: 20,
                                                                              )),
                                                                          TextButton(
                                                                              onPressed: () {},
                                                                              child: const Text("Reply")),
                                                                        ],
                                                                      ),
                                                                      i == CommonVM.commentList.length - 1
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
                                                      style: TextStyle(
                                                          fontSize: 20,
                                                          fontWeight:
                                                              FontWeight.w400),
                                                    );
                                          // ],
                                          // );
                                        },
                                      )
                                    : const Center(
                                        child: CircularProgressIndicator(
                                          color: Colors.blue,
                                        ),
                                      )),
                      ],
                    ),
                  ),
                );
              },
              // ),
            );
          });
        });
  }
}

class Suggessions extends StatefulWidget {
  Suggessions({Key? key}) : super(key: key);

  @override
  State<Suggessions> createState() => _SuggessionsState();
}

class _SuggessionsState extends State<Suggessions> {
  List<String> suggession = [
    "Global",
    "India",
    "Your State",
    "Your City",
    "Your Town",
  ];
  @override
  Widget build(BuildContext context) {
    return GetBuilder<PostVM>(builder: (vm) {
      return Container(
        height: 45,
        child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: 5,
            itemBuilder: ((context, index) {
              return Container(
                padding:
                    const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                margin: const EdgeInsets.symmetric(vertical: 5, horizontal: 5),
                // style: TextButton.styleFrom(
                //   padding: const EdgeInsets.all(0),
                //   backgroundColor: Colors.grey.shade800,
                //   shape: RoundedRectangleBorder(
                //     borderRadius: BorderRadius.circular(20),
                //   ),
                // ),
                // onPressed: () {},

                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: Colors.grey.shade700,
                ),
                child: Padding(
                  padding: const EdgeInsets.all(0),
                  child: InkWell(
                    onTap: () {
                      if (suggession[index] == 'Global') {
                        vm.postFilterRange = "500000000000000000";
                        vm.filterPost();
                      } else if (suggession[index] == 'India') {
                        vm.postFilterRange = "5000000000";
                        vm.filterPost();
                      } else if (suggession[index] == 'Your State') {
                        vm.postFilterRange = "500000";
                        vm.filterPost();
                      } else if (suggession[index] == 'Your City') {
                        vm.postFilterRange = "100000";
                        vm.filterPost();
                      } else {
                        vm.postFilterRange = "5000";
                        vm.filterPost();
                      }
                    },
                    child: Text(
                      suggession[index],
                      style: const TextStyle(
                        color: Colors.white70,
                        fontSize: 15,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
              );
            })),
      );
    });
  }
}
