import 'package:evika/view_models/signup_viewmodel.dart';
import 'package:evika/views/signin.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

enum AccountType { Individual, Organization }

class SignUpFrom extends StatefulWidget {
  SignUpFrom({super.key});

  @override
  State<SignUpFrom> createState() => _SignUpFromState();
}

class _SignUpFromState extends State<SignUpFrom> {
  SignupVM signupvm = Get.put(SignupVM());

  final _formKey = GlobalKey<FormState>();

  AccountType _accountType = AccountType.Individual;
  Map<dynamic, dynamic>? data = {};

  @override
  Widget build(BuildContext context) {
    return GetBuilder<SignupVM>(builder: (vm) {
      return Scaffold(
        body: Column(
          children: [
            const SizedBox(
              height: 50,
            ),
            Form(
              key: _formKey,
              child: Container(
                height: MediaQuery.of(context).size.height - 50,
                child: Stepper(
                  elevation: 0,
                  type: StepperType.horizontal,
                  onStepCancel: vm.onStepCancel,
                  onStepContinue: vm.onStepContinue,
                  currentStep: vm.currentStep,
                  onStepTapped: (int step) {
                    vm.onTapped(step);
                  },
                  steps: [
                    Step(
                      title: const Text(''),
                      isActive: vm.currentStep == 0 ? true : false,
                      state: vm.currentStep == 0
                          ? StepState.editing
                          : StepState.complete,
                      content: Column(
                        children: [
                          Row(
                            children: [
                              Radio(
                                value: AccountType.Individual,
                                groupValue: _accountType,
                                onChanged: (value) {
                                  setState(() {
                                    _accountType = value!;
                                  });
                                },
                              ),
                              const Text('Individual'),
                            ],
                          ),
                          Row(
                            children: [
                              Radio(
                                value: AccountType.Organization,
                                groupValue: _accountType,
                                onChanged: (value) {
                                  setState(() {
                                    _accountType = value!;
                                  });
                                },
                              ),
                              const Text('Company'),
                            ],
                          ),
                        ],
                      ),
                    ),
                    Step(
                      title: Text(''),
                      isActive: vm.currentStep >= 1 ? true : false,
                      state: vm.currentStep >= 1
                          ? StepState.editing
                          : StepState.complete,
                      content: Column(
                        children: [
                          TextFormField(
                            controller: vm.nameController,
                            decoration: const InputDecoration(
                              hintText: 'Name',
                            ),
                          ),
                          TextFormField(
                            controller: vm.usernameController,
                            decoration: const InputDecoration(
                              hintText: 'Username',
                            ),
                          ),
                          TextFormField(
                            controller: vm.emailController,
                            decoration: const InputDecoration(
                              hintText: 'Email',
                            ),
                          ),
                          TextFormField(
                            controller: vm.mobileController,
                            decoration: const InputDecoration(
                              hintText: 'Mobile',
                            ),
                          ),
                          TextFormField(
                            controller: vm.passwordController,
                            decoration: const InputDecoration(
                              hintText: 'Password',
                            ),
                          ),
                          TextFormField(
                            controller: vm.confirmPasswordController,
                            decoration: const InputDecoration(
                              hintText: 'Confirm Password',
                            ),
                          ),
                        ],
                      ),
                    ),
                    Step(
                      title: const Text(''),
                      content: Column(
                        children: [
                          ElevatedButton(
                            onPressed: () async {
                              data = await vm.userSignup(
                                  vm.nameController.text,
                                  vm.usernameController.text,
                                  vm.emailController.text,
                                  vm.mobileController.text,
                                  vm.passwordController.text,
                                  vm.confirmPasswordController.text,
                                  _accountType.toString().split(".")[1]);
                              if (data != null) {
                                // Get.snackbar('Success', 'User Created Successfully');
                                if (data!["status"] == "success") {
                                  Get.snackbar(
                                      'Success', 'User Created Successfully');
                                } else {
                                  Get.snackbar('Error', 'User Creation Failed');
                                }
                              }
                            },
                            child: const Text('Submit'),
                          ),
                          Obx(() => vm.isSignup
                              ? ElevatedButton(
                                  onPressed: () {
                                    Get.offAll(SigninPage());
                                  },
                                  child: const Text("Signin"))
                              : Container())
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      );
    });
  }
}
