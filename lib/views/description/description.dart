import 'dart:ui';

import 'package:evika/utils/colors.dart';
import 'package:evika/views/description/description_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:vibration/vibration.dart';

class Description extends StatelessWidget {
  final String tag;
  const Description({super.key, required this.tag});

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
        body: RefreshIndicator(
          onRefresh: () {
            return Future(() => null);
          },
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
              child: Column(
                children: <Widget>[
                  SizedBox(
                      width: double.infinity,
                      child: Hero(
                        tag: tag,
                        child: ClipRRect(
                            borderRadius: BorderRadius.circular(20),
                            child: const Image(
                                image: AssetImage('assets/img2.jpeg'))),
                      )),
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
                                      borderRadius: BorderRadius.circular(50),
                                      child: Image.network(
                                          "https://images-platform.99static.com/74rlsIN7kmIJKDLsDsp7F9qdV5A=/500x500/top/smart/99designs-contests-attachments/37/37734/attachment_37734867"),
                                    ),
                                  ),
                                ),
                              ),
                              const SizedBox(
                                height: 50,
                              ),
                              RichText(
                                text: const TextSpan(
                                  children: [
                                    TextSpan(
                                      text: 'Event Name\n',
                                      style: TextStyle(
                                        color: AppColors.secondaryColor,
                                        fontSize: 13,
                                      ),
                                    ),
                                    TextSpan(
                                      text:
                                          'POSHAN JAGRUKTA ABHIYAAN started by central goverment and Association\n',
                                      style: TextStyle(
                                        color: AppColors.secondaryColor,
                                        fontWeight: FontWeight.w700,
                                        fontSize: 15,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              RichText(
                                text: const TextSpan(
                                  children: [
                                    TextSpan(
                                      text: 'Event Organizer\n',
                                      style: TextStyle(
                                        color: AppColors.secondaryColor,
                                        fontSize: 13,
                                      ),
                                    ),
                                    TextSpan(
                                      text:
                                          'Young Social Reformers kjndkjng sd sd f sd f sd fskndosdg sdofjsodjfg sfigjsdfg skdfg"\n',
                                      style: TextStyle(
                                        color: AppColors.secondaryColor,
                                        fontWeight: FontWeight.w700,
                                        fontSize: 15,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              RichText(
                                text: const TextSpan(
                                  children: [
                                    TextSpan(
                                      text: 'Event Location\n',
                                      style: TextStyle(
                                        color: AppColors.secondaryColor,
                                        fontSize: 13,
                                      ),
                                    ),
                                    TextSpan(
                                      text: 'Azamgarh',
                                      style: TextStyle(
                                        color: AppColors.secondaryColor,
                                        fontWeight: FontWeight.w700,
                                        fontSize: 15,
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
                          text: const TextSpan(
                            text:
                                'POSHAN JAGRUKTA ABHIYAAN started by central goverment and Association',
                            style: TextStyle(
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
                              children: [
                                const Icon(
                                  Icons.person,
                                ),
                                SizedBox(
                                  width: Get.width - 90,
                                  child: Text(
                                    "Young Social Reformers kjndkjng sd sd f sd f sd fskndosdg sdofjsodjfg sfigjsdfg skdfg",
                                    overflow: TextOverflow.ellipsis,
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        // fontFamily: 'LexendDeca',
                                        color: HexColor('#707070'),
                                        fontSize: 14),
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
                                Text(
                                  "Azamgarh",
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontFamily: 'LexendDeca',
                                      color: HexColor('#707070'),
                                      fontSize: 14),
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
                  Container(
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
                                Stack(children: [
                                  Container(
                                    width: 80,
                                    height: 80,
                                    padding: const EdgeInsets.only(top: 10),
                                    decoration: BoxDecoration(
                                      color: AppColors.white,
                                      boxShadow: const [
                                        BoxShadow(
                                          color: AppColors.primaryColor,
                                          blurRadius: 5,
                                          spreadRadius: -4,
                                          offset: Offset(0, 0),
                                        ),
                                      ],
                                      borderRadius: BorderRadius.circular(5),
                                    ),
                                    child: Center(
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: const [
                                          Text(
                                            "23",
                                            style: TextStyle(
                                              fontSize: 25,
                                            ),
                                          ),
                                          Text(
                                            "Oct 2022",
                                            style: TextStyle(
                                              fontWeight: FontWeight.w500,
                                              fontSize: 12,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                  Container(
                                    height: 10,
                                    width: 80,
                                    decoration: const BoxDecoration(
                                      color: AppColors.greenColor,
                                      border: Border(
                                        top: BorderSide(
                                          color: AppColors.greenColor,
                                          width: 7,
                                        ),
                                      ),
                                      boxShadow: [
                                        BoxShadow(
                                          color: AppColors.primaryColor,
                                          blurRadius: 5,
                                          spreadRadius: -4,
                                          offset: Offset(0, 0),
                                        ),
                                      ],
                                      borderRadius: BorderRadius.only(
                                        topLeft: Radius.circular(5),
                                        topRight: Radius.circular(5),
                                      ),
                                      // borderRadius: BorderRadius.circular(5),
                                    ),
                                  ),
                                ])
                              ],
                            ),
                          ),
                          Expanded(
                            child: Container(
                              height: 70,
                              color: AppColors.accentColor,
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
                                    height: 80,
                                    padding: const EdgeInsets.only(top: 10),
                                    decoration: BoxDecoration(
                                      color: AppColors.white,
                                      boxShadow: const [
                                        BoxShadow(
                                          color: AppColors.primaryColor,
                                          blurRadius: 5,
                                          spreadRadius: -4,
                                          offset: Offset(0, 0),
                                        ),
                                      ],
                                      borderRadius: BorderRadius.circular(5),
                                    ),
                                    child: Center(
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: const [
                                          Text(
                                            "23",
                                            style: TextStyle(
                                              fontSize: 25,
                                            ),
                                          ),
                                          Text(
                                            "Oct 2022",
                                            style: TextStyle(
                                              fontWeight: FontWeight.w500,
                                              fontSize: 12,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                  Container(
                                    height: 10,
                                    width: 80,
                                    decoration: const BoxDecoration(
                                      color: AppColors.redColor,
                                      border: Border(
                                        top: BorderSide(
                                          color: AppColors.redColor,
                                          width: 7,
                                        ),
                                      ),
                                      boxShadow: [
                                        BoxShadow(
                                          color: AppColors.primaryColor,
                                          blurRadius: 5,
                                          spreadRadius: -4,
                                          offset: Offset(0, 0),
                                        ),
                                      ],
                                      borderRadius: BorderRadius.only(
                                        topLeft: Radius.circular(5),
                                        topRight: Radius.circular(5),
                                      ),
                                      // borderRadius: BorderRadius.circular(5),
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
                        child: Center(
                          child: InkWell(
                            onTap: () {
                              vm.toggleNotification();
                            },
                            child: Icon(
                              vm.notificationSet
                                  ? Icons.notifications_active
                                  : Icons.notifications_outlined,
                              color: AppColors.accentTextColor,
                              size: 30,
                            ),
                          ),
                        ),
                      )
                    ]),
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
                        Container(
                          width: Get.width - 90,
                          margin: const EdgeInsets.all(15),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(30),
                              // color: AppColors.accentTextColor,
                              color: Colors.white),
                          child: TextButton(
                            onPressed: () {},
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
                          child: const Text(
                            "POSHAN Abhiyaan, strives to induce behavioural change through nutrition centric Jan Andolans in the form of Poshan Pakhwadas, Poshan Maahs and Community Based Events (CBEc) through involvement of Panchayati Raj Institutions/Villages Organizations/SHGs/volunteers etc. and ensuring wide public participation. States/UTs are carrying out IEC activities on regular basis. The month of September is celebrated as Rashtriya Poshan Maah across the country. The Rashtriya Poshan Maah 2021 witnessed wide participation and enthusiasm from convergent Ministries, States/UTs and field functionaries. Besides, community groups, Panchayati Raj Institutions, staff at Block and District level also participated in the month long activities. The activities were monitored online, in real time using the POSHAN Abhiyaan Jan Andolan Dashboard, that provided for data entry at National, State, District and Block levels.",
                            // textAlign: TextAlign.justify,
                            textAlign: TextAlign.justify,
                            style: TextStyle(
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
      ),
    );
  }
}
