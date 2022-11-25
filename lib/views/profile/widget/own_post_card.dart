// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:get/get.dart';

class OwnPostCard extends StatelessWidget {
  final String title;
  final String imgUrl;
  const OwnPostCard({super.key, required this.title, required this.imgUrl});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        // border: Border.all(
        //   color: Colors.grey.shade900,
        //   width: 2,
        // ),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.shade500,
            blurRadius: 3,
            spreadRadius: 0,
            offset: const Offset(1, 1),
          )
        ],
      ),
      padding: EdgeInsets.all(10),
      margin: EdgeInsets.symmetric(
        vertical: 10,
        horizontal: 20,
      ),
      child: Column(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(20),
            child: Image.network(
              imgUrl,
              width: Get.width,
              height: 200,
              fit: BoxFit.cover,
              alignment: Alignment.bottomCenter,
            ),
          ),
          Container(
            margin: EdgeInsets.symmetric(
              vertical: 5,
              horizontal: 10,
            ),
            width: Get.width,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  margin: EdgeInsets.only(top: 5, bottom: 20
                      // horizontal: 10,
                      ),
                  child: Text.rich(
                    TextSpan(
                      text: title,
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    comicWidget(child: Text("24 Aug 2022 - 19 Dec 2022")),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    comicoTextButton(
                      icon: Icons.thumb_up_outlined,
                      text: "23K",
                    ),
                    comicoTextButton(
                      icon: Icons.share_sharp,
                      text: "934",
                    ),
                    comicoTextButton(
                      icon: Icons.remove_red_eye_outlined,
                      text: "95K",
                    ),
                  ],
                )
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget comicWidget({required Widget child}) {
    return Container(
      margin: EdgeInsets.all(5),
      padding: EdgeInsets.symmetric(
        vertical: 5,
        horizontal: 8,
      ),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        // border: Border.all(
        //   color: Colors.grey.shade900,
        //   width: 2,
        // ),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.shade500,
            blurRadius: 3,
            spreadRadius: 0,
            offset: const Offset(1, 1),
          )
        ],
      ),
      child: child,
    );
  }

  Widget comicoTextButton({String? text, IconData? icon}) {
    return Container(
      margin: EdgeInsets.all(5),
      padding: EdgeInsets.symmetric(
        vertical: 5,
        horizontal: 8,
      ),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        // border: Border.all(
        //   color: Colors.grey.shade900,
        //   width: 2,
        // ),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.shade500,
            blurRadius: 3,
            spreadRadius: 0,
            offset: const Offset(1, 1),
          )
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          icon != null
              ? Icon(
                  icon,
                  size: 16,
                )
              : SizedBox(),
          Container(
            width: 1,
            height: 15,
            color: Colors.blue,
            margin: EdgeInsets.symmetric(horizontal: 3),
          ),
          Text(
            text ?? "",
            style: TextStyle(
              fontSize: 15,
              fontFamily: "Poppins",
            ),
          ),
        ],
      ),
    );
  }
}
