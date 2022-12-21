import 'package:blur/blur.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:evika/utils/colors.dart';
import 'package:evika/utils/placeHolderImage.dart';
import 'package:evika/utils/routes.dart';
import 'package:evika/utils/util_widgets_and_functions.dart';
import 'package:evika/view_models/common_viewmodel.dart';
import 'package:evika/views/chat_view/user_Chat_page.dart';
import 'package:evika/views/profile/widget/own_post_card.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class OtherProfilePage extends StatelessWidget {
  const OtherProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    // final ProfileVM vm = Get.put(ProfileVM());
    return GetBuilder<CommonVM>(
      builder: (vm) => Scaffold(
        appBar: AppBar(
          elevation: 1,
          title: const Text("My Profile"),
          backgroundColor: Colors.white,
          foregroundColor: Colors.black,
          actions: [],
        ),
        body: vm.userDataLoading
            ? const Center(
                child: CircularProgressIndicator(),
              )
            : SingleChildScrollView(
                child: vm.otherUserData == null
                    ? const SizedBox(
                        child: Center(
                          child: Text("User data not found"),
                        ),
                      )
                    : Container(
                        color: Colors.white,
                        width: Get.width,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Stack(
                              children: [
                                Container(
                                  color: Colors.green,
                                ),
                                Blur(
                                  blur: 50,
                                  child: CachedNetworkImage(
                                    imageUrl: vm.otherUserData!.profileImage!,
                                    height: 230,
                                    width: Get.width,
                                    alignment: Alignment.bottomCenter,
                                    imageBuilder: (context, imageProvider) =>
                                        Container(
                                      decoration: BoxDecoration(
                                        // backgroundBlendMode: BlendMode.modulate,
                                        image: DecorationImage(
                                          image: imageProvider,
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                    ),
                                    placeholder: (context, url) =>
                                        showPlaceHolderImage(),
                                  ),
                                ),
                                SizedBox(
                                  width: Get.width,
                                  child: Column(
                                    children: [
                                      Container(
                                        margin: const EdgeInsets.only(
                                            top: 40, bottom: 20),
                                        child: ClipRRect(
                                          borderRadius:
                                              BorderRadius.circular(50),
                                          child: CachedNetworkImage(
                                            imageUrl:
                                                vm.otherUserData!.profileImage!,
                                            height: 100,
                                            width: 100,
                                            alignment: Alignment.bottomCenter,
                                            imageBuilder:
                                                (context, imageProvider) =>
                                                    Container(
                                              decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(20),
                                                image: DecorationImage(
                                                  image: imageProvider,
                                                  fit: BoxFit.cover,
                                                ),
                                              ),
                                            ),
                                            placeholder: (context, url) =>
                                                showPlaceHolderImage(),
                                          ),
                                        ),
                                      ),
                                      Column(
                                        children: [
                                          FittedBox(
                                            child: Column(children: [
                                              Row(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.center,
                                                children: [
                                                  Text(
                                                    vm.otherUserData!.name,
                                                    style: const TextStyle(
                                                      color: Colors.black,
                                                      fontSize: 18,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                    ),
                                                  ),
                                                  const Icon(
                                                    Icons.verified_rounded,
                                                    size: 18,
                                                  )
                                                ],
                                              ),
                                              Text(
                                                vm.otherUserData!.username,
                                                style: TextStyle(
                                                  color: Colors.grey.shade700,
                                                  fontSize: 14,
                                                ),
                                              ),
                                            ]),
                                          )
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                Column(
                                  children: [
                                    SizedBox(
                                      height: 25,
                                      child: Text(
                                        vm.otherUserData?.following?.length
                                                .toString() ??
                                            "0",
                                        style: const TextStyle(
                                          color: Colors.black,
                                          fontSize: 15,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),
                                    Text(
                                      "Followers",
                                      style: TextStyle(
                                        color: Colors.grey.shade700,
                                      ),
                                    ),
                                  ],
                                ),
                                Column(
                                  children: [
                                    SizedBox(
                                      height: 25,
                                      child: Text(
                                        vm.otherUserData?.following?.length
                                                .toString() ??
                                            "0",
                                        style: const TextStyle(
                                          color: Colors.black,
                                          fontSize: 15,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),
                                    Text(
                                      "Following",
                                      style: TextStyle(
                                        color: Colors.grey.shade700,
                                      ),
                                    ),
                                  ],
                                ),
                                Column(
                                  children: [
                                    const SizedBox(
                                      height: 25,
                                      child: Text(
                                        "0",
                                        style: TextStyle(
                                          color: Colors.black,
                                          fontSize: 15,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),
                                    Text(
                                      "Post Likes",
                                      style: TextStyle(
                                        color: Colors.grey.shade700,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            const Divider(
                              height: 20,
                              thickness: 1,
                            ),
                            Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 10,
                                vertical: 10,
                              ),
                              margin: const EdgeInsets.all(10),
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(10),
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.grey.shade300,
                                      blurRadius: 0,
                                      spreadRadius: 1,
                                      offset: const Offset(0, 2),
                                    )
                                  ]),
                              child: Column(
                                children: [
                                  RichText(
                                    text: TextSpan(
                                      // text: vm.otherUserData.bio!,

                                      text:
                                          vm.otherUserData?.bio ?? "No Details",

                                      style: TextStyle(
                                        color: Colors.grey.shade900,
                                        fontSize: 14,
                                      ),
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  const Divider(
                                    height: 20,
                                    thickness: 1,
                                  ),
                                  Container(
                                    margin: const EdgeInsets.symmetric(
                                        vertical: 10),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceAround,
                                      children: [
                                        // Create Post Button
                                        TextButton(
                                          onPressed: () {
                                            Get.toNamed(
                                              AppRotutes.createPost,
                                            );
                                          },
                                          child: Container(
                                            padding: const EdgeInsets.symmetric(
                                              horizontal: 30,
                                              vertical: 15,
                                            ),
                                            decoration: BoxDecoration(
                                              color: Colors.grey.shade200,
                                              borderRadius:
                                                  const BorderRadius.all(
                                                      Radius.circular(25)),
                                            ),
                                            child: Center(
                                              child: Row(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.center,
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                children: const [
                                                  Text(
                                                    "Add Event",
                                                    style: TextStyle(
                                                      // color: Colors.black,
                                                      fontSize: 12,
                                                    ),
                                                  ),
                                                  SizedBox(
                                                    width: 5,
                                                  ),
                                                  Icon(
                                                    Icons.edit_note_sharp,
                                                    size: 18,
                                                    color: Colors.blue,
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                        ),

                                        // Edit Profile Button
                                        TextButton(
                                          onPressed: () {
                                            Get.to(
                                                () => UserChatPage(
                                                      receiverId:
                                                          vm.otherUserData!.id,
                                                      receiverName: vm
                                                          .otherUserData!
                                                          .username,
                                                      isWeb: false,
                                                    ),
                                                arguments: {
                                                  "receiverUserId":
                                                      vm.otherUserData!.id,
                                                },
                                                transition:
                                                    Transition.rightToLeft);
                                          },
                                          child: Container(
                                            padding: const EdgeInsets.symmetric(
                                              horizontal: 30,
                                              vertical: 15,
                                            ),
                                            decoration: BoxDecoration(
                                              color: Colors.grey.shade200,
                                              borderRadius:
                                                  const BorderRadius.all(
                                                      Radius.circular(25)),
                                            ),
                                            child: Center(
                                              child: Row(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.center,
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                children: const [
                                                  Text(
                                                    "Send Message",
                                                    style: TextStyle(
                                                      // color: Colors.black,
                                                      fontSize: 12,
                                                    ),
                                                  ),
                                                  SizedBox(
                                                    width: 5,
                                                  ),
                                                  Icon(
                                                    Icons.send,
                                                    size: 13,
                                                    color: Colors.blue,
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  )
                                ],
                              ),
                            ),
                            Container(
                              width: double.infinity,
                              margin: const EdgeInsets.symmetric(
                                horizontal: 20,
                                vertical: 10,
                              ),
                              child: Row(
                                children: [
                                  const Icon(
                                    CupertinoIcons.collections_solid,
                                    size: 18,
                                  ),
                                  UtilWidgetsAndFunctions.gapx(5),
                                  Text(
                                    "${vm.otherUserData!.name}'s Events",
                                    style: const TextStyle(
                                      color: Colors.black,
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            vm.otherUserPostList.isEmpty
                                ? SizedBox(
                                    height: 155,
                                    child: Center(
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          InkWell(
                                            onTap: () {
                                              Get.toNamed(
                                                AppRotutes.createPost,
                                              );
                                              // vm.getUserPost(vm.otherUserData!.id);
                                            },
                                            child: Container(
                                              padding: const EdgeInsets.all(15),
                                              decoration: BoxDecoration(
                                                color: Colors.grey.shade200,
                                                borderRadius:
                                                    const BorderRadius.all(
                                                  Radius.circular(50),
                                                ),
                                              ),
                                              child: const Icon(
                                                Icons.add,
                                                size: 25,
                                              ),
                                            ),
                                          ),
                                          UtilWidgetsAndFunctions.gapy(10),
                                          const Text(
                                            "Tap to add your first event",
                                            style: TextStyle(
                                              color: Colors.black,
                                              fontSize: 12,
                                              fontWeight: FontWeight.w300,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  )
                                : SizedBox(
                                    child: ListView.builder(
                                      physics:
                                          const NeverScrollableScrollPhysics(),
                                      shrinkWrap: true,
                                      itemCount: vm.otherUserPostList.length,
                                      // itemCount: 1,
                                      itemBuilder: (context, index) {
                                        return OwnPostCard(
                                          tag: index.toString(),
                                          postData: vm.otherUserPostList[index],
                                          route: AppRotutes.myPostDetails,
                                        );
                                      },
                                    ),
                                  ),
                          ],
                        ),
                      ),
              ),
      ),
    );
  }

  Widget showIconAndTextOnPost({IconData? icon, String? text}) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 5, vertical: 4),
      padding: const EdgeInsets.symmetric(
        horizontal: 10,
        vertical: 3,
      ),
      decoration: BoxDecoration(
        color: AppColors.accentColor,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        children: [
          icon != null
              ? Icon(
                  icon,
                  size: 18,
                )
              : const SizedBox(),
          icon != null ? UtilWidgetsAndFunctions.gapx(4) : const SizedBox(),
          text != null ? Text(text) : const SizedBox(),
        ],
      ),
    );
  }
}
