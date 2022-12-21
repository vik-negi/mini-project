import 'package:evika/utils/colors.dart';
import 'package:evika/utils/util_widgets_and_functions.dart';
import 'package:evika/view_models/common_viewmodel.dart';
import 'package:evika/view_models/home_viewmodel.dart/post_viewmodel.dart';
import 'package:evika/views/mypost/my_post_viewmodel.dart';
import 'package:evika/views/profile/other_user_profile.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

class MyPostComments extends StatelessWidget {
  const MyPostComments({super.key});

  @override
  Widget build(BuildContext context) {
    CommonVM commonVM = Get.find<CommonVM>();

    return GetBuilder<MyPostDetailsViewModel>(
      builder: (vm) => Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          foregroundColor: Colors.black,
          elevation: 1,
          title: Row(
            children: [
              const Icon(
                Icons.message,
                size: 18,
              ),
              UtilWidgetsAndFunctions.gapx(5),
              const Text(
                "Comments",
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
        body: GetBuilder<CommonVM>(builder: (vm) {
          return ModalProgressHUD(
              inAsyncCall: vm.individualPostLoading,
              child: vm.commentList.isEmpty
                  ? SizedBox(
                      height: Get.height,
                      child: const Center(child: CircularProgressIndicator()),
                    )
                  : ListView.builder(
                      itemCount: vm.commentList.length,
                      itemBuilder: (context, index) {
                        return InkWell(
                          onTap: () {
                            commonVM
                                .otherUsersData(vm.commentList[index].userId);
                            Get.to(
                              const OtherProfilePage(),
                              transition: Transition.rightToLeft,
                            );
                          },
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 20,
                              vertical: 10,
                            ),
                            margin: const EdgeInsets.symmetric(
                              horizontal: 0,
                              vertical: 1,
                            ),
                            decoration: const BoxDecoration(
                              color: Colors.white,
                              // borderRadius: BorderRadius.circular(10),
                              boxShadow: [
                                BoxShadow(
                                  color: Color.fromARGB(255, 188, 188, 188),
                                  blurRadius: 1.0,
                                  spreadRadius: 0.0,
                                  offset: Offset(0, 1.0),
                                )
                              ],
                            ),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Container(
                                      height: 50,
                                      width: 50,
                                      margin: const EdgeInsets.only(
                                        top: 2,
                                      ),
                                      decoration: const BoxDecoration(
                                        shape: BoxShape.circle,
                                        color: Colors.grey,
                                      ),
                                      child: Image.network(
                                        vm.commentList[index].userImage,
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                    UtilWidgetsAndFunctions.gapx(20),
                                    SizedBox(
                                      width: Get.width * 0.64,
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            vm.commentList[index].name,
                                            style: const TextStyle(
                                              color: Colors.black,
                                              fontSize: 15,
                                              fontWeight: FontWeight.w600,
                                            ),
                                          ),
                                          Text(
                                            vm.commentList[index].text,
                                            style: const TextStyle(
                                              color: Colors.grey,
                                              fontSize: 13,
                                            ),
                                          ),
                                          UtilWidgetsAndFunctions.gapy(10),
                                          Row(
                                            children: [
                                              Row(
                                                children: [
                                                  const Icon(
                                                    Icons.thumb_up_alt_rounded,
                                                    color: Colors.grey,
                                                    size: 18,
                                                  ),
                                                  UtilWidgetsAndFunctions.gapx(
                                                      5),
                                                  Text(
                                                    vm.commentList[index].likes
                                                        .toString(),
                                                    style: const TextStyle(
                                                      color: AppColors
                                                          .accentTextColor,
                                                      fontSize: 15,
                                                    ),
                                                  ),
                                                ],
                                              )
                                            ],
                                          )
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                                Container(
                                  margin: const EdgeInsets.all(2),
                                  child: const Icon(
                                    CupertinoIcons.arrow_right,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      }));
        }),
      ),
    );
  }
}
