import 'package:evika/auth/signup.dart';
import 'package:evika/view_models/signin_signup_viewmodel.dart/signup_viewmodel.dart';
import 'package:evika/views/otp.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hexcolor/hexcolor.dart';

class FurtherDetails extends StatefulWidget {
  const FurtherDetails({super.key});
  static String verify = "";

  @override
  State<FurtherDetails> createState() => _FurtherDetailsState();
}

class _FurtherDetailsState extends State<FurtherDetails> {
  int currentStep = 0;
  var phone = "";

  SignupVM vm = Get.put(SignupVM());

  void sendOtp() async {
    Get.to(() => const MyOtp());
    await FirebaseAuth.instance.verifyPhoneNumber(
      phoneNumber: "+91${vm.mobileController.text}",
      verificationCompleted: (PhoneAuthCredential credential) {},
      verificationFailed: (FirebaseAuthException e) {},
      codeSent: (String verificationId, int? resendToken) {
        FurtherDetails.verify = verificationId;
      },
      codeAutoRetrievalTimeout: (String verificationId) {},
    );
  }

  final stepperKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return GetBuilder<SignupVM>(builder: (vm) {
      return Scaffold(
        body: Container(
            padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 40),
            child: Stepper(
              elevation: 0.0,
              type: StepperType.horizontal,
              currentStep: currentStep,
              onStepCancel: () => currentStep == 0
                  ? Get.to(() => const RegisterPage())
                  : setState(() {
                      currentStep -= 1;
                    }),
              onStepContinue: () async {
                bool isLastStep = (currentStep == getSteps().length - 1);
                if (isLastStep) {
                  if (vm.locationData != null) {
                    debugPrint("fetched by fetching location");
                    vm.userSignup();
                  } else if (vm.locality1.text != "" &&
                      vm.adminArea1.text != "" &&
                      vm.postalCode1.text != "") {
                    vm.findPositionByAddress();
                    debugPrint("fetched by entering the location");
                    vm.userSignup();
                  } else {
                    Get.snackbar("Alert", "Location is required!");
                  }
                } else if (currentStep == 0) {
                  debugPrint("ssssssssssssss");
                  debugPrint(vm.selectedValue);
                  if (vm.selectedValue != "") {
                    setState(() {
                      currentStep += 1;
                    });
                  } else {
                    Get.snackbar("Error", "select account type");
                  }
                } else {
                  if (stepperKey.currentState!.validate()) {
                    setState(() {
                      currentStep += 1;
                    });
                  }
                }
              },
              // onStepTapped: (step) => setState(() {
              //   currentStep = step;
              // }),
              steps: getSteps(),
            )),
      );
    });
  }

  List<Step> getSteps() {
    return <Step>[
      Step(
        state: currentStep > 0 ? StepState.complete : StepState.indexed,
        isActive: currentStep >= 0,
        title: const Text("Account Type"),
        content: GetBuilder<SignupVM>(builder: (vm) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                "Further Details",
                style: TextStyle(
                    fontFamily: 'LexendDeca',
                    fontSize: 30,
                    color: HexColor('#224957')),
              ),
              const SizedBox(
                height: 40,
              ),
              Row(
                children: [
                  Text(
                    "Account Type",
                    style: TextStyle(
                        fontFamily: 'LexendDeca',
                        fontSize: 16,
                        color: HexColor('#A8A5A5'),
                        fontWeight: FontWeight.bold),
                  ),
                  const Text(
                    "*",
                    style: TextStyle(color: Colors.red),
                  )
                ],
              ),
              const SizedBox(
                height: 15,
              ),
              DropdownButtonFormField(
                decoration: InputDecoration(
                    prefixIcon: const Icon(
                      Icons.account_box_rounded,
                      color: Colors.white70,
                    ),
                    hintText: "None",
                    border: OutlineInputBorder(
                        borderSide: BorderSide(color: HexColor('#224957')),
                        borderRadius: BorderRadius.circular(7)),
                    hintStyle: const TextStyle(
                        color: Colors.white70,
                        fontFamily: 'LexendDeca',
                        fontWeight: FontWeight.bold),
                    filled: true,
                    fillColor: HexColor('#224957')),
                // isExpanded: true,
                iconSize: 30.0,
                style: const TextStyle(color: Colors.grey),
                items: <String>[
                  'Government Organization',
                  'Private Organization',
                  'Individual'
                ].map(
                  (val) {
                    return DropdownMenuItem<String>(
                      value: val,
                      child: Text(
                        val,
                        style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontFamily: 'LexendDeca',
                            fontSize: 16),
                      ),
                    );
                  },
                ).toList(),
                onChanged: (val) {
                  setState(
                    () {
                      vm.selectedValue = val!;
                    },
                  );
                },
              ),
              // ),
            ],
          );
        }),
      ),
      Step(
        state: currentStep > 1 ? StepState.complete : StepState.indexed,
        isActive: currentStep >= 1,
        title: const Text("Mobile"),
        content: GetBuilder<SignupVM>(builder: (vm) {
          return Form(
            key: stepperKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  "Further Details",
                  style: TextStyle(
                      fontFamily: 'LexendDeca',
                      fontSize: 30,
                      color: HexColor('#224957')),
                ),
                const SizedBox(
                  height: 40,
                ),
                Row(
                  children: [
                    Text(
                      "Name",
                      style: TextStyle(
                          fontFamily: 'LexendDeca',
                          fontSize: 16,
                          color: HexColor('#A8A5A5'),
                          fontWeight: FontWeight.bold),
                    ),
                    const Text(
                      "*",
                      style: TextStyle(color: Colors.red),
                    )
                  ],
                ),
                const SizedBox(
                  height: 15,
                ),
                TextFormFieldContainer(
                    icon: Icons.verified_user_rounded,
                    hintText: "Name",
                    isMobileNumber: false,
                    function: () {},
                    controller: vm.nameController),
                const SizedBox(
                  height: 15,
                ),
                Row(
                  children: [
                    Text(
                      "Mobile Number",
                      style: TextStyle(
                          fontFamily: 'LexendDeca',
                          fontSize: 16,
                          color: HexColor('#A8A5A5'),
                          fontWeight: FontWeight.bold),
                    ),
                    const Text(
                      "*",
                      style: TextStyle(color: Colors.red),
                    )
                  ],
                ),
                const SizedBox(
                  height: 15,
                ),
                TextFormFieldContainer(
                    icon: Icons.mobile_friendly_outlined,
                    hintText: "Phone",
                    function: () {},
                    controller: vm.mobileController,
                    isMobileNumber: true),
                // SizedBox(
                //     height: 64,
                //     child: Expanded(
                //         child: TextFormField(
                //       style: const TextStyle(
                //           color: Colors.white70,
                //           fontWeight: FontWeight.bold,
                //           fontFamily: 'LexendDeca'),
                //       controller: vm.mobileController,
                //       onChanged: ((value) => phone = value),
                //       keyboardType: TextInputType.number,
                //       inputFormatters: <TextInputFormatter>[
                //         FilteringTextInputFormatter.digitsOnly
                //       ],
                //       decoration: InputDecoration(
                //           filled: true,
                //           fillColor: HexColor('#224957'),
                //           prefixIcon: const Icon(
                //             Icons.mobile_friendly_outlined,
                //             color: Colors.white70,
                //           ),
                //           hintText: 'Phone',
                //           hintStyle: const TextStyle(
                //               color: Colors.white70,
                //               fontWeight: FontWeight.bold,
                //               fontFamily: 'LexendDeca'),
                //           focusColor: Colors.red,
                //           border: OutlineInputBorder(
                //               borderRadius: BorderRadius.circular(7))),
                //     ))),
              ],
            ),
          );
        }),
      ),
      Step(
        state: currentStep > 2 ? StepState.complete : StepState.indexed,
        isActive: currentStep >= 2,
        title: const Text("Location"),
        content: GetBuilder<SignupVM>(builder: (vm) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                "Further Details",
                style: TextStyle(
                    fontFamily: 'LexendDeca',
                    fontSize: 30,
                    color: HexColor('#224957')),
              ),
              const SizedBox(
                height: 40,
              ),
              Row(
                children: [
                  Text(
                    "Location",
                    style: TextStyle(
                        fontFamily: 'LexendDeca',
                        fontSize: 16,
                        color: HexColor('#A8A5A5'),
                        fontWeight: FontWeight.bold),
                  ),
                  const Text(
                    "*",
                    style: TextStyle(color: Colors.red),
                  )
                ],
              ),
              const SizedBox(
                height: 15,
              ),
              SizedBox(
                height: 300,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ElevatedButton(
                        onPressed: vm.determinePosition,
                        child: const Text('Allow Location')),
                    const SizedBox(
                      height: 20.0,
                    ),
                    TextFormFieldContainer(
                      icon: Icons.location_city_rounded,
                      isMobileNumber: false,
                      hintText: "Locality",
                      function: () {},
                      controller: vm.locality1,
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    TextFormFieldContainer(
                      icon: Icons.location_city_rounded,
                      hintText: "State",
                      function: () {},
                      isMobileNumber: false,
                      controller: vm.adminArea1,
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    TextFormFieldContainer(
                      icon: Icons.location_city_rounded,
                      hintText: "Postal Code",
                      isMobileNumber: true,
                      function: () {},
                      controller: vm.postalCode1,
                    )
                  ],
                ),
              ),
            ],
          );
        }),
      ),
    ];
  }
}
