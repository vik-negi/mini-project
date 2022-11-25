// ignore_for_file: prefer_const_constructors

import 'dart:ffi';

import 'package:evika/utils/ui_utility_widgets.dart';
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
            margin: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Row(
                  children: const [
                    Icon(
                      Icons.favorite_border,
                      size: 18,
                    ),
                    SizedBox(
                      width: 3,
                    ),
                    Text("23K"),
                  ],
                ),
                Row(
                  children: [
                    Icon(
                      Icons.message_outlined,
                      size: 18,
                    ),
                    Utils.gapx(3),
                    Text("234"),
                  ],
                ),
              ],
            ),
          ),
          Container(
            margin: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
            child: Row(
              children: [
                SizedBox(
                  width: Get.width - 80,
                  child: Text(
                    title,
                    overflow: TextOverflow.ellipsis,
                    maxLines: 2,
                    style: TextStyle(
                      fontSize: 15,
                      fontFamily: "Poppins",
                      fontWeight: FontWeight.w300,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
