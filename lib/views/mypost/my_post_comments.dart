import 'package:evika/views/mypost/my_post_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';

class MyPostComments extends StatelessWidget {
  const MyPostComments({super.key});

  @override
  Widget build(BuildContext context) {
    MyPostDetailsViewModel vm = Get.find<MyPostDetailsViewModel>();
    return GetBuilder<MyPostDetailsViewModel>(
      builder: (vm) => Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          foregroundColor: Colors.black,
          elevation: 1,
          title: Text(
            vm.post.title ?? "Comments",
            style: const TextStyle(
              color: Colors.black,
              fontSize: 17,
            ),
          ),
        ),
      ),
    );
  }
}
