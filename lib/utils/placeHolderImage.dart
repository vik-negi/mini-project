import 'package:dialog_flowtter/dialog_flowtter.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

Widget showPlaceHolderImage() {
  return Container(
    child: Image.asset(
      "assets/placeholderimageloading.gif",
      fit: BoxFit.cover,
      // height: Get.height,
    ),
  );
}
