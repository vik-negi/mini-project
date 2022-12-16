// ignore_for_file: prefer_const_constructors

import 'package:cached_network_image/cached_network_image.dart';
import 'package:evika/utils/colors.dart';
import 'package:evika/utils/placeHolderImage.dart';
import 'package:evika/utils/utility_functions.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class OwnPostCard extends StatelessWidget {
  final String title;
  final String imgUrl;
  final String likes;
  final String? registrations;
  final String comments;
  final DateTime date;
  final String route;
  const OwnPostCard({
    super.key,
    required this.title,
    required this.imgUrl,
    required this.likes,
    required this.comments,
    required this.date,
    required this.route,
    this.registrations,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: (() {
        Get.toNamed(
          route,
          parameters: {},
        );
      }),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          // borderRadius: BorderRadius.circular(10),
          boxShadow: const [
            BoxShadow(
              color: Color.fromARGB(255, 206, 206, 206),
              blurRadius: 3,
              spreadRadius: 0,
              offset: Offset(1, 1),
            )
          ],
        ),
        padding: EdgeInsets.all(10),
        margin: EdgeInsets.symmetric(
          vertical: 5,
          horizontal: 0,
        ),
        child: Column(
          children: [
            ClipRRect(
              child: CachedNetworkImage(
                fit: BoxFit.fitWidth,
                imageUrl: imgUrl,
                width: Get.width - 10,
                alignment: Alignment.bottomCenter,
                placeholder: (context, url) => showPlaceHolderImage(),
              ),
            ),
            Container(
              margin: EdgeInsets.symmetric(
                horizontal: 10,
              ),
              child: Column(
                children: [
                  Container(
                    margin: EdgeInsets.symmetric(horizontal: 5, vertical: 5),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        showIconAndTextOnPost(
                          icon: Icons.favorite_border,
                          text: UtilFunctions.suffixBigNumber(likes),
                        ),
                        showIconAndTextOnPost(
                          icon: CupertinoIcons.conversation_bubble,
                          text: UtilFunctions.suffixBigNumber(comments),
                        ),
                        registrations == null
                            ? SizedBox()
                            : showIconAndTextOnPost(
                                icon: Icons.receipt_long_sharp,
                                text: UtilFunctions.suffixBigNumber(
                                    registrations!),
                              ),
                      ],
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(left: 10),
                    width: Get.width - 80,
                    child: Text(
                      title,
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
                UtilFunctions.getTimeAgo(date),
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
  }

  Widget showIconAndTextOnPost({IconData? icon, String? text}) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 5, vertical: 4),
      padding: EdgeInsets.symmetric(
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
              : SizedBox(),
          icon != null ? UtilFunctions.gapx(4) : SizedBox(),
          text != null ? Text(text) : SizedBox(),
        ],
      ),
    );
  }
}
