import 'dart:convert';

import 'package:evika/models/user/post_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class MyPostDetailsViewModel extends GetxController {
  int activeImageNumber = 0;
  double fullCommentShown = 0;
  Map<String, dynamic>? postData;
  // PostData? post;

  // getParameters() {
  //   var tempData = Get.parameters;
  //   if (tempData['data'] != null) {
  //     postData = jsonDecode(tempData['data'] ?? "");
  //     post = PostData.fromMap(postData!);
  //   }
  // }

  // Map<String, dynamic> postObject = {
  //   "creatorUserId": "5f9f1b5b0b2b8c0c8c8c8c8c",
  //   "status": 200.toString(),
  //   "message": "Post created successfully",
  //   "accountType": "user",
  //   "data": {
  //     'createdAt': DateTime.now().toString(),
  //     'description':
  //         "The district is named after its headquarters town, Azamgarh, which was founded in 1665 by Azam, son of Vikramajit. Vikramajit a descendant of Gautam Rajputs of Mehnagar in pargana Nizamabad, like some of his predecessors, had embraced the faith of Islam. He had a Muhammadan wife who bore him two sons Azam and Azmat. While Azam gave his name to the town of Azamgarh, and the fort, Azmat constructed the fort and settled the bazar of Azmatgarh in pargana Sagri.",
  //     'eventCategory': "Sports",
  //     'eventStartAt': DateTime.now().toString(),
  //     'eventEndAt': DateTime(2020, 12, 12).toString(),
  //     'eventId': "5f9f1b5b0b2b8c0c8c8c8c8c",
  //     'eventLocation': "Indra Nagar, Azamgarh",
  //     'image': [
  //       "https://upload.wikimedia.org/wikipedia/commons/thumb/d/d4/Open_House_Day_2014.jpg/1200px-Open_House_Day_2014.jpg",
  //       "http://farm5.staticflickr.com/4694/38784890850_b0d837dae6_h.jpg",
  //       "https://i0.wp.com/childrenshouse-montessori.com/wp-content/uploads/2019/12/IMG_3155.jpg?resize=1080%2C675&ssl=1",
  //     ],
  //     'likes': 234,
  //     'postLink': "https://www.google.com/",
  //     'tags': ["Sports", "Football", "Fifa"],
  //     'title': 'Football Match in Azamgarh Stadium',
  //     'updatedAt': DateTime.now().toString(),
  //     'username': "Rohit Gupta",
  //     'userId': "5f9f1b5b0b2b8c0c8c8c8c8c",
  //     'noOfComments': 22,
  //     '_id': "5f9f1b5b0b2b8c0c8c8c8c8c",
  //   },
  // };
  // List<String> postImages = [
  //   "assets/img/profile/dp-1.jpg",
  //   "assets/img/profile/dp-1.jpg",
  //   "assets/img/profile/dp-1.jpg",
  //   "assets/img/profile/dp-1.jpg",
  // ];

  @override
  void onInit() {
    super.onInit();
    // getParameters();
  }

  toggleCommentVisibility() {
    debugPrint("Comment Visibility: $fullCommentShown");
    if (fullCommentShown == 0) {
      fullCommentShown = double.maxFinite;
    } else {
      fullCommentShown = 0;
    }
    update();
  }
}
