import 'package:cached_network_image/cached_network_image.dart';
import 'package:evika/utils/colors.dart';
import 'package:evika/utils/placeHolderImage.dart';
import 'package:evika/utils/util_widgets_and_functions.dart';
import 'package:evika/view_models/common_viewmodel.dart';
import 'package:evika/views/Individual%20_user_details.dart';
import 'package:evika/views/create_post/selected_image_crousel_page.dart';
import 'package:evika/views/mypost/fullViewImage.dart';
import 'package:evika/views/mypost/my_post_comments.dart';
import 'package:evika/views/mypost/my_post_registrations.dart';
import 'package:evika/views/mypost/my_post_viewmodel.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:carousel_slider/carousel_slider.dart';

class MyPostDetails extends StatelessWidget {
  const MyPostDetails({super.key});

  @override
  Widget build(BuildContext context) {
    CommonVM commonVM = Get.find<CommonVM>();
    return GetBuilder<MyPostDetailsViewModel>(
      builder: (vm) => Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          foregroundColor: Colors.black,
          title: Text(
            commonVM.individualPostData!.title ?? "Post Details",
          ),
        ),
        body: SingleChildScrollView(
          child: commonVM.individualPostData == null
              ? SizedBox(
                  height: Get.height,
                  child: const Center(
                    child: Text("Some Error Occured"),
                  ),
                )
              : Column(
                  children: [
                    Stack(
                      children: [
                        commonVM.individualPostData!.image != null
                            ? InkWell(
                                onTap: () {
                                  Get.to(
                                      () => FullViewImageCarousel(
                                            images: commonVM
                                                .individualPostData!.image!
                                                .map((e) => e.toString())
                                                .toList(),
                                          ),
                                      transition: Transition.cupertino,
                                      duration:
                                          const Duration(milliseconds: 150));
                                },
                                child: CarouselSlider(
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
                                  items: commonVM.individualPostData!.image!
                                      .map(
                                        (e) => SizedBox(
                                          width: Get.width,
                                          child: Hero(
                                            tag: "index",
                                            child: CachedNetworkImage(
                                              fit: BoxFit.cover,
                                              imageUrl: e,
                                              placeholder: (context, url) =>
                                                  showPlaceHolderImage(),
                                              errorWidget:
                                                  (context, url, error) =>
                                                      const Icon(Icons.error),
                                            ),
                                          ),
                                        ),
                                      )
                                      .toList(),
                                ),
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
                                  "${vm.activeImageNumber + 1}/${commonVM.individualPostData!.image?.length}",
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
                        commonVM.individualPostData!.title.toString(),
                        style: const TextStyle(
                          fontSize: 19,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.symmetric(
                          horizontal: 10, vertical: 5),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          showIconAndTextOnPost(
                            icon: Icons.favorite_border,
                            text: UtilWidgetsAndFunctions.suffixBigNumber(
                                commonVM.individualPostData!.likes.toString()),
                          ),
                          showIconAndTextOnPost(
                            icon: CupertinoIcons.conversation_bubble,
                            text: UtilWidgetsAndFunctions.suffixBigNumber(
                                commonVM.individualPostData!.noOfComments
                                    .toString()),
                          ),
                          // showIconAndTextOnPost(
                          //   icon: Icons.share,
                          //   text: commonVM.individualPostData!.noOfComments.toString(),
                          // ),
                          commonVM.individualPostData!.registrationRequired ==
                                  false
                              ? Container()
                              : showIconAndTextOnPost(
                                  icon: Icons.receipt_long_sharp,
                                  text: UtilWidgetsAndFunctions.suffixBigNumber(
                                      commonVM.individualPostData!.registration!
                                          .length
                                          .toString()),
                                )
                        ],
                      ),
                    ),
                    UtilWidgetsAndFunctions.gapy(10),
                    UtilWidgetsAndFunctions.showStartAndEndDate(
                        context,
                        UtilWidgetsAndFunctions.getCorrectDateTimeFormat(
                            commonVM.individualPostData!.eventStartAt
                                .toString()),
                        UtilWidgetsAndFunctions.getCorrectDateTimeFormat(
                            commonVM.individualPostData!.eventEndAt
                                .toString())),
                    const Divider(),
                    InkWell(
                      onTap: () {
                        vm.toggleCommentVisibility();
                      },
                      child: Column(
                        children: [
                          Container(
                            decoration: const BoxDecoration(
                              borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(20),
                                topRight: Radius.circular(20),
                              ),
                              color: AppColors.accentColor,
                            ),
                            margin: const EdgeInsets.only(
                              top: 10,
                              bottom: 0,
                              right: 10,
                              left: 10,
                            ),
                            width: Get.width,
                            padding: const EdgeInsets.all(20),
                            child: Text(
                              commonVM.individualPostData!.description
                                  .toString(),
                              // overflow: TextOverflow.ellipsis,
                              textAlign: TextAlign.left,
                              style: const TextStyle(
                                fontSize: 14,
                              ),
                            ),
                          ),
                          AnimatedContainer(
                            duration: const Duration(milliseconds: 200),
                            margin: const EdgeInsets.only(
                              top: 0,
                              bottom: 0,
                              right: 10,
                              left: 10,
                            ),
                            width: Get.width,
                            padding: const EdgeInsets.all(20),
                            // height: vm.fullCommentShown,
                            constraints: BoxConstraints(
                              maxHeight: vm.fullCommentShown,
                            ),
                            curve: Curves.easeInOutCubic,
                            decoration: const BoxDecoration(
                              // borderRadius: BorderRadius.only(
                              //   topLeft: Radius.circular(20),
                              //   topRight: Radius.circular(20),
                              // ),
                              color: AppColors.accentColor,
                            ),
                            child: Text(
                              commonVM.individualPostData!.eventDescription
                                  .toString(),
                              // overflow: TextOverflow.ellipsis,
                              textAlign: TextAlign.left,
                              style: const TextStyle(
                                fontSize: 14,
                              ),
                            ),
                          ),
                          Container(
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
                              vm.fullCommentShown == 0
                                  ? "Show More"
                                  : "Show Less",
                              textAlign: TextAlign.right,
                              style: const TextStyle(
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    statsPageButton(
                      lable: "View Comments",
                      icon: Icons.comment,
                      count: commonVM.individualPostData!.noOfComments,
                      onTap: () async {
                        commonVM.fetchIndivudualPostComments(
                          commonVM.individualPostData!.id!,
                        );
                        Get.to(
                          const MyPostComments(),
                          transition: Transition.cupertino,
                          duration: const Duration(milliseconds: 150),
                        );
                      },
                    ),
                    commonVM.individualPostData!.registrationRequired == false
                        ? Container()
                        : statsPageButton(
                            lable: "View Registraitons",
                            icon: Icons.receipt_long_sharp,
                            count: commonVM
                                .individualPostData!.registration!.length,
                            onTap: () {
                              vm.getRegisteredUsers(
                                  commonVM.individualPostData!.id!);
                              Get.to(
                                const MyPostRegistrations(),
                                transition: Transition.cupertino,
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
    return InkWell(
      onTap: () {
        onTap != null ? onTap() : () {};
      },
      child: Container(
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
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Icon(icon),
                  UtilWidgetsAndFunctions.gapx(10),
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
          icon != null ? UtilWidgetsAndFunctions.gapx(4) : const SizedBox(),
          text != null ? Text(text) : const SizedBox(),
        ],
      ),
    );
  }
}
