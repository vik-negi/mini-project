import 'package:evika/utils/colors.dart';
import 'package:evika/view_models/home_viewmodel.dart/post_viewmodel.dart';
import 'package:evika/views/description/description_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:vibration/vibration.dart';

class Description extends StatelessWidget {
  int index;
  Description({super.key, required this.index});

  @override
  Widget build(BuildContext context) {
    DescriptionVM vm = Get.put(DescriptionVM());
    PostVM postVM = Get.put(PostVM());

    return GetBuilder<DescriptionVM>(
      builder: (vm) => GetBuilder<PostVM>(builder: (postVM) {
        return Scaffold(
          appBar: AppBar(
            title: const Text(
              'Description',
              style: TextStyle(
                color: AppColors.secondaryColor,
                fontFamily: "LexendDeca",
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
                padding:
                    const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                child: Column(
                  children: <Widget>[
                    SizedBox(
                        width: double.infinity,
                        child: Hero(
                          tag: index.toString(),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(20),
                            child: FadeInImage(
                              width: Get.width - 20,
                              height: Get.height * 0.45,
                              fit: BoxFit.cover,
                              placeholder: const AssetImage(
                                "assets/placeholderimageloading.gif",
                              ),
                              image: NetworkImage(
                                postVM.postList[index].image![0],
                              ),
                            ),
                          ),
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
                                RichText(
                                  text: TextSpan(
                                    children: [
                                      const TextSpan(
                                        text: 'Event Name\n',
                                        style: TextStyle(
                                          color: AppColors.secondaryColor,
                                          fontFamily: "LexendDeca",
                                          fontSize: 13,
                                        ),
                                      ),
                                      TextSpan(
                                        text:
                                            '${postVM.postList[index].title ?? ""}\n',
                                        style: const TextStyle(
                                          color: AppColors.secondaryColor,
                                          fontFamily: "LexendDeca",
                                          fontWeight: FontWeight.bold,
                                          fontSize: 18,
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
                                          fontFamily: "LexendDeca",
                                          fontSize: 13,
                                        ),
                                      ),
                                      TextSpan(
                                        text:
                                            '${postVM.postList[index].description ?? ""}\n',
                                        style: const TextStyle(
                                          color: AppColors.secondaryColor,
                                          fontFamily: "LexendDeca",
                                          fontWeight: FontWeight.bold,
                                          fontSize: 18,
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
                                          fontFamily: "LexendDeca",
                                          fontSize: 13,
                                        ),
                                      ),
                                      TextSpan(
                                        text: postVM.postList[index]
                                                .eventLocation ??
                                            "Online",
                                        style: const TextStyle(
                                          color: AppColors.secondaryColor,
                                          fontFamily: "LexendDeca",
                                          fontWeight: FontWeight.bold,
                                          fontSize: 18,
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
                        child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              RichText(
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                                text: TextSpan(
                                  text: postVM.postList[index].title ?? "",
                                  style: const TextStyle(
                                    color: AppColors.secondaryColor,
                                    fontFamily: "LexendDeca",
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
                                          postVM.postList[index].description ??
                                              "",
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
                                        postVM.postList[index].eventLocation ??
                                            "Online",
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
                                    height: 10,
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
                                                fontSize: 35,
                                              ),
                                            ),
                                            Text(
                                              "Oct 2022",
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                    // Positioned(
                                    //   top: 0,
                                    //   child: Container(
                                    //     height: 10,
                                    //     width: 80,
                                    //     decoration: const BoxDecoration(
                                    //       color: AppColors.greenColor,
                                    //       border: Border(
                                    //         top: BorderSide(
                                    //           color: AppColors.greenColor,
                                    //           width: 7,
                                    //         ),
                                    //       ),
                                    //       boxShadow: [
                                    //         BoxShadow(
                                    //           color: AppColors.primaryColor,
                                    //           blurRadius: 5,
                                    //           spreadRadius: -4,
                                    //           offset: Offset(0, 0),
                                    //         ),
                                    //       ],
                                    //       borderRadius: BorderRadius.only(
                                    //         topLeft: Radius.circular(5),
                                    //         topRight: Radius.circular(5),
                                    //       ),
                                    //       // borderRadius: BorderRadius.circular(5),
                                    //     ),
                                    //   ),
                                    // ),
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
                                    height: 10,
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
                                                fontSize: 35,
                                              ),
                                            ),
                                            Text(
                                              "Oct 2022",
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                    // Container(
                                    //   height: 10,
                                    //   width: 80,
                                    //   decoration: const BoxDecoration(
                                    //     color: AppColors.redColor,
                                    //     border: Border(
                                    //       top: BorderSide(
                                    //         color: AppColors.redColor,
                                    //         width: 7,
                                    //       ),
                                    //     ),
                                    //     boxShadow: [
                                    //       BoxShadow(
                                    //         color: AppColors.primaryColor,
                                    //         blurRadius: 5,
                                    //         spreadRadius: -4,
                                    //         offset: Offset(0, 0),
                                    //       ),
                                    //     ],
                                    //     borderRadius: BorderRadius.only(
                                    //       topLeft: Radius.circular(5),
                                    //       topRight: Radius.circular(5),
                                    //     ),
                                    //     // borderRadius: BorderRadius.circular(5),
                                    //   ),
                                    // ),
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
                          height: 70,
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
                        borderRadius: BorderRadius.circular(10),
                        color: AppColors.accentColor,
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Container(
                            width: Get.width - 90,
                            margin: const EdgeInsets.all(15),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(15),
                              color: AppColors.accentTextColor,
                            ),
                            child: TextButton(
                              onPressed: () {},
                              child: const Text(
                                "Register Now",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  color: AppColors.accentColor,
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
                                  fontWeight: FontWeight.w500,
                                  // fontFamily: 'LexendDeca',
                                  // letterSpacing: 0.5,
                                  wordSpacing: 2,
                                  color: AppColors.accentTextColor,
                                  fontSize: 17),
                            ),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Container(
                            padding: const EdgeInsets.all(10),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              border:
                                  Border.all(color: AppColors.accentTextColor),
                            ),
                            child: Text(
                              // "POSHAN Abhiyaan, strives to induce behavioural change through nutrition centric Jan Andolans in the form of Poshan Pakhwadas, Poshan Maahs and Community Based Events (CBEc) through involvement of Panchayati Raj Institutions/Villages Organizations/SHGs/volunteers etc. and ensuring wide public participation. States/UTs are carrying out IEC activities on regular basis. The month of September is celebrated as Rashtriya Poshan Maah across the country. The Rashtriya Poshan Maah 2021 witnessed wide participation and enthusiasm from convergent Ministries, States/UTs and field functionaries. Besides, community groups, Panchayati Raj Institutions, staff at Block and District level also participated in the month long activities. The activities were monitored online, in real time using the POSHAN Abhiyaan Jan Andolan Dashboard, that provided for data entry at National, State, District and Block levels.",
                              postVM.postList[index].description ?? "",
                              // textAlign: TextAlign.justify,
                              style: TextStyle(
                                fontSize: 16,
                              ),
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
        );
      }),
    );
  }
}
