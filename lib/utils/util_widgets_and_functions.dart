import 'package:evika/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class UtilWidgetsAndFunctions {
  static final monthList = [
    'Jan',
    'Feb',
    'Mar',
    'Apr',
    'May',
    'Jun',
    'Jul',
    'Aug',
    'Sep',
    'Oct',
    'Nov',
    'Dec'
  ];

  static Widget showStartAndEndDate(context, DateTime start, DateTime end) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 50),
      child: Stack(children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            SizedBox(
              child: Column(
                children: [
                  const Text(
                    "Start Date",
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontFamily: 'LexendDeca',
                        // color: HexColor('#707070'),
                        color: AppColors.greenColor,
                        fontSize: 14),
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  Stack(
                    children: [
                      Container(
                        width: 80,
                        height: 120,
                        padding: const EdgeInsets.only(top: 10),
                        decoration: BoxDecoration(
                          color: AppColors.white,
                          boxShadow: const [
                            BoxShadow(
                              color: AppColors.primaryColor,
                              blurRadius: 2,
                              spreadRadius: -4,
                              offset: Offset(0, 0),
                            ),
                          ],
                          gradient: const LinearGradient(
                              begin: Alignment.topCenter,
                              end: Alignment.bottomCenter,
                              stops: [0.09, 0.02],
                              colors: [AppColors.greenColor, Colors.white]),
                          borderRadius: BorderRadius.circular(5),
                        ),
                        child: Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                start.day.toString(),
                                style: const TextStyle(
                                  fontSize: 25,
                                ),
                              ),
                              Text(
                                "${monthList[start.month - 1]} ${start.year}",
                                style: const TextStyle(
                                  fontWeight: FontWeight.w500,
                                  fontSize: 12,
                                ),
                              ),
                              const Divider(),
                              Text(
                                "${start.hour}:${start.minute}",
                                style: const TextStyle(
                                  letterSpacing: 2,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            const Expanded(
              child: SizedBox(
                height: 120,
                child: Icon(
                  Icons.arrow_right_rounded,
                  size: 50,
                  color: AppColors.accentTextColor,
                ),
                // color: AppColors.accentColor,
              ),
            ),
            SizedBox(
              child: Column(
                children: [
                  const Text(
                    "End Date",
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontFamily: 'LexendDeca',
                        // color: HexColor('#707070'),
                        color: AppColors.redColor,
                        fontSize: 14),
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  Stack(children: [
                    Container(
                      width: 80,
                      height: 120,
                      padding: const EdgeInsets.only(top: 10),
                      decoration: BoxDecoration(
                        color: AppColors.white,
                        boxShadow: const [
                          BoxShadow(
                            color: AppColors.primaryColor,
                            blurRadius: 2,
                            spreadRadius: -4,
                            offset: Offset(0, 0),
                          ),
                        ],
                        gradient: const LinearGradient(
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,
                            stops: [0.09, 0.02],
                            colors: [Colors.red, Colors.white]),
                        borderRadius: BorderRadius.circular(5),
                      ),
                      child: Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              end.day.toString(),
                              style: const TextStyle(
                                fontSize: 25,
                              ),
                            ),
                            Text(
                              "${monthList[end.month - 1]} ${end.year}",
                              style: const TextStyle(
                                fontWeight: FontWeight.w500,
                                fontSize: 12,
                              ),
                            ),
                            const Divider(),
                            Text(
                              "${end.hour}:${end.minute}",
                              style: const TextStyle(
                                letterSpacing: 2,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ])
                ],
              ),
            ),
          ],
        ),
        Container(
          margin: const EdgeInsets.only(top: 40),
          // color: AppColors.white,
          width: Get.width,
          height: 50,
          child: const Center(),
        )
      ]),
    );
  }

  static String getTimeAgo(DateTime time) {
    final difference = DateTime.now().difference(time);
    if (difference.isNegative) {
      return "Someone from future posted this event";
    } else if (difference.inDays > 365) {
      return "${(difference.inDays / 365).floor()} years ago";
    } else if (difference.inDays > 31) {
      return "${(difference.inDays / 31).floor()} months ago";
    } else if (difference.inDays > 1) {
      return '${difference.inDays} days ago';
    } else if (difference.inHours > 1) {
      return '${difference.inHours} hours ago';
    } else if (difference.inMinutes > 1) {
      return '${difference.inMinutes} minutes ago';
    } else {
      return 'Posted Just now';
    }
  }

  static getCorrectDateTimeFormat(String dateTime) {
    try {
      return DateTime.parse(dateTime);
    } catch (e) {
      return DateFormat('y-M-d hh:mm').parse(dateTime);
    }
  }

  static String suffixBigNumber(String number) {
    double integerNumber = double.parse(number);

    if (integerNumber >= 1000000000000) {
      return "${(integerNumber / 1000000000000).toStringAsFixed(1)}T";
    } else if (integerNumber >= 1000000000) {
      return "${(integerNumber / 1000000000).toStringAsFixed(1)}B";
    } else if (integerNumber >= 1000000) {
      return "${(integerNumber / 1000000).toStringAsFixed(1)}M";
    } else if (integerNumber >= 1000) {
      return "${(integerNumber / 1000).toStringAsFixed(1)}K";
    } else {
      return integerNumber.toStringAsFixed(0);
    }
  }

  static Widget gapx(double x) {
    return SizedBox(
      width: x.toDouble(),
    );
  }

  static Widget gapy(double x) {
    return SizedBox(
      height: x.toDouble(),
    );
  }

  static appSnakBar(
      {required String message, double? maxwidth, bool isError = true}) {
    return Get.rawSnackbar(
      icon: isError ? const Icon(Icons.error) : const Icon(Icons.check),
      message: message,
      snackPosition: SnackPosition.BOTTOM,
      backgroundColor: isError ? Colors.red : Colors.green,
      maxWidth: maxwidth ?? Get.width * 0.8,
      margin: EdgeInsets.only(bottom: Get.height * 0.1),
      borderRadius: 16,
      duration: const Duration(seconds: 2),
    );
  }
}
