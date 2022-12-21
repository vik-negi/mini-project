import 'package:dotted_border/dotted_border.dart';
import 'package:evika/utils/util_widgets_and_functions.dart';
import 'package:evika/utils/widgets/followWidget.dart';
import 'package:evika/view_models/home_viewmodel.dart/post_viewmodel.dart';
import 'package:evika/views/trending_view/trending_post_card.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hexcolor/hexcolor.dart';

class TrandingPage extends StatefulWidget {
  const TrandingPage({super.key});

  @override
  State<TrandingPage> createState() => _TrandingPageState();
}

class _TrandingPageState extends State<TrandingPage> {
  PostVM postVM = Get.put(PostVM());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0.0,
        title: Text(
          "Evika",
          style: TextStyle(
              color: HexColor('#224957').withOpacity(0.7),
              fontFamily: 'LexendDeca',
              fontSize: 28,
              fontWeight: FontWeight.bold),
        ),
      ),
      body: RefreshIndicator(
        onRefresh: () {
          return Future(() => null);
        },
        child: Stack(
          children: [
            SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 2),
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(
                          // left: 10,
                          top: 20,
                          bottom: 15,
                        ),
                        child: Row(
                          children: const [
                            Icon(
                              Icons.arrow_right_rounded,
                              size: 30,
                            ),
                            Text(
                              "Trending 10",
                              style: TextStyle(
                                color: Colors.black,
                                fontFamily: 'LexendDeca',
                                fontSize: 25,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ),

                      const Divider(),
                      SizedBox(
                        height: 980,
                        child: ListView.builder(
                          physics: const NeverScrollableScrollPhysics(),
                          itemCount: 10,
                          itemBuilder: (context, i) {
                            return TrendingPostCard(
                              title:
                                  "POSHAN JAGRUKTA ABHIYAAN started by central government",
                              postedDate: "12/12/2020",
                              index: i + 1,
                            );
                          },
                        ),
                      ),
                      const Divider(
                        height: 50,
                      ),

                      // who to follow
                      Container(
                        child: Text(
                          "Who To Follow",
                          style: TextStyle(
                              fontFamily: 'LexendDeca',
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: HexColor('#707070')),
                        ),
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      SizedBox(
                        child: Row(
                          children: <Widget>[
                            Expanded(
                                flex: 1,
                                child: Container(
                                  child: const CircleAvatar(
                                    backgroundImage:
                                        AssetImage('assets/img4.jpg'),
                                  ),
                                )),
                            const SizedBox(
                              width: 15,
                            ),
                            Expanded(
                                flex: 7,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    Text("Young Social Reformers",
                                        style: TextStyle(
                                            fontFamily: 'LexendDeca',
                                            fontSize: 17,
                                            fontWeight: FontWeight.bold,
                                            color: HexColor('#707070'))),
                                    Text(
                                      "Followers 100K",
                                      style: TextStyle(
                                          fontFamily: 'LexendDeca',
                                          color: HexColor('#656565'),
                                          fontSize: 11),
                                    )
                                  ],
                                )),
                            Expanded(
                                flex: 2,
                                child: Container(
                                    margin: const EdgeInsets.all(2),
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(15),
                                        color: Colors.blueAccent
                                            .withOpacity(0.85)),
                                    width: 90,
                                    height: 25,
                                    alignment: Alignment.center,
                                    child: const Text("Follow",
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 14,
                                            fontFamily: 'LexendDeca')))),
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      SizedBox(
                        child: Row(children: <Widget>[
                          Expanded(
                              flex: 1,
                              child: Container(
                                child: const CircleAvatar(
                                  backgroundImage:
                                      AssetImage('assets/img4.jpg'),
                                ),
                              )),
                          const SizedBox(
                            width: 15,
                          ),
                          Expanded(
                              flex: 7,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Text("Younth Promotor Org",
                                      style: TextStyle(
                                          fontFamily: 'LexendDeca',
                                          fontSize: 17,
                                          fontWeight: FontWeight.bold,
                                          color: HexColor('#707070'))),
                                  Text(
                                    "Followers 300K",
                                    style: TextStyle(
                                        fontFamily: 'LexendDeca',
                                        color: HexColor('#656565'),
                                        fontSize: 11),
                                  )
                                ],
                              )),
                          Expanded(
                              flex: 2,
                              child: Container(
                                  margin: const EdgeInsets.all(2),
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(15),
                                      color:
                                          Colors.blueAccent.withOpacity(0.85)),
                                  width: 90,
                                  height: 25,
                                  alignment: Alignment.center,
                                  child: const Text("Follow",
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 14,
                                          fontFamily: 'LexendDeca')))),
                        ]),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      SizedBox(
                        child: Row(children: <Widget>[
                          Expanded(
                              flex: 1,
                              child: Container(
                                child: const CircleAvatar(
                                  backgroundImage:
                                      AssetImage('assets/img4.jpg'),
                                ),
                              )),
                          const SizedBox(
                            width: 15,
                          ),
                          Expanded(
                              flex: 7,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Text("Ministry of Youth Affairs",
                                      style: TextStyle(
                                          fontFamily: 'LexendDeca',
                                          fontSize: 17,
                                          fontWeight: FontWeight.bold,
                                          color: HexColor('#707070'))),
                                  Text(
                                    "Followers 10K",
                                    style: TextStyle(
                                        fontFamily: 'LexendDeca',
                                        color: HexColor('#656565'),
                                        fontSize: 11),
                                  )
                                ],
                              )),
                          Expanded(
                              flex: 2,
                              child: Container(
                                  margin: const EdgeInsets.all(2),
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(15),
                                      color:
                                          Colors.blueAccent.withOpacity(0.85)),
                                  width: 90,
                                  height: 25,
                                  alignment: Alignment.center,
                                  child: const Text("Follow",
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 14,
                                          fontFamily: 'LexendDeca')))),
                        ]),
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      const Text(
                        "See More",
                        style: TextStyle(
                            decoration: TextDecoration.underline,
                            color: Colors.blueAccent,
                            fontFamily: 'LexendDeca'),
                      ),
                      const SizedBox(
                        height: 30,
                      ),
                      FollowWidget()
                    ]),
              ),
            ),
            Positioned(
              child: Container(
                width: Get.width,
                height: Get.height,
                color: Color.fromARGB(230, 255, 255, 255),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    DottedBorder(
                      borderType: BorderType.RRect,
                      radius: const Radius.circular(30),
                      dashPattern: [4, 2, 2, 2],
                      strokeWidth: 2,
                      child: Container(
                        padding: const EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          // color: Colors.white,
                          borderRadius: BorderRadius.circular(50),
                        ),
                        child: const Icon(
                          Icons.lock,
                        ),
                      ),
                    ),
                    UtilWidgetsAndFunctions.gapy(10),
                    const Text(
                      "Locked",
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
