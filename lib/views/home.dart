import 'package:evika/view_models/common_viewmodel.dart';
import 'package:evika/view_models/home_viewmodel.dart/post_viewmodel.dart';
import 'package:evika/view_models/signin_signup_viewmodel.dart/signin_viewmodel.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:share_plus/share_plus.dart';

class HomePage extends StatefulWidget {
  HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool showMore = false;

  CommonVM commonVM = Get.put(CommonVM());
  PostVM vm = Get.put(PostVM());
  @override
  Widget build(BuildContext context) {
    return GetBuilder<CommonVM>(builder: (commonVM) {
      return GetBuilder<PostVM>(builder: (vm) {
        return ListView.builder(
            physics: const BouncingScrollPhysics(),
            itemCount: vm.postList.length,
            itemBuilder: (context, i) {
              return Container(
                  margin:
                      const EdgeInsets.symmetric(vertical: 10, horizontal: 5),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Column(
                            children: [
                              const CircleAvatar(
                                radius: 30,
                                backgroundImage: NetworkImage(
                                    'https://www.w3schools.com/howto/img_avatar.png'),
                              ),
                              const SizedBox(
                                height: 50,
                              ),
                              CircleAvatar(
                                radius: 25,
                                backgroundColor: Colors.white,
                                child: IconButton(
                                    onPressed: () async {
                                      commonVM.tapOnLikedButton =
                                          !commonVM.tapOnLikedButton;
                                      commonVM.tapOnLikedButtonFun();
                                      commonVM.update();
                                      await vm.likePost(vm.postList[i].id);
                                      await commonVM.likedPost();
                                      // commonVM.update();
                                    },
                                    icon: Icon(
                                      Icons.favorite_border,
                                      color: commonVM.isLikedPost(
                                                  vm.postList[i].id!) ||
                                              commonVM.tapOnLikedButton
                                          ? Colors.pink
                                          : Colors.grey.shade600,
                                      size: 30,
                                    )),
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              CircleAvatar(
                                radius: 25,
                                backgroundColor: Colors.white,
                                child: IconButton(
                                  onPressed: () async {
                                    await Share.share(
                                        "Hii! I am Joining this Event I want you to be part of this");
                                  },
                                  icon: Icon(
                                    CupertinoIcons.arrowshape_turn_up_right,
                                    color: Colors.grey.shade600,
                                    size: 30,
                                  ),
                                ),
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              CircleAvatar(
                                radius: 25,
                                backgroundColor: Colors.white,
                                child: IconButton(
                                  onPressed: () async {},
                                  icon: Icon(
                                    Icons.notifications_none_outlined,
                                    color: Colors.grey.shade600,
                                    size: 30,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            padding: const EdgeInsets.only(left: 8.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: const [
                                    Text(
                                      'Vikram Negi',
                                      style: TextStyle(
                                          fontSize: 15,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    SizedBox(
                                      width: 4,
                                    ),
                                    Icon(
                                      Icons.verified,
                                      size: 22,
                                    ),
                                    SizedBox(
                                      width: 5,
                                    ),
                                    Text(
                                      '@vikram',
                                      style: TextStyle(fontSize: 15),
                                    ),
                                  ],
                                ),
                                RichText(
                                  text: TextSpan(
                                    // text: 'The FIFA World Cup Qatar 2022™',
                                    text: vm.postList[i].title,
                                    style: const TextStyle(
                                      color: Colors.black,
                                      fontSize: 17,
                                    ),
                                  ),
                                  // style: TextStyle(fontSize: 18),
                                ),
                                const SizedBox(
                                  height: 5,
                                ),
                                SizedBox(
                                  width: Get.width - 80,
                                  child: Stack(
                                    children: [
                                      Text(
                                        // "This is a record of France's results at the FIFA World Cup.",
                                        vm.postList[i].description!.length > 50
                                            ? vm.postList[i].description
                                                .toString()
                                                .substring(0, 50)
                                            : vm.postList[i].description
                                                .toString(),
                                        softWrap: true,
                                        style: const TextStyle(
                                          color: Colors.black,
                                          fontSize: 15,
                                        ),
                                      ),
                                      showMore
                                          ? Text(
                                              vm.postList[i].description!
                                                          .length >
                                                      50
                                                  ? vm.postList[i].description
                                                      .toString()
                                                      .substring(
                                                          50,
                                                          vm
                                                                  .postList[i]
                                                                  .description!
                                                                  .length -
                                                              1)
                                                  : "",
                                              style:
                                                  const TextStyle(fontSize: 15),
                                            )
                                          // ? const Text(
                                          //     "This is a record of France's results at the FIFA World Cup. France was one of the four European teams that participated at the inaugural World Cup in 1930 and have appeared in 15 FIFA World Cups, tied for the sixth most of any country.",
                                          //     style: TextStyle(fontSize: 15),
                                          //   )
                                          : const SizedBox(),
                                      Positioned(
                                        bottom: 0,
                                        right: 15,
                                        child: InkWell(
                                          onTap: () {
                                            setState(() {
                                              showMore = !showMore;
                                            });
                                          },
                                          child: Text(
                                            showMore ? 'less' : "more",
                                            style: const TextStyle(
                                              color: Colors.blue,
                                              fontSize: 15,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                const SizedBox(
                                  height: 20,
                                ),
                              ],
                            ),
                          ),
                          Container(
                            child: Column(children: [
                              Container(
                                width: Get.width * 0.82,
                                constraints: const BoxConstraints(
                                  // minHeight: 5.0,
                                  // minWidth: 5.0,
                                  maxHeight: 500.0,
                                ),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(16),
                                  color: Colors.red,
                                ),
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(16),
                                  child: Image.network(
                                    vm.postList[i].image![0],
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                            ]),
                          ),
                        ],
                      ),
                    ],
                  ));
            });
      });
    });
  }
}

class Suggessions extends StatefulWidget {
  Suggessions({Key? key}) : super(key: key);

  @override
  State<Suggessions> createState() => _SuggessionsState();
}

class _SuggessionsState extends State<Suggessions> {
  List<String> suggession = [
    "Plantation",
    "Education",
    "Food",
    "Health",
    "Sports",
    "Environment"
  ];
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 45,
      child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: 5,
          itemBuilder: ((context, index) {
            return Container(
              padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
              margin: const EdgeInsets.symmetric(vertical: 5, horizontal: 5),
              // style: TextButton.styleFrom(
              //   padding: const EdgeInsets.all(0),
              //   backgroundColor: Colors.grey.shade800,
              //   shape: RoundedRectangleBorder(
              //     borderRadius: BorderRadius.circular(20),
              //   ),
              // ),
              // onPressed: () {},

              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                color: Colors.grey.shade700,
              ),
              child: Padding(
                padding: const EdgeInsets.all(0),
                child: Text(
                  suggession[index],
                  style: const TextStyle(
                    color: Colors.white70,
                    fontSize: 15,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            );
          })),
    );
  }
}
