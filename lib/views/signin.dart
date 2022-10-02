import 'package:evika/view_models/signin_signup_viewmodel.dart/signin_viewmodel.dart';
import 'package:evika/view_models/signin_signup_viewmodel.dart/signup_viewmodel.dart';
import 'package:evika/views/home.dart';
import 'package:evika/views/sign_up_from_view.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hexcolor/hexcolor.dart';

class SigninPage extends StatelessWidget {
  SigninPage({super.key});

  final _formKey = GlobalKey<FormState>();

  SigninVM signinvm = Get.put(SigninVM());

  Map<dynamic, dynamic>? response = {};

  @override
  Widget build(BuildContext context) {
    return GetBuilder<SigninVM>(builder: (vm) {
      return GestureDetector(
        onTap: () {
          FocusScope.of(context).unfocus();
        },
        child: Scaffold(
          body: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 40),
              child: Center(
                child: SizedBox(
                  child: Form(
                    key: _formKey,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        const SizedBox(
                          height: 20,
                        ),
                        Text(
                          "Sign In",
                          style: TextStyle(
                              fontSize: 40,
                              color: HexColor('#224957'),
                              fontFamily: 'LexendDeca'),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Text(
                          "Lets Sign in To Explore",
                          style: TextStyle(
                              fontSize: 16,
                              color: HexColor('#224957').withOpacity(0.7),
                              fontFamily: "LexendDeca-Bold"),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        Image.asset(
                          'assets/img1.png',
                          height: 300,
                          width: 250,
                        ),
                        SizedBox(
                          width: 320,
                          height: 60,
                          child: TextFormField(
                            style: const TextStyle(color: Colors.white70),
                            controller: vm.usernameController,
                            decoration: InputDecoration(
                                filled: true,
                                focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10),
                                    borderSide:
                                        BorderSide(color: HexColor('#224957'))),
                                fillColor: HexColor('#224957'),
                                prefixIcon: const Icon(
                                  Icons.email,
                                  color: Colors.white70,
                                ),
                                hintText: 'Email',
                                hintStyle: const TextStyle(
                                  color: Colors.white70,
                                  fontWeight: FontWeight.bold,
                                  fontFamily: 'LexendDeca',
                                ),
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10))),
                          ),
                        ),
                        const SizedBox(
                          height: 15,
                        ),
                        SizedBox(
                          width: Get.width - 70,
                          child: TextFormField(
                              style: const TextStyle(color: Colors.white70),
                              obscureText: vm.showPasswordBool ? false : true,
                              controller: vm.passwordController,
                              decoration: InputDecoration(
                                  filled: true,
                                  fillColor: HexColor('#224957'),
                                  focusedBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10),
                                      borderSide: BorderSide(
                                          color: HexColor('#224957'))),
                                  prefixIcon: const Icon(
                                    Icons.lock,
                                    color: Colors.white70,
                                  ),
                                  suffixIcon: InkWell(
                                    onTap: () {
                                      vm.showPassword();
                                    },
                                    child: Icon(
                                      vm.showPasswordBool
                                          ? Icons.visibility_off
                                          : Icons.visibility,
                                      color: Colors.white70,
                                    ),
                                  ),
                                  hintText: 'Password',
                                  hintStyle: const TextStyle(
                                      color: Colors.white70,
                                      fontWeight: FontWeight.bold,
                                      fontFamily: 'LexendDeca'),
                                  focusColor: Colors.red,
                                  border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10))),
                              validator: (val) {
                                if (val!.length < 6) {
                                  return "Password must be at least 6 characters";
                                } else {
                                  return null;
                                }
                              }),
                        ),
                        const SizedBox(
                          height: 5.5,
                        ),
                        Container(
                          width: Get.width - 70,
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Checkbox(
                                    materialTapTargetSize:
                                        MaterialTapTargetSize.shrinkWrap,
                                    checkColor: Colors.white70,
                                    activeColor: HexColor('#224957'),
                                    value: vm.rememberMeBool,
                                    onChanged: (value) {
                                      vm.rememberMe();
                                    },
                                  ),
                                  Text(
                                    "Remember me",
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 15,
                                        fontFamily: 'LexendDeca',
                                        color: HexColor('#224957')),
                                  ),
                                ],
                              ),
                              Padding(
                                  padding: const EdgeInsets.only(
                                      top: 14.0, bottom: 14),
                                  child: Text(
                                    "Forget Password",
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontFamily: 'LexendDeca',
                                        fontSize: 15,
                                        color: HexColor('#224957'),
                                        decoration: TextDecoration.underline),
                                  ))
                            ],
                          ),
                        ),
                        SizedBox(
                          width: 320,
                          height: 50,
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                                backgroundColor: HexColor('#224957'),
                                elevation: 0,
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10))),
                            child: vm.isSigninClickedBool
                                ? const Center(
                                    child: CircularProgressIndicator(
                                      color: Colors.white,
                                      strokeWidth: 2,
                                    ),
                                  )
                                : const Text(
                                    "Sign In",
                                    style: TextStyle(
                                        fontFamily: 'LexendDeca',
                                        color: Colors.white,
                                        fontSize: 20),
                                  ),
                            onPressed: () async {
                              if (_formKey.currentState!.validate()) {
                                vm.isSigninClickedBool = true;
                                vm.update();
                                Map data = {
                                  "username": vm.usernameController.text,
                                  "password": vm.passwordController.text
                                };
                                print(vm.usernameController.text);
                                print(vm.passwordController.text);
                                response = (await vm.userSignin(
                                    vm.usernameController.text,
                                    vm.passwordController.text))!;
                              }
                              print(response);
                              if (response != null) {
                                vm.isSigninClickedBool = false;
                                if (response!["status"] == "success") {
                                  Get.to(() => HomePage());
                                }
                              }
                            },
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(
                            top: 7,
                          ),
                          child: Text.rich(
                            TextSpan(
                              text: "Don't have an account? ",
                              style: const TextStyle(
                                  color: Colors.black,
                                  fontSize: 14,
                                  fontFamily: 'LexendDeca'),
                              children: <TextSpan>[
                                TextSpan(
                                  text: "Register Here",
                                  style: const TextStyle(
                                      fontSize: 14,
                                      fontFamily: 'LexendDeca',
                                      decoration: TextDecoration.underline),
                                  recognizer: TapGestureRecognizer()
                                    ..onTap = () {
                                      Get.to(() => SignUpFrom());
                                    },
                                ),
                              ],
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      );

      // Scaffold(
      //   body: Container(
      //     margin: const EdgeInsets.only(top: 50),
      //     child: Form(
      //       key: _formKey,
      //       child: Column(
      //         children: [
      //           Container(
      //             padding: const EdgeInsets.symmetric(horizontal: 20),
      //             child: Column(
      //               children: [
      //                 TextFormField(
      //                   controller: vm.usernameController,
      //                   decoration: const InputDecoration(
      //                     label: Text("Username"),
      //                   ),
      //                 ),
      //                 const SizedBox(
      //                   height: 20,
      //                 ),
      //                 TextFormField(
      //                   controller: vm.passwordController,
      //                   decoration: const InputDecoration(
      //                     label: Text("Password"),
      //                   ),
      //                 ),
      //                 const SizedBox(
      //                   height: 50,
      //                 ),
      //                 ElevatedButton(
      //                   onPressed: () async {
      //                     if (_formKey.currentState!.validate()) {
      //                       Map data = {
      //                         "username": vm.usernameController.text,
      //                         "password": vm.passwordController.text
      //                       };
      //                       response = (await vm.userSignin(
      //                           vm.usernameController.text,
      //                           vm.passwordController.text))!;
      //                     }
      //                     print(response);
      //                     if (response != null) {
      //                       if (response!["status"] == "success") {
      //                         Get.offAll(() => HomePage());
      //                       }
      //                     }
      //                   },
      //                   child: const Text("Sign In"),
      //                 ),
      //               ],
      //             ),
      //           ),
      //         ],
      //       ),
      //     ),
      //   ),
      // );
    });
  }
}
