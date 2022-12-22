import 'package:evika/auth/further_details.dart';
import 'package:evika/view_models/signin_signup_viewmodel.dart/signup_viewmodel.dart';
import 'package:evika/views/signin.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hexcolor/hexcolor.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  String selectedValue = "";
  var phone = "";
  bool isNextClicked = true;
  SignupVM signupvm = Get.put(SignupVM());
  final _formKey = GlobalKey<FormState>();
  Map<dynamic, dynamic>? data = {};

  @override
  Widget build(BuildContext context) {
    return GetBuilder<SignupVM>(builder: (vm) {
      return Scaffold(
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 40),
            child: Center(
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
                      const SizedBox(
                        height: 15,
                      ),
                      Column(
                        children: [
                          TextFormFieldContainer(
                            controller: vm.usernameController,
                            hintText: 'Username',
                            icon: Icons.person,
                            function: () {},
                            isMobileNumber: false,
                          ),
                          const SizedBox(
                            height: 15,
                          ),
                          TextFormFieldContainer(
                            controller: vm.emailController,
                            hintText: 'Email',
                            icon: Icons.email,
                            function: () {},
                            isMobileNumber: false,
                          ),
                          const SizedBox(
                            height: 15,
                          ),
                          TextFormFieldContainer(
                            controller: vm.passwordController,
                            hintText: 'Password',
                            icon: Icons.lock,
                            function: () {},
                            isMobileNumber: false,
                            obscure: vm.showPasswordBool,
                            suffix: InkWell(
                              onTap: () {
                                vm.showPassword();
                              },
                              child: Icon(
                                vm.showPasswordBool
                                    ? Icons.visibility
                                    : Icons.visibility_off,
                                color: Colors.white70,
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
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
                              child: const Text(
                                "Next",
                                style: TextStyle(
                                    fontFamily: 'LexendDeca',
                                    color: Colors.white70,
                                    fontSize: 20),
                              ),
                              onPressed: () {
                                if (_formKey.currentState!.validate()) {
                                  Get.to(() => const FurtherDetails());
                                }
                                // setState(() {
                                //   isNextClicked = !isNextClicked;
                                // });
                              },
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
                                          Get.to(() => SigninPage());
                                        }),
                                ])),
                          )
                        ],
                      )
                    ],
                  )),
            ),
          ),
        ),
      );
    });
  }
}

class TextFormFieldContainer extends StatelessWidget {
  final IconData icon;
  final bool isMobileNumber;
  final String hintText;
  final Function function;
  Function? validator;
  final Widget? suffix;
  bool obscure = false;
  double? height;
  double? width;
  TextEditingController controller = TextEditingController();
  TextFormFieldContainer(
      {Key? key,
      required this.icon,
      required this.hintText,
      required this.function,
      required this.controller,
      required this.isMobileNumber,
      this.suffix,
      this.height,
      this.width,
      this.obscure = false})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        width: width ?? 320,
        // height: height ?? 60,
        child: TextFormField(
          controller: controller,
          keyboardType:
              isMobileNumber ? TextInputType.number : TextInputType.text,
          style: const TextStyle(
              color: Colors.white70, fontWeight: FontWeight.bold),
          obscureText: obscure,
          decoration: InputDecoration(
              filled: true,
              fillColor: HexColor('#224957'),
              prefixIcon: Icon(
                icon,
                color: Colors.white70,
              ),
              suffixIcon: suffix,
              hintText: hintText,
              hintStyle: const TextStyle(
                  fontFamily: 'LexendDeca',
                  color: Colors.white70,
                  fontWeight: FontWeight.bold),
              focusColor: Colors.red,
              border:
                  OutlineInputBorder(borderRadius: BorderRadius.circular(10))),
          validator: (val) {
            if (val == null || val.isEmpty) {
              return 'Please enter $hintText';
            }
            return null;
          },
        ));
  }
}
