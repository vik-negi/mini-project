import 'package:evika/auth/login.dart';
import 'package:evika/view_models/signin_signup_viewmodel.dart/signup_viewmodel.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_connect/http/src/utils/utils.dart';
import 'package:hexcolor/hexcolor.dart';

enum AccountType { Individual, Organization }

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  bool valuefirst = false;

  SignupVM signupvm = Get.put(SignupVM());
  final _formKey = GlobalKey<FormState>();

  final AccountType _accountType = AccountType.Individual;
  Map<dynamic, dynamic>? data = {};
  @override
  Widget build(BuildContext context) {
    return GetBuilder<SignupVM>(builder: (vm) {
      return Scaffold(
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 40),
            child: Center(
              child: Container(
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
                        "Register",
                        style: TextStyle(
                            fontSize: 40,
                            color: HexColor('#224957'),
                            fontFamily: 'LexendDeca'),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Text(
                        "Lets Register to see What's new",
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
                      Container(
                        width: 320,
                        decoration: BoxDecoration(
                            color: HexColor('#224957'),
                            borderRadius: BorderRadius.circular(10)),
                        child: DropdownButton(
                          icon: const Icon(
                            Icons.arrow_drop_down,
                            color: Colors.white70,
                          ),
                          dropdownColor: HexColor('#224957'),
                          style: const TextStyle(
                              color: Colors.white70,
                              fontFamily: 'LexendDeca',
                              fontSize: 16),
                          hint: const Padding(
                            padding: EdgeInsets.symmetric(
                                vertical: 8.0, horizontal: 10),
                            child: SizedBox(
                              width: 270,
                              child: Text('  Select Type'),
                            ),
                          ), // Not necessary for Option 1
                          value: "  ${vm.selectedUserType}",
                          onChanged: (newValue) {
                            setState(() {
                              vm.selectedUserType = newValue;
                            });
                          },
                          items: vm.userType.map((type) {
                            return DropdownMenuItem(
                              value: type,
                              child: Container(
                                decoration: BoxDecoration(
                                    color: HexColor('#224957'),
                                    borderRadius: BorderRadius.circular(10)),
                                child: Text(type),
                              ),
                            );
                          }).toList(),
                        ),
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      TextFormFieldContainer(
                        controller: vm.usernameController,
                        hintText: 'Username',
                        icon: Icons.person,
                        function: () {},
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      TextFormFieldContainer(
                        controller: vm.emailController,
                        hintText: 'Email',
                        icon: Icons.email,
                        function: () {},
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      TextFormFieldContainer(
                        controller: vm.passwordController,
                        hintText: 'Password',
                        icon: Icons.lock,
                        function: () {},
                      ),
                      const SizedBox(
                        height: 5.5,
                      ),
                      vm.isNextClicked
                          ? Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Checkbox(
                                  checkColor: Colors.white70,
                                  activeColor: HexColor('#224957'),
                                  value: this.valuefirst,
                                  onChanged: (value) {
                                    setState(() {});
                                  },
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(14.0),
                                  child: Row(
                                    children: [
                                      Text(
                                        "Remember me",
                                        style: TextStyle(
                                            fontFamily: 'LexendDeca',
                                            fontWeight: FontWeight.bold,
                                            fontSize: 15,
                                            color: HexColor('#224957')),
                                      ),
                                      const SizedBox(
                                        width: 40,
                                      ),
                                    ],
                                  ),
                                )
                              ],
                            )
                          : Container(),
                      SizedBox(
                        width: 320,
                        height: 50,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              backgroundColor: HexColor('#224957'),
                              // const Color.fromARGB(249, 82, 255, 82),
                              elevation: 0,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10))),
                          child: Text(
                            vm.isNextClicked ? "Register" : "Next",
                            style: const TextStyle(
                                fontFamily: 'LexendDeca',
                                color: Colors.white70,
                                fontSize: 20),
                          ),
                          onPressed: () {},
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(
                          top: 7,
                        ),
                        child: Text.rich(TextSpan(
                            text: "Don't have an account? ",
                            style: const TextStyle(
                                fontFamily: 'LexendDeca', fontSize: 14),
                            children: <TextSpan>[
                              TextSpan(
                                  text: "Login Here",
                                  style: const TextStyle(
                                      fontFamily: 'LexendDeca',
                                      fontSize: 14,
                                      decoration: TextDecoration.underline),
                                  recognizer: TapGestureRecognizer()
                                    ..onTap = () {
                                      Get.to(() => const LoginPage());
                                    }),
                            ])),
                      )
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      );
    });
  }
}

class TextFormFieldContainer extends StatelessWidget {
  final IconData icon;
  final String hintText;
  final Function function;
  double? height;
  TextEditingController controller = TextEditingController();
  TextFormFieldContainer({
    Key? key,
    required this.icon,
    required this.hintText,
    required this.function,
    required this.controller,
    this.height,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        width: 320,
        height: height ?? 60,
        child: TextFormField(
          controller: controller,
          style: const TextStyle(color: Colors.white70),
          obscureText: hintText == 'Password' ? true : false,
          decoration: InputDecoration(
              filled: true,
              fillColor: HexColor('#224957'),
              prefixIcon: Icon(
                icon,
                color: Colors.white70,
              ),
              hintText: hintText,
              hintStyle: const TextStyle(
                  fontFamily: 'LexendDeca',
                  color: Colors.white70,
                  fontWeight: FontWeight.bold),
              focusColor: Colors.red,
              border:
                  OutlineInputBorder(borderRadius: BorderRadius.circular(10))),
          validator: (val) {},
        ));
  }
}
