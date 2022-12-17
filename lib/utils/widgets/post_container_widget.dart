import 'package:evika/models/user/post_model.dart';
import 'package:evika/utils/routes.dart';
import 'package:evika/view_models/common_viewmodel.dart';
import 'package:evika/view_models/home_viewmodel.dart/post_viewmodel.dart';
import 'package:evika/views/description/description.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:share_plus/share_plus.dart';

class PostContainer extends StatelessWidget {
  PostContainer({super.key, required this.i});
  final int i;
  CommonVM commonVM = Get.find();

  @override
  Widget build(BuildContext context) {
    // print(vm.postList[i].description);
    return GetBuilder<PostVM>(builder: (vm) {
      return InkWell(
        onTap: () {
          Get.toNamed(AppRotutes.postDescription);
        },
        child: Container(
          height: 330,
          padding: const EdgeInsets.all(10),
          margin: const EdgeInsets.only(bottom: 10),
          width: Get.width,
          decoration: BoxDecoration(
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.5),
                spreadRadius: 1,
                blurRadius: 4,
                offset: const Offset(0, 0),
              ),
            ],
          ),
          child: Column(
            children: [
              SizedBox(
                width: Get.width,
                child: Stack(
                  children: [
                    Container(
                      height: 200,
                      decoration: const BoxDecoration(
                        color: Colors.grey,
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                      ),
                      child: ClipRRect(
                        borderRadius:
                            const BorderRadius.all(Radius.circular(10)),
                        child: FadeInImage(
                          width: Get.width - 20,
                          fit: BoxFit.cover,
                          placeholder: const AssetImage(
                            "assets/placeholderimageloading.gif",
                          ),
                          image: NetworkImage(vm.postList[i].image![0]),
                        ),
                      ),
                    ),
                    // add a container that has a gradinet of two colors
                    Container(
                      height: 200,
                      decoration: BoxDecoration(
                        borderRadius:
                            const BorderRadius.all(Radius.circular(10)),
                        gradient: LinearGradient(
                          begin: Alignment.bottomCenter,
                          end: Alignment.topCenter,
                          tileMode: TileMode.decal,
                          colors: [
                            Colors.black.withOpacity(0.9),
                            Colors.black.withOpacity(0.0),
                            Colors.black.withOpacity(0.0),
                          ],
                        ),
                      ),
                    ),
                    Positioned(
                      bottom: 0,
                      child: Container(
                        width: Get.width - 50,
                        margin: const EdgeInsets.all(11),
                        child: RichText(
                          overflow: TextOverflow.ellipsis,
                          maxLines: 2,
                          text: TextSpan(
                            text: vm.postList[i].title,
                            style: const TextStyle(
                                color: Colors.white,
                                fontSize: 25,
                                fontFamily: "LexendDeca",
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                    ),
                    Positioned(
                      right: 0,
                      child: Container(
                        margin: const EdgeInsets.all(15),
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
                              Icons.favorite_border,
                              color: commonVM.isLikedPost(vm.postList[i].id!) ||
                                      commonVM.tapOnLikedButton
                                  ? Colors.pink
                                  : Colors.white,
                              size: 30,
                            )),
                      ),
                    ),
                    Positioned(
                      top: 11,
                      left: 11,
                      child: Container(
                        padding: const EdgeInsets.all(5),
                        decoration: const BoxDecoration(
                          color: Color.fromARGB(255, 0, 68, 227),
                          borderRadius: BorderRadius.all(Radius.circular(20)),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            const Icon(
                              Icons.receipt_long_sharp,
                              size: 10,
                              color: Colors.white,
                            ),
                            const SizedBox(
                              width: 5,
                            ),
                            RichText(
                              overflow: TextOverflow.ellipsis,
                              maxLines: 2,
                              text: const TextSpan(
                                text: "Reginstration Required!",
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 10,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                padding: const EdgeInsets.all(5),
                height: 110,
                width: Get.width,
                decoration: const BoxDecoration(
                  color: Colors.white,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(
                      width: Get.width - 88,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  const Icon(
                                    Icons.calendar_month_sharp,
                                    // color: Colors.grey,
                                    size: 15,
                                  ),
                                  const SizedBox(
                                    width: 3,
                                  ),
                                  RichText(
                                    text: TextSpan(
                                      text: vm.postList[i].eventStartAt
                                          .toString(),
                                      style: const TextStyle(
                                        color: Colors.black,
                                        fontFamily: "LexendDeca",
                                        fontSize: 15,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              Container(
                                margin: const EdgeInsets.only(left: 2),
                                child: const Icon(
                                  Icons.more_horiz_rounded,
                                  // color: Colors.grey,
                                  size: 12,
                                ),
                              ),
                              Row(
                                children: [
                                  const Icon(
                                    Icons.calendar_month_sharp,
                                    // color: Colors.grey,
                                    size: 15,
                                  ),
                                  const SizedBox(
                                    width: 3,
                                  ),
                                  RichText(
                                    text: TextSpan(
                                      text:
                                          vm.postList[i].eventEndAt.toString(),
                                      style: const TextStyle(
                                        color: Colors.black,
                                        fontFamily: "LexendDeca",
                                        fontSize: 15,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                          RichText(
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                            text: TextSpan(
                              text: vm.postList[i].description.toString(),
                              style: TextStyle(
                                color: Colors.grey.shade800,
                                fontFamily: "LexendDeca",
                                fontSize: 18,
                              ),
                            ),
                          ),
                          Row(
                            // mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Icon(
                                Icons.circle,
                                color: Colors.grey,
                                size: 5,
                              ),
                              const SizedBox(
                                width: 3,
                              ),
                              RichText(
                                text: TextSpan(
                                  text: vm.postList[i].username,
                                  style: const TextStyle(
                                    color: Colors.grey,
                                    fontFamily: "LexendDeca",
                                    fontSize: 14,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Container(
                          margin: const EdgeInsets.only(left: 10),
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
                          height: 20,
                        ),
                        Container(
                          margin: const EdgeInsets.only(left: 10),
                          child: Icon(
                            Icons.notifications_none_outlined,
                            color: Colors.grey.shade600,
                            size: 30,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      );
    });
  }
}
