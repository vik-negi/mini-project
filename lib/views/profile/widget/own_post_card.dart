// ignore_for_file: prefer_const_constructors

import 'package:cached_network_image/cached_network_image.dart';
import 'package:evika/models/user/post_model.dart';
import 'package:evika/utils/colors.dart';
import 'package:evika/utils/placeHolderImage.dart';
import 'package:evika/utils/utility_functions.dart';
import 'package:evika/view_models/common_viewmodel.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class OwnPostCard extends StatelessWidget {
  final String route;
  final PostData postData;
  const OwnPostCard({super.key, required this.route, required this.postData});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<CommonVM>(builder: (vm) {
      return InkWell(
        onTap: (() {
          vm.individualPostData = postData;
          vm.update();
          Get.toNamed(
            route,
            // parameters: {
            //   "data": postData.toMap().toString(),
            // },
          );
        }),
        child: Container(
          decoration: BoxDecoration(
            border: Border(
              bottom: BorderSide(
                color: Color.fromARGB(255, 169, 169, 169),
                width: 1,
              ),
            ),

            color: Colors.white,
            // borderRadius: BorderRadius.circular(10),
            boxShadow: const [
              BoxShadow(
                color: Color.fromARGB(255, 206, 206, 206),
                blurRadius: 3,
                spreadRadius: 1,
                offset: Offset(1, 1),
              )
            ],
          ),
          padding: EdgeInsets.only(
            bottom: 20,
          ),
          margin: EdgeInsets.symmetric(
            vertical: 2,
            horizontal: 0,
          ),
          child: Column(
            children: [
              Container(
                // margin: EdgeInsets.only(bottom: 20),
                constraints: BoxConstraints(
                  maxHeight: Get.height - 200,
                ),
                decoration: BoxDecoration(
                  // borderRadius: BorderRadius.circular(6),
                  border: Border.all(
                    color: Color.fromARGB(255, 195, 195, 195),
                    width: 1,
                  ),
                ),
                child: ClipRRect(
                  // borderRadius: BorderRadius.circular(5),
                  child: CachedNetworkImage(
                    fit: BoxFit.fitWidth,
                    imageUrl: postData.image![0],
                    width: Get.width,
                    alignment: Alignment.bottomCenter,
                    placeholder: (context, url) => showPlaceHolderImage(),
                  ),
                ),
              ),
              Container(
                // margin: EdgeInsets.symmetric(
                //   horizontal: 10,
                // ),
                child: Column(
                  children: [
                    Container(
                      padding: EdgeInsets.symmetric(vertical: 0),
                      decoration: BoxDecoration(
                        color: AppColors.accentColor,
                        // borderRadius: BorderRadius.circular(20),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          showIconAndTextOnPost(
                            icon: Icons.favorite_border,
                            text: UtilFunctions.suffixBigNumber(
                                postData.likes!.toString()),
                          ),
                          showIconAndTextOnPost(
                            icon: CupertinoIcons.conversation_bubble,
                            text: UtilFunctions.suffixBigNumber(
                                postData.noOfComments.toString()),
                          ),
                          postData.registration == null ||
                                  postData.registration!.isEmpty
                              ? SizedBox()
                              : showIconAndTextOnPost(
                                  icon: Icons.receipt_long_sharp,
                                  text: UtilFunctions.suffixBigNumber(
                                      postData.registration!.length.toString()),
                                ),
                        ],
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.symmetric(vertical: 20),
                      margin: EdgeInsets.symmetric(
                        horizontal: 20,
                        vertical: 0,
                      ),
                      decoration: BoxDecoration(
                          // color: AppColors.accentColor,
                          ),
                      width: Get.width,
                      child: Text(
                        postData.title!,
                        overflow: TextOverflow.ellipsis,
                        maxLines: 2,
                        style: TextStyle(
                          fontSize: 15,
                          fontFamily: "Poppins",
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                width: Get.width,
                margin: EdgeInsets.only(left: 20, top: 10, right: 20),
                child: Text(
                  UtilFunctions.getTimeAgo(
                    DateTime.parse(postData.createdAt!),
                  ),
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w400,
                    color: Colors.grey,
                  ),
                ),
              ),
            ],
          ),
        ),
      );
    });
  }

  Widget showIconAndTextOnPost({IconData? icon, String? text}) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 0, vertical: 2),
      padding: EdgeInsets.symmetric(
        horizontal: 10,
        vertical: 2,
      ),
      // decoration: BoxDecoration(
      //     // color: AppColors.accentColor,
      //     // borderRadius: BorderRadius.circular(10),
      //     ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          icon != null
              ? Icon(
                  icon,
                  size: 20,
                )
              : SizedBox(),
          icon != null ? UtilFunctions.gapx(4) : SizedBox(),
          text != null
              ? Text(
                  text,
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w300,
                  ),
                )
              : SizedBox(),
        ],
      ),
    );
  }
}
// {eventLocation: {address: {}, type: Point, coordinates: [83.18594949999999, 26.0739138]}, registration: [], _id: 638138da00dadd9674bf1757, userId: 635e8fbcb189741446ce0bd9, description: description, title: title, image: [http://res.cloudinary.com/dolqf9s3y/image/upload/v1669413073/qsh5ychrezhtggyauigf.jpg], tags: [tag], likedUsers: [], eventCategory: Other, eventStartAt: 2022-11-26 3:12, eventEndAt: 2022-11-26 3:12, eventId: 638138c500dadd9674bf1756, registrationRequired: false, eventDescription: No description, likes: 0, noOfComments: 0, comments: [], createdAt: 2022-11-25T21:51:22.141Z, __v: 0, name: vikram Negi, profileImage: {url: https://res.cloudinary.com/dolqf9s3y/image/upload/v1668325949/TikTok_mqkhq0.png, public_id: 6370a4d68779ddebe52b2e1c}, username: vikramnegi},