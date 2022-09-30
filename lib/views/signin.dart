import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:frontend/view_models/signup_viewmodel.dart';
import 'package:frontend/views/home.dart';
import 'package:get/get.dart';

class SigninPage extends StatelessWidget {
  SigninPage({super.key});

  final TextEditingController _usernameController = TextEditingController();

  final TextEditingController _passwordController = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  SignupVM signupvm = Get.put(SignupVM());

  Map<dynamic, dynamic>? response = {};

  @override
  Widget build(BuildContext context) {
    return GetBuilder<SignupVM>(builder: (vm) {
      return Scaffold(
        body: Container(
          margin: const EdgeInsets.only(top: 50),
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Column(
                    children: [
                      TextFormField(
                        controller: _usernameController,
                        decoration: const InputDecoration(
                          label: Text("Username"),
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      TextFormField(
                        controller: _passwordController,
                        decoration: const InputDecoration(
                          label: Text("Password"),
                        ),
                      ),
                      const SizedBox(
                        height: 50,
                      ),
                      ElevatedButton(
                        onPressed: () async {
                          if (_formKey.currentState!.validate()) {
                            Map data = {
                              "username": _usernameController.text,
                              "password": _passwordController.text
                            };
                            response = (await vm.userSignin(
                                _usernameController.text,
                                _passwordController.text))!;
                          }
                          print(response);
                          if (response != null) {
                            if (response!["status"] == "success") {
                              Get.offAll(() => HomePage());
                            }
                          }
                        },
                        child: const Text("Sign In"),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      );
    });
  }
}
