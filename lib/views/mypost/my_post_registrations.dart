import 'package:evika/view_models/common_viewmodel.dart';
import 'package:evika/views/mypost/my_post_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';

class MyPostRegistrations extends StatelessWidget {
  const MyPostRegistrations({super.key});

  @override
  Widget build(BuildContext context) {
    CommonVM commonVM = Get.find<CommonVM>();
    return GetBuilder<MyPostDetailsViewModel>(
      builder: (vm) => Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          foregroundColor: Colors.black,
          elevation: 1,
          title: Text(
            "Registrations: ${commonVM.individualPostData!.title ?? 'You Post'}",
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
