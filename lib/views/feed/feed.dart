import 'package:evika/utils/constants.dart';
import 'package:evika/utils/routes.dart';
import 'package:evika/utils/user_functionality.dart';
import 'package:evika/utils/widgets/login_first_dialogbox.dart';
import 'package:evika/view_models/chat_bot.dart';
import 'package:evika/view_models/home_viewmodel.dart/post_viewmodel.dart';
import 'package:evika/views/chat_view/chart_view_home.dart';
import 'package:evika/views/home.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

// this page has only the UI of that page
class FeedView extends StatelessWidget {
  const FeedView({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<PostVM>(builder: (vm) {
      return Scaffold(
        body: NestedScrollView(
            headerSliverBuilder: (context, value) {
              return [
                SliverAppBar(
                  pinned: true,
                  floating: true,
                  // foregroundColor: Theme.of(context).colorScheme.onPrimary,

                  backgroundColor: Colors.white,
                  // backgroundColor: Colors.primaries.first,
                  elevation: 0,
                  title: const Text(
                    "Feeds",
                    style: TextStyle(color: Colors.black),
                  ),
                  actions: [
                    IconButton(
                      onPressed: () async {
                        if (!await UserFunctions.isUserLoggedInFun()) {
                          loginFirstDialog(context);
                          return;
                        }
                        // if (!vm.isUserLoggedIn) {
                        //   loginFirstDialog(context);
                        //   return;
                        // }
                        Get.to(const ChatHomeView());
                      },
                      icon: Icon(CupertinoIcons.chat_bubble_2_fill,
                          color: Colors.grey.shade800),
                    ),
                    // IconButton(
                    //   onPressed: () async {
                    //     if (!await UserFunctions.isUserLoggedInFun()) {
                    //       loginFirstDialog(context);
                    //       return;
                    //     }
                    //     // if (!vm.isUserLoggedIn) {
                    //     //   loginFirstDialog(context);
                    //     //   return;
                    //     // }
                    //     Get.to(ChatBot());
                    //   },
                    //   icon: Icon(Icons.home, color: Colors.grey.shade800),
                    // ),
                  ],
                  bottom: Get.width > Constants.mwidth
                      ? const PreferredSize(
                          child: SizedBox(), preferredSize: Size(0, 0))
                      : PreferredSize(
                          preferredSize: Size(Get.width, 40),
                          child: Suggessions()),
                ),
              ];
            },
            body: RefreshIndicator(
              onRefresh: () async {
                await vm.getAllPost();
              },
              child:
                  // Column(
                  //   children: [
                  // Suggessions(),
                  vm.isPostFetched.value
                      ? Center(
                          child: Container(
                              // color: Colors.red,
                              width: Get.width < Constants.mwidth
                                  ? Get.width
                                  : 500,
                              child: HomePage()),
                        )
                      // Expanded(child: HomePage())
                      : vm.isErrorOnFetchingData.value
                          ? Center(
                              child: SizedBox(
                              height: 100,
                              child: Column(
                                children: [
                                  const Text(
                                    "No data found",
                                    style: TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.w500),
                                  ),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  TextButton(
                                    style: ButtonStyle(
                                        shape: MaterialStateProperty.all<
                                            RoundedRectangleBorder>(
                                          RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(18.0),
                                          ),
                                        ),
                                        backgroundColor:
                                            MaterialStateProperty.all(
                                                Colors.blueGrey[800]),
                                        foregroundColor:
                                            MaterialStateProperty.all(
                                                Colors.white)),
                                    onPressed: () {
                                      vm.getAllPost();
                                    },
                                    child: const Padding(
                                      padding: EdgeInsets.symmetric(
                                          vertical: 8.0, horizontal: 16),
                                      child: Text(
                                        "Try again",
                                        style: TextStyle(
                                          fontSize: 14,
                                        ),
                                      ),
                                    ),
                                  )
                                ],
                              ),
                            ))
                          : const Center(
                              child: CircularProgressIndicator(),
                            ),
              // ],
              // ),
            )),
      );
    } //kk
        );
  }
}
