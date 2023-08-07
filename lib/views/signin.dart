// ignore_for_file: prefer_const_constructors

import 'package:evika/utils/constants.dart';
import 'package:evika/utils/routes.dart';
import 'package:evika/utils/util_widgets_and_functions.dart';
import 'package:evika/utils/widgets/media_query_style.dart';
import 'package:evika/utils/widgets/text_form_field_container.dart';
import 'package:evika/view_models/signin_signup_viewmodel.dart/signin_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SigninPage extends StatelessWidget {
  const SigninPage({super.key});

  @override
  Widget build(BuildContext context) {
    final double width = MediaQuery.of(context).size.width;
    final double height = MediaQuery.of(context).size.height;
    final double columnWidth = Constants.mwidth + 150;

    return GetBuilder<SigninVM>(
      builder: (vm) {
        return Scaffold(
          body: MediaQueryStyle(
            isColumn: width < columnWidth,
            rowMainAxisAlignment: MainAxisAlignment.spaceBetween,
            columnMainAxisAlignment: MainAxisAlignment.center,
            columnCrossAxisAlignment: width < 300
                ? CrossAxisAlignment.center
                : CrossAxisAlignment.start,
            rowCrossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Stack(
                children: [
                  width > columnWidth
                      ? SizedBox(
                          width: width * 0.5,
                          height: height,
                          child: Image.asset(
                            "assets/img/background.jpeg",
                            fit: BoxFit.cover,
                          ),
                        )
                      : SizedBox(),
                  Center(
                    child: Container(
                      margin: EdgeInsets.symmetric(
                        horizontal: 30,
                        vertical: 10,
                      ),
                      child: Text(
                        "Let's Dive\ninto 'EVIKA'",
                        textAlign:
                            width < 300 ? TextAlign.center : TextAlign.start,
                        style: TextStyle(
                          color:
                              width > columnWidth ? Colors.white : Colors.black,
                          fontSize: width < 300
                              ? 30
                              : width > Constants.webWidth
                                  ? 60
                                  : 41,
                          fontWeight: FontWeight.w700,
                          shadows: width > columnWidth
                              ? [
                                  Shadow(
                                    blurRadius: 1.0,
                                    color: Colors.pink,
                                    offset: Offset(0, 0),
                                  ),
                                ]
                              : [],
                          fontFamily: 'Poppins',
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              width < columnWidth
                  ? UtilWidgetsAndFunctions.gapy(50)
                  : SizedBox(),
              SizedBox(
                width: width < columnWidth ? width : width * 0.5,
                child: Center(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      width > columnWidth
                          ? SizedBox(
                              child: Text(
                                "Enter Details",
                                style: TextStyle(
                                  color: Colors.pink,
                                  fontSize: 30,
                                  fontWeight: FontWeight.w700,
                                  fontFamily: 'Poppins',
                                ),
                              ),
                            )
                          : SizedBox(),
                      width > columnWidth
                          ? UtilWidgetsAndFunctions.gapy(50)
                          : SizedBox(),
                      TextFormFieldContaier(
                        width: width,
                        controller: vm.usernameController,
                        label: Container(
                          margin:
                              width < 300 ? null : EdgeInsets.only(left: 40),
                          child: Text("Username or Email"),
                        ),
                        errorText: vm.usernameErrorText,
                        hintText: "Enter username",
                        obscure: false,
                      ), // username and email filed
                      UtilWidgetsAndFunctions.gapy(10),
                      TextFormFieldContaier(
                        controller: vm.passwordController,
                        width: width,
                        label: Container(
                          margin:
                              width < 300 ? null : EdgeInsets.only(left: 40),
                          child: Text("Password"),
                        ),
                        errorText: vm.passwordErrorText,
                        hintText: "password",
                        obscure: vm.isPasswordVisible,
                        suffixIcon: IconButton(
                          onPressed: () {
                            vm.switchPasswordVisibility();
                          },
                          icon: vm.isPasswordVisible
                              ? Icon(Icons.visibility_off)
                              : Icon(Icons.visibility),
                        ),
                      ), // Password Field
                      UtilWidgetsAndFunctions.gapy(30),
                      Container(
                        margin: EdgeInsets.symmetric(horizontal: 20),
                        child: InkWell(
                          onTap: () {
                            vm.userSignin();
                          },
                          child: Container(
                            width: width < Constants.mwidth ? 280 : 300,
                            padding: EdgeInsets.symmetric(
                                vertical: 10, horizontal: 20),
                            decoration: BoxDecoration(
                              color: Colors.pink,
                              borderRadius: BorderRadius.circular(
                                50,
                              ),
                            ),
                            child: Text(
                              "Login",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontSize: 20,
                                fontFamily: "Poppins",
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                      ),
                      UtilWidgetsAndFunctions.gapy(20),
                      Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text("Don't have an account? "),
                          InkWell(
                            onTap: () {
                              Get.toNamed(AppRotutes.signup);
                            },
                            child: Text(
                              "Sign up",
                              style: TextStyle(
                                color: Colors.pink,
                              ),
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
