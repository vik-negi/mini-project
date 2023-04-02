import 'dart:ui';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:evika/models/user/post_model.dart';
import 'package:evika/utils/colors.dart';
import 'package:evika/utils/placeHolderImage.dart';
import 'package:evika/utils/util_widgets_and_functions.dart';
import 'package:evika/view_models/location.dart';
import 'package:evika/views/description/description_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:vibration/vibration.dart';

class Description extends StatelessWidget {
  // final String tag;
  const Description({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<DescriptionVM>(
      builder: (vm) => Scaffold(
        appBar: AppBar(
          title: const Text(
            'Description',
            style: TextStyle(
              color: AppColors.secondaryColor,
              fontWeight: FontWeight.bold,
              fontSize: 20,
            ),
          ),
          backgroundColor: Colors.white,
          foregroundColor: AppColors.secondaryColor,
        ),
        body: Stack(
          children: [
            RefreshIndicator(
              onRefresh: () {
                return Future(() => null);
              },
              child: SingleChildScrollView(
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                  child: Column(
                    children: <Widget>[
                      Container(
                          constraints: BoxConstraints(
                            maxHeight: Get.height * 0.7,
                          ),
                          width: double.infinity,
                          child: ClipRRect(
                              borderRadius: BorderRadius.circular(20),
                              child: CachedNetworkImage(
                                imageUrl: vm.pvm.postList[vm.index].image![0],
                                fit: BoxFit.cover,
                                placeholder: (context, url) =>
                                    showPlaceHolderImage(),
                              ))),
                      const SizedBox(
                        height: 10,
                      ),
                      InkWell(
                        onLongPress: () async {
                          showDialog(
                            context: context,
                            builder: (context) => AlertDialog(
                              actions: [
                                TextButton(
                                    onPressed: () {
                                      Navigator.pop(context);
                                    },
                                    child: const Text('OK')),
                              ],
                              title: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Container(
                                    width: double.infinity,
                                    child: Center(
                                      child: Container(
                                        decoration: const BoxDecoration(
                                            color: AppColors.accentTextColor,
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(50))),
                                        width: 100,
                                        padding: const EdgeInsets.all(2),
                                        child: ClipRRect(
                                          borderRadius:
                                              BorderRadius.circular(50),
                                          child: CachedNetworkImage(
                                            imageUrl: vm.pvm.postList[vm.index]
                                                .profileImage!,
                                            fit: BoxFit.cover,
                                            placeholder: (context, url) =>
                                                showPlaceHolderImage(),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 50,
                                  ),
                                  RichText(
                                    text: TextSpan(
                                      children: [
                                        const TextSpan(
                                          text: 'Event Name\n',
                                          style: TextStyle(
                                            color: AppColors.secondaryColor,
                                            fontSize: 13,
                                            fontWeight: FontWeight.w700,
                                          ),
                                        ),
                                        TextSpan(
                                          text:
                                              '${vm.pvm.postList[vm.index].title!}\n',
                                          style: const TextStyle(
                                            color: AppColors.secondaryColor,
                                            // fontWeight: FontWeight.w700,
                                            fontSize: 14,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  RichText(
                                    text: TextSpan(
                                      children: [
                                        const TextSpan(
                                          text: 'Event Organizer\n',
                                          style: TextStyle(
                                            color: AppColors.secondaryColor,
                                            fontSize: 13,
                                            fontWeight: FontWeight.w700,
                                          ),
                                        ),
                                        TextSpan(
                                          text:
                                              '${vm.pvm.postList[vm.index].name!}\n',
                                          style: const TextStyle(
                                            color: AppColors.secondaryColor,
                                            // fontWeight: FontWeight.w700,
                                            fontSize: 14,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  RichText(
                                    text: TextSpan(
                                      children: [
                                        const TextSpan(
                                          text: 'Event Location\n',
                                          style: TextStyle(
                                            color: AppColors.secondaryColor,
                                            fontSize: 13,
                                            fontWeight: FontWeight.w700,
                                          ),
                                        ),
                                        TextSpan(
                                          // text: getLocation.findAdressByPosition(
                                          //   vm.pvm.postList[vm.index].lat!,
                                          // ),
                                          text: vm.address,
                                          style: const TextStyle(
                                            color: AppColors.secondaryColor,
                                            // fontWeight: FontWeight.w700,
                                            fontSize: 14,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          );

                          if (await Vibration.hasVibrator() ?? false) {
                            Vibration.vibrate(duration: 100);
                          }
                        },
                        child: Container(
                          padding: const EdgeInsets.all(10),
                          child: Column(children: [
                            RichText(
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                              text: TextSpan(
                                text: vm.pvm.postList[vm.index].title!
                                    .capitalizeFirst,
                                style: const TextStyle(
                                  color: AppColors.secondaryColor,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 18,
                                ),
                              ),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    const Icon(
                                      Icons.person,
                                    ),
                                    UtilWidgetsAndFunctions.gapx(5),
                                    SizedBox(
                                      width: Get.width - 90,
                                      child: Text(
                                        vm.pvm.postList[vm.index].name!
                                            .capitalize
                                            .toString(),
                                        overflow: TextOverflow.ellipsis,
                                        style: TextStyle(
                                          fontWeight: FontWeight.w600,
                                          color: HexColor('#707070'),
                                          fontSize: 16,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(
                                  height: 20,
                                ),
                                Row(
                                  children: [
                                    const Icon(Icons.pin_drop),
                                    UtilWidgetsAndFunctions.gapx(5),
                                    SizedBox(
                                      width: Get.width - 90,
                                      child: RichText(
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
                                        text: TextSpan(
                                            text: vm.address.substring(9),
                                            style: TextStyle(
                                                fontWeight: FontWeight.w600,
                                                color: HexColor('#707070'),
                                                fontSize: 16)),
                                      ),
                                    ),
                                  ],
                                )
                              ],
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                          ]),
                        ),
                      ),
                      // Start and End Dates Written
                      UtilWidgetsAndFunctions.showStartAndEndDate(
                        context,
                        UtilWidgetsAndFunctions.getCorrectDateTimeFormat(
                            vm.pvm.postList[vm.index].eventStartAt!),
                        UtilWidgetsAndFunctions.getCorrectDateTimeFormat(
                            vm.pvm.postList[vm.index].eventEndAt!),
                      ),
                      Container(
                        margin: const EdgeInsets.only(top: 25),
                        padding: const EdgeInsets.symmetric(
                          horizontal: 15,
                          vertical: 20,
                        ),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(30),
                          color: AppColors.accentColor,
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            if (vm.pvm.postList[vm.index].registrationRequired!)
                              Container(
                                width: Get.width - 90,
                                margin: const EdgeInsets.all(15),
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(30),
                                    // color: AppColors.accentTextColor,
                                    color: vm.isRegistered()
                                        ? Colors.green
                                        : Colors.white),
                                child: vm.pvm.postList[vm.index].registration!
                                        .contains(vm.userId.toString())
                                    ? TextButton(
                                        onPressed: () {},
                                        child: const Text(
                                          "Registered",
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontWeight: FontWeight.w700,
                                          ),
                                        ),
                                      )
                                    : TextButton(
                                        onPressed: () {
                                          vm.registerUserInEvent();
                                        },
                                        child: const Text(
                                          "Register Now",
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                            color: Colors.blue,
                                            fontWeight: FontWeight.w700,
                                          ),
                                        ),
                                      ),
                              ),
                            const SizedBox(
                              height: 20,
                            ),
                            Container(
                              margin: const EdgeInsets.only(left: 10),
                              width: Get.width,
                              child: const Text(
                                "About Event",
                                style: TextStyle(
                                    fontWeight: FontWeight.w600,
                                    // fontFamily: 'LexendDeca',
                                    // letterSpacing: 0.5,
                                    wordSpacing: 1,
                                    color: AppColors.accentTextColor,
                                    fontSize: 17),
                              ),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            Container(
                              padding: const EdgeInsets.all(15),
                              decoration: BoxDecoration(
                                // color: Colors.white
                                borderRadius: BorderRadius.circular(10),
                                border: Border.all(
                                  color: AppColors.accentTextColor,
                                ),
                              ),
                              child: Text(
                                "${vm.pvm.postList[vm.index].description!}\n\n${vm.pvm.postList[vm.index].eventDescription!}",
                                // textAlign: TextAlign.justify,
                                textAlign: TextAlign.justify,
                                style: const TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w500,
                                    letterSpacing: 0,
                                    wordSpacing: 1),
                              ),
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
            if (vm.isLoading)
              Container(
                width: Get.width,
                height: Get.height,
                color: const Color.fromARGB(38, 0, 0, 0),
                child: const Center(child: CircularProgressIndicator()),
              )
          ],
        ),
      ),
    );
  }
}
