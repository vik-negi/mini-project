import 'package:evika/utils/routes.dart';
import 'package:evika/view_models/chat_bot.dart';
import 'package:evika/view_models/home_viewmodel.dart/post_viewmodel.dart';
import 'package:evika/views/chat_view/chart_view_home.dart';
import 'package:evika/views/home.dart';
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
                  shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.vertical(
                      bottom: Radius.circular(30),
                    ),
                  ),
                  // backgroundColor: Colors.white,
                  backgroundColor: Colors.primaries.first,
                  elevation: 0,
                  title: const Text(
                    "Feeds",
                    style: TextStyle(color: Colors.black),
                  ),
                  actions: [
                    IconButton(
                      onPressed: () {
                        Get.to(const ChatHomeView());
                      },
                      icon: Icon(Icons.message, color: Colors.grey.shade800),
                    ),
                    IconButton(
                      onPressed: () {
                        Get.to(ChatBot());
                      },
                      icon: const Icon(Icons.home),
                    ),
                    IconButton(
                      icon: Icon(Icons.logout, color: Colors.grey.shade800),
                      onPressed: () {
                        showDialog(
                            context: context,
                            builder: (context) {
                              return AlertDialog(
                                title: const Text("Log-out"),
                                content: const Text(
                                    "Are you sure you want to log-out?"),
                                actions: [
                                  TextButton(
                                      onPressed: () {
                                        Get.back();
                                      },
                                      child: const Text("No")),
                                  TextButton(
                                      onPressed: () async {
                                        Get.back();
                                        await vm.logout();
                                        Get.offAndToNamed(AppRotutes.signin);
                                      },
                                      child: const Text("Yes")),
                                ],
                              );
                            });
                      },
                    ),
                  ],
                  bottom: PreferredSize(
                      preferredSize: Size(Get.width, 63),
                      child: Column(
                        children: [
                          Suggessions(),
                          Center(
                              child: Container(
                            margin: const EdgeInsets.symmetric(vertical: 4),
                            decoration: BoxDecoration(
                                color: Colors.grey.shade900,
                                borderRadius: BorderRadius.circular(10)),
                            width: 100,
                            height: 5,
                          ))
                        ],
                      )),
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
                      ? HomePage()
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
