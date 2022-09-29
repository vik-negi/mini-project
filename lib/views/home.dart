import 'package:flutter/material.dart';
import 'package:frontend/view_models/signup_viewmodel.dart';
import 'package:get/get.dart';

class HomePage extends StatefulWidget {
  HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  SignupVM signupvm = Get.put(SignupVM());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home Page'),
      ),
      body: GetBuilder<SignupVM>(builder: (vm) {
        return Center(
          child: Text(vm.userModel.data?.email.toString() ?? "hii"),
        );
      }),
    );
  }
}
