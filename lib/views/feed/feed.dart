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
    return GetBuilder<PostVM>(
      builder: (vm) {
        return Scaffold(
          appBar: AppBar(
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
              IconButton(
                icon: Icon(Icons.settings, color: Colors.grey.shade800),
                onPressed: () {
                  // TODO : settings page will be here
                },
              ),
            ],
          ),
          body: RefreshIndicator(
            onRefresh: () async {
              await vm.getAllPost();
            },
            child: SingleChildScrollView(
              physics: BouncingScrollPhysics(),
              child: SizedBox(
                height: Get.height - 75,
                child: Column(
                  children: [
                    Suggessions(),
                    SizedBox(
                      height: (vm.isPostFetched.value ||
                              !vm.isErrorOnFetchingData.value)
                          ? Get.height - 150
                          : Get.height - 150,
                      child: vm.isPostFetched.value
                          ? HomePage()
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
                    ),
                    SizedBox(
                      height: 30,
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
