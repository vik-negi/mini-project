import 'package:cached_network_image/cached_network_image.dart';
import 'package:evika/utils/colors.dart';
import 'package:evika/utils/placeHolderImage.dart';
import 'package:evika/utils/utility_functions.dart';
import 'package:evika/views/create_post/selected_image_crousel_page.dart';
import 'package:evika/views/mypost/my_post_comments.dart';
import 'package:evika/views/mypost/my_post_viewmodel.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:carousel_slider/carousel_slider.dart';

class MyPostDetails extends StatelessWidget {
  const MyPostDetails({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<MyPostDetailsViewModel>(
      builder: (vm) => Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          foregroundColor: Colors.black,
          title: const Text(
            "My Post",
          ),
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              Stack(
                children: [
                  vm.post.image != null
                      ? CarouselSlider(
                          options: CarouselOptions(
                            initialPage: 0,
                            enableInfiniteScroll: false,
                            height: Get.width * (9 / 16),
                            autoPlay: true,
                            onPageChanged: (index, reason) {
                              vm.activeImageNumber = index;
                              vm.update();
                            },
                            viewportFraction: 1,
                          ),
                          items: vm.post.image!
                              .map(
                                (e) => SizedBox(
                                  width: Get.width,
                                  child: CachedNetworkImage(
                                    fit: BoxFit.cover,
                                    imageUrl: e,
                                    placeholder: (context, url) =>
                                        showPlaceHolderImage(),
                                    errorWidget: (context, url, error) =>
                                        const Icon(Icons.error),
                                  ),
                                ),
                              )
                              .toList(),
                        )
                      : Image.asset("assets/placeholderimageloading.gif"),
                  Positioned(
                    bottom: 15,
                    right: 20,
                    child: Row(
                      children: [
                        Container(
                          padding: const EdgeInsets.symmetric(
                            vertical: 7,
                            horizontal: 10,
                          ),
                          margin: const EdgeInsets.all(7),
                          decoration: BoxDecoration(
                            color: AppColors.accentColor,
                            borderRadius: BorderRadius.circular(20),
                          ),
                          // height: 20,
                          child: (Text(
                            "${vm.activeImageNumber + 1}/${vm.post.image?.length}",
                            style: const TextStyle(
                              // color: Colors.white,
                              fontFamily: "Poppins",
                              fontWeight: FontWeight.w600,
                              fontSize: 10,
                            ),
                          )),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              Container(
                width: Get.width,
                margin: const EdgeInsets.all(10),
                child: Text(
                  vm.post.title.toString(),
                  style: const TextStyle(
                    fontSize: 19,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    showIconAndTextOnPost(
                      icon: Icons.favorite_border,
                      text: vm.post.likes.toString(),
                    ),
                    showIconAndTextOnPost(
                      icon: CupertinoIcons.conversation_bubble,
                      text: vm.post.noOfComments.toString(),
                    ),
                    showIconAndTextOnPost(
                      icon: Icons.share,
                      text: vm.post.noOfComments.toString(),
                    ),
                    showIconAndTextOnPost(
                      icon: Icons.receipt_long_sharp,
                      text: 23.toString(),
                    )
                  ],
                ),
              ),
              const Divider(),
              AnimatedContainer(
                duration: const Duration(milliseconds: 200),
                margin: const EdgeInsets.only(
                  top: 10,
                  bottom: 0,
                  right: 10,
                  left: 10,
                ),
                padding: const EdgeInsets.all(20),
                // height: vm.fullCommentShown,
                constraints: BoxConstraints(
                  maxHeight: vm.fullCommentShown,
                ),
                curve: Curves.easeInOutCubic,
                decoration: const BoxDecoration(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(20),
                    topRight: Radius.circular(20),
                  ),
                  color: AppColors.accentColor,
                ),
                child: Text(
                  vm.post.description.toString(),
                  // overflow: TextOverflow.ellipsis,
                  textAlign: TextAlign.left,
                  style: const TextStyle(
                    fontSize: 14,
                  ),
                ),
              ),
              InkWell(
                onTap: () {
                  vm.toggleCommentVisibility();
                },
                child: Container(
                  margin: const EdgeInsets.only(
                    top: 0,
                    bottom: 10,
                    right: 10,
                    left: 10,
                  ),
                  padding: const EdgeInsets.only(
                    top: 0,
                    left: 20,
                    right: 20,
                    bottom: 20,
                  ),
                  decoration: const BoxDecoration(
                    color: AppColors.accentColor,
                    borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(20),
                      bottomRight: Radius.circular(20),
                    ),
                  ),
                  width: Get.width,
                  child: Text(
                    vm.fullCommentShown == 120 ? "Show More" : "Show Less",
                    textAlign: TextAlign.right,
                    style: const TextStyle(
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
              statsPageButton(
                lable: "View Comments",
                icon: Icons.comment,
                count: vm.post.noOfComments,
                onTap: () {
                  Get.to(
                    const MyPostComments(),
                    transition: Transition.rightToLeft,
                    duration: const Duration(milliseconds: 150),
                  );
                },
              ),
              statsPageButton(
                lable: "View Registraitons",
                icon: Icons.receipt_long_sharp,
                count: vm.post.noOfComments,
                onTap: () {
                  Get.to(
                    const MyPostComments(),
                    transition: Transition.rightToLeft,
                    duration: const Duration(milliseconds: 150),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget statsPageButton({
    required String lable,
    required IconData icon,
    int? count,
    Function? onTap,
  }) {
    return Container(
      margin: const EdgeInsets.symmetric(
        horizontal: 10,
        vertical: 5,
      ),
      padding: const EdgeInsets.symmetric(
        vertical: 30,
        horizontal: 30,
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: AppColors.accentColor,
      ),
      child: InkWell(
        onTap: () {
          onTap != null ? onTap() : () {};
        },
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Icon(icon),
                  UtilFunctions.gapx(10),
                  Text(
                    "$lable(${count ?? 0})",
                    style: const TextStyle(
                      fontSize: 17,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ],
              ),
            ),
            const Icon(
              CupertinoIcons.arrow_right,
              size: 30,
            )
          ],
        ),
      ),
    );
  }

  Widget showIconAndTextOnPost({IconData? icon, String? text}) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 5, vertical: 4),
      padding: const EdgeInsets.symmetric(
        horizontal: 10,
        vertical: 4,
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
          icon != null ? UtilFunctions.gapx(4) : const SizedBox(),
          text != null ? Text(text) : const SizedBox(),
        ],
      ),
    );
  }
}
