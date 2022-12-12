import 'package:blur/blur.dart';
import 'package:evika/utils/colors.dart';
import 'package:evika/utils/routes.dart';
import 'package:evika/utils/ui_utility_widgets.dart';
import 'package:evika/view_models/profile_viewmodels/profile_viewmodel.dart';
import 'package:evika/views/profile/widget/own_post_card.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ProfilePage extends StatelessWidget {
  ProfilePage({super.key});
  final ProfileVM vm = Get.put(ProfileVM());

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ProfileVM>(
      builder: (vm) => Scaffold(
        appBar: AppBar(
          elevation: 1,
          title: const Text("My Profile"),
          backgroundColor: Colors.white,
          foregroundColor: Colors.black,
          actions: [
            TextButton(
              child: Row(
                children: const [
                  Text(
                    "Log out",
                    style: TextStyle(
                        color: Colors.black,
                        fontFamily: "Poppins",
                        fontSize: 16),
                  ),
                  SizedBox(
                    width: 4,
                  ),
                  Icon(
                    Icons.logout,
                    size: 16,
                    color: Colors.black,
                  ),
                ],
              ),
              onPressed: () {
                showDialog(
                    context: context,
                    builder: (context) {
                      return AlertDialog(
                        title: const Text("Log-out"),
                        content:
                            const Text("Are you sure you want to log-out?"),
                        actions: [
                          TextButton(
                              onPressed: () {
                                Get.back();
                              },
                              child: const Text("No")),
                          TextButton(
                              onPressed: () async {
                                Get.back();
                                await vm.logout();
                                Get.offAndToNamed(AppRotutes.signin);
                              },
                              child: const Text("Yes")),
                        ],
                      );
                    });
              },
            ),
          ],
        ),
        body: SingleChildScrollView(
          child: Container(
              color: Colors.white,
              width: Get.width,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Stack(
                    children: [
                      Container(
                        color: Colors.green,
                      ),
                      Blur(
                        blur: 50,
                        child: Image.network(
                          vm.userData.profileImage!,
                          fit: BoxFit.cover,
                          width: Get.width,
                          height: 230,
                          color: Colors.white,
                          colorBlendMode: BlendMode.modulate,
                        ),
                      ),
                      SizedBox(
                        width: Get.width,
                        child: Column(
                          children: [
                            Container(
                              margin:
                                  const EdgeInsets.only(top: 40, bottom: 20),
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(50),
                                child: Image.network(
                                  vm.userData.profileImage!,
                                  height: 100,
                                  width: 100,
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                            Column(
                              children: [
                                FittedBox(
                                  child: Column(children: [
                                    Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        Text(
                                          vm.userData.name,
                                          style: const TextStyle(
                                            color: Colors.black,
                                            fontSize: 18,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        const Icon(
                                          Icons.verified_rounded,
                                          size: 18,
                                        )
                                      ],
                                    ),
                                    Text(
                                      vm.userData.username,
                                      style: TextStyle(
                                        color: Colors.grey.shade700,
                                        fontSize: 14,
                                      ),
                                    ),
                                  ]),
                                )
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Column(
                        children: [
                          const SizedBox(
                            height: 25,
                            child: Text(
                              "12k",
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 15,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          Text(
                            "Followers",
                            style: TextStyle(
                              color: Colors.grey.shade700,
                            ),
                          ),
                        ],
                      ),
                      Column(
                        children: [
                          const SizedBox(
                            height: 25,
                            child: Text(
                              "123",
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 15,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          Text(
                            "Following",
                            style: TextStyle(
                              color: Colors.grey.shade700,
                            ),
                          ),
                        ],
                      ),
                      Column(
                        children: [
                          const SizedBox(
                            height: 25,
                            child: Text(
                              "29k",
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 15,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          Text(
                            "Post Likes",
                            style: TextStyle(
                              color: Colors.grey.shade700,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  const Divider(
                    height: 20,
                    thickness: 1,
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 10,
                      vertical: 10,
                    ),
                    margin: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.shade300,
                            blurRadius: 0,
                            spreadRadius: 1,
                            offset: const Offset(0, 2),
                          )
                        ]),
                    child: Column(
                      children: [
                        RichText(
                          text: TextSpan(
                            // text: vm.userData.bio!,

                            text:
                                "I am a flutter Developer who currently enrolled in the BS degree in Data Science and Programming in IIT Madras and I am also the developer of this app I am a flutter Developer who currently enrolled in the BS degree in Data Science and Programming in IIT Madras and I am also the developer of this app",
                            style: TextStyle(
                              color: Colors.grey.shade900,
                              fontSize: 14,
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        const Divider(
                          height: 20,
                          thickness: 1,
                        ),
                        Container(
                          margin: const EdgeInsets.symmetric(vertical: 10),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              // Create Post Button
                              TextButton(
                                onPressed: () {
                                  Get.toNamed(
                                    AppRotutes.createPost,
                                  );
                                },
                                child: Container(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 30,
                                    vertical: 15,
                                  ),
                                  decoration: BoxDecoration(
                                    color: Colors.grey.shade200,
                                    borderRadius: const BorderRadius.all(
                                        Radius.circular(25)),
                                  ),
                                  child: Center(
                                    child: Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: const [
                                        Text(
                                          "Add Event",
                                          style: TextStyle(
                                            // color: Colors.black,
                                            fontSize: 12,
                                          ),
                                        ),
                                        SizedBox(
                                          width: 5,
                                        ),
                                        Icon(
                                          Icons.edit_note_sharp,
                                          size: 18,
                                          color: Colors.blue,
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),

                              // Edit Profile Button
                              TextButton(
                                onPressed: () {},
                                child: Container(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 30,
                                    vertical: 15,
                                  ),
                                  decoration: BoxDecoration(
                                    color: Colors.grey.shade200,
                                    borderRadius: const BorderRadius.all(
                                        Radius.circular(25)),
                                  ),
                                  child: Center(
                                    child: Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: const [
                                        Text(
                                          "Edit Profile",
                                          style: TextStyle(
                                            // color: Colors.black,
                                            fontSize: 12,
                                          ),
                                        ),
                                        SizedBox(
                                          width: 5,
                                        ),
                                        Icon(
                                          Icons.edit,
                                          size: 13,
                                          color: Colors.blue,
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                  Container(
                    width: double.infinity,
                    margin: const EdgeInsets.symmetric(
                      horizontal: 20,
                      vertical: 10,
                    ),
                    child: Row(
                      children: [
                        const Icon(
                          CupertinoIcons.collections_solid,
                          size: 18,
                        ),
                        gapx(5),
                        const Text(
                          "Your Events",
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                  OwnPostCard(
                    title:
                        "Meenakshi Temple in madurai pooja association fully colorfully and unique of its kind",
                    imgUrl:
                        "https://media.istockphoto.com/id/490736905/photo/meenakshi-hindu-temple-in-madurai-tamil-nadu-south-india.jpg?s=612x612&w=0&k=20&c=OlOLvdryIdkdyKcY9gRPsM1RZa5HiP6QBr2JVAIvPb0=",
                    shares: "3.4K",
                    likes: "23K",
                    comments: "1.2K",
                    registrations: "23",
                    date: DateTime(2022, 11, 12),
                    route: AppRotutes.myPostDetails,
                  ),
                ],
              )),
        ),
      ),
    );
  }

  Widget showIconAndTextOnPost({IconData? icon, String? text}) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 5, vertical: 4),
      padding: const EdgeInsets.symmetric(
        horizontal: 10,
        vertical: 3,
      ),
      decoration: BoxDecoration(
        color: AppColors.accentColor,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        children: [
          icon != null
              ? Icon(
                  icon,
                  size: 18,
                )
              : const SizedBox(),
          icon != null ? gapx(4) : const SizedBox(),
          text != null ? Text(text) : const SizedBox(),
        ],
      ),
    );
  }
}
