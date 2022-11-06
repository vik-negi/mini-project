// ignore_for_file: prefer_const_constructors

import 'package:evika/utils/routes.dart';
import 'package:evika/utils/sharedPreferenced.dart';
import 'package:evika/view_models/home_viewmodel.dart/post_viewmodel.dart';
import 'package:evika/views/chart.dart';
import 'package:flutter/material.dart';
import 'package:evika/utils/widgets/post_container_widget.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

// this page has only the UI of that page
class FeedView extends StatelessWidget {
  const FeedView({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<PostVM>(builder: (vm) {
      return Scaffold(
        appBar: AppBar(
          foregroundColor: Colors.black,
          backgroundColor: Colors.transparent,
          elevation: 0,
          title: const Text("Feeds"),
          actions: [
            IconButton(
              onPressed: () {
                Get.to(Chats());
              },
              icon: Icon(Icons.message),
            ),
            IconButton(
              icon: const Icon(Icons.logout),
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
            await vm.getAllPost();
          },
          child: SingleChildScrollView(
            physics: BouncingScrollPhysics(),
            child: Container(
              height: Get.height - 100,
              child: Column(
                children: [
                  SizedBox(
                    height: (vm.isPostFetched.value ||
                            !vm.isErrorOnFetchingData.value)
                        ? Get.height - 150
                        : Get.height - 150,
                    child: vm.isPostFetched.value
                        ? ListView.builder(
                            itemCount: vm.postList.length,
                            // itemCount: 1,
                            itemBuilder: (context, i) {
                              return PostContainer(i: i);
                            },
                          )
                        : vm.isErrorOnFetchingData.value
                            ? Center(
                                child: Container(
                                height: 90,
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
                                        child: Text("Try again"),
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
    } //kk
        );
  }
}
