// ignore_for_file: prefer_const_constructors

import 'package:evika/models/user/post_model.dart';
import 'package:evika/view_models/home_viewmodel.dart/post_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:evika/utils/widgets/post_container_widget.dart';
import 'package:get/get.dart';

// this page has only the UI of that page
class FeedView extends StatelessWidget {
  const FeedView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Sample Post"),
      ),
      body: GetBuilder<PostVM>(builder: (vm) {
        return SingleChildScrollView(
            child: Container(
          // height: Get.height - 100,
          child: Column(
            children: [
              SizedBox(
                height:
                    (vm.isPostFetched.value || !vm.isErrorOnFetchingData.value)
                        ? Get.height
                        : Get.height - 150,
                child:
                    //   FutureBuilder(
                    //     future: vm.futurePosts,
                    //     builder: ((context, snapshot) {
                    //       if (snapshot.hasData) {
                    //         return ListView.builder(
                    //           itemCount: snapshot.data!.length,
                    //           itemBuilder: (context, i) {
                    //             return PostContainer(postData: snapshot.data[i]);
                    //           },
                    //         );
                    //       } else if (snapshot.connectionState ==
                    //           ConnectionState.waiting) {
                    //         return const Center(child: CircularProgressIndicator());
                    //       } else {
                    //         return Center(
                    //             child: Column(
                    //           children: [
                    //             const Text("No data found"),
                    //             TextButton(
                    //               onPressed: () {
                    //                 vm.getAllPost();
                    //               },
                    //               child: Text("Try again"),
                    //             )
                    //           ],
                    //         ));
                    //       }
                    //     }),
                    // ),
                    vm.isPostFetched.value
                        ? ListView.builder(
                            itemCount: vm.postList.length,
                            itemBuilder: (context, i) {
                              return PostContainer(postData: vm.postList[i]);
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
                            : const Center(child: CircularProgressIndicator()),
              ),
            ],
          ),
        ));
      }), //kk
    );
  }
}
