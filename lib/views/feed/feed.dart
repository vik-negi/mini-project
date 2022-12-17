import 'package:evika/utils/routes.dart';
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
        appBar: AppBar(
          // foregroundColor: Theme.of(context).colorScheme.onPrimary,
          backgroundColor: Colors.transparent,
          elevation: 0,
          title: const Text(
            "Feeds",
            style: TextStyle(color: Colors.black),
          ),
          actions: [
            IconButton(
              onPressed: () {
                Get.to(ChatHomeView());
              },
              icon: Icon(Icons.message, color: Colors.grey.shade800),
            ),
            // IconButton(
            //   onPressed: () {
            //     Get.to(HomePage());
            //   },
            //   icon: Icon(Icons.home),
            // ),
            IconButton(
              icon: Icon(Icons.logout, color: Colors.grey.shade800),
              onPressed: () {
                showDialog(
                    context: context,
                    builder: (context) {
                      return AlertDialog(
                        title: const Text("Log-out"),
                        content:
                            const Text("Are you sure you want to log-out?"),
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
        ),
        body: RefreshIndicator(
          onRefresh: () async {
            await vm.filterPost();
          },
          child: Column(
            children: [
              Suggessions(),
              vm.isPostFetched.value
                  ?
                  // ListView.builder(
                  //     itemCount: vm.postList.length,
                  //     // itemCount: 1,
                  //     itemBuilder: (context, i) {
                  //       return PostContainer(i: i);
                  //     },
                  //   )
                  Expanded(child: HomePage())
                  : vm.isErrorOnFetchingData.value
                      ? Center(
                          child: SizedBox(
                          height: 100,
                          child: Column(
                            children: [
                              const Text(
                                "No data found",
                                style: TextStyle(
                                    fontSize: 20, fontWeight: FontWeight.w500),
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
                                    backgroundColor: MaterialStateProperty.all(
                                        Colors.blueGrey[800]),
                                    foregroundColor: MaterialStateProperty.all(
                                        Colors.white)),
                                onPressed: () {
                                  vm.filterPost();
                                },
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
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
            ],
          ),
        ),
      );
    } //kk
        );
  }
}
