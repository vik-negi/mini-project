// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

class FollowModel {
  final String name;
  final String userName;
  final String avatar;
  final String description;
  final bool isFollow;
  String? followedByString;
  final List<String> followedBy;
  FollowModel({
    required this.name,
    required this.userName,
    required this.avatar,
    required this.description,
    required this.isFollow,
    this.followedByString,
    required this.followedBy,
  });
}

List<FollowModel> follwSuggessionList = [
  FollowModel(
    name: 'John Doe',
    userName: '@johndoe',
    avatar: "assets/img/profile/dp-4.jpg",
    description: 'Lorem ipsum dolor sit amet, consectetur adipiscing elit.',
    isFollow: false,
    followedBy: ['@amit'],
  ),
  FollowModel(
    name: 'Ram Singh',
    userName: '@ram',
    avatar: "assets/img/profile/dp-5.jpg",
    description: 'Lorem ipsum dolor sit amet, consectetur adipiscing elit.',
    isFollow: false,
    followedBy: ['@john', '@johndoe'],
  ),
  FollowModel(
    name: "Aman yadav",
    userName: '@aman',
    avatar: "assets/img/profile/dp-6.jpg",
    description: 'Lorem ipsum dolor sit amet, consectetur adipiscing elit.',
    isFollow: false,
    followedBy: ['pratik'],
  ),
  FollowModel(
    name: "Abhishek Gupta",
    userName: '@abhishek',
    avatar: "assets/img/profile/dp-7.jpg",
    description: 'Lorem ipsum dolor sit amet, consectetur adipiscing elit.',
    isFollow: false,
    followedBy: ['@vikas', '@esha', '@john'],
  ),
  FollowModel(
    name: "Dhruv Singh",
    userName: '@dhruv',
    avatar: "assets/img/profile/dp-8.jpg",
    description: 'Lorem ipsum dolor sit amet, consectetur adipiscing elit.',
    isFollow: false,
    followedBy: ['vibhor'],
  ),
  FollowModel(
    name: 'Esha Sharma',
    userName: '@esha',
    avatar: "assets/img/profile/dp-9.jpg",
    description: 'Lorem ipsum dolor sit amet, consectetur adipiscing elit.',
    isFollow: false,
    followedBy: ['yash'],
  ),
];

class FollowWidget extends StatefulWidget {
  FollowWidget({Key? key}) : super(key: key);

  @override
  State<FollowWidget> createState() => _FollowWidgetState();
}

class _FollowWidgetState extends State<FollowWidget> {
  String followedByString = '';

  @override
  Widget build(BuildContext context) {
    for (var element in follwSuggessionList) {
      for (var i in element.followedBy) {
        followedByString += '$i, ';
      }
      element.followedByString = followedByString;
      followedByString = '';
    }
    return Container(
        height: 300,
        child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: follwSuggessionList.length,
          itemBuilder: (context, index) {
            return Container(
                margin: const EdgeInsets.symmetric(horizontal: 10),
                width: 180,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.2),
                      spreadRadius: 2,
                      blurRadius: 5,
                      offset: const Offset(0, 3), // changes position of shadow
                    ),
                  ],
                ),
                child: Column(
                  children: [
                    Stack(
                      children: [
                        Container(
                          width: 180,
                          child: Column(
                            children: [
                              const SizedBox(
                                height: 10,
                              ),
                              CircleAvatar(
                                radius: 50,
                                backgroundImage: AssetImage(follwSuggessionList[
                                        index]
                                    .avatar), // no matter how big it is, it won't overflow
                              ),
                            ],
                          ),
                        ),
                        Positioned(
                          right: 5,
                          top: -15,
                          child: Align(
                            alignment: Alignment.topLeft,
                            child: Container(
                                margin:
                                    const EdgeInsets.only(left: 20, top: 20),
                                child: Icon(
                                  Icons.close,
                                  color: Colors.grey.shade800,
                                )),
                          ),
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          follwSuggessionList[index].name,
                          style: const TextStyle(
                              fontSize: 17,
                              fontWeight: FontWeight.w600,
                              color: Colors.black),
                        ),
                        const Icon(Icons.verified,
                            color: Colors.blue, size: 20),
                      ],
                    ),
                    Text(
                      follwSuggessionList[index].userName,
                      style: const TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                          color: Colors.grey),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(
                          vertical: 10, horizontal: 20),
                      decoration: BoxDecoration(
                        color: Colors.black,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Text(
                        "Follow",
                        style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                            color: Colors.grey.shade200),
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          const Icon(Icons.people),
                          const SizedBox(
                            width: 10,
                          ),
                          SizedBox(
                            width: 130,
                            child: RichText(
                              text: TextSpan(
                                text:
                                    follwSuggessionList[index].followedByString,
                                style: const TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w400,
                                    color: Colors.grey),
                              ),
                            ),
                          ),
                        ],
                      ),
                    )
                  ],
                ));
          },
        ));
  }
}
