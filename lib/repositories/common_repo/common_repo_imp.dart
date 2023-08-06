import 'package:evika/data/remote/api_services/common_api_services.dart';
import 'package:evika/models/user/post_model.dart';
import 'package:evika/repositories/common_repo/common_repo.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class CommonRepoImp extends CommonRepo {
  CommonApiServices commonApiServices = CommonApiServices();

  @override
  Future<List>? userLikedPost() async {
    List? response = await commonApiServices.userLikedPosts();
    // debugPrint("common Repo Imp $response");
    if (response != null && response.isNotEmpty) {
      return response;
    }
    return [];
  }

  @override
  Future<bool> followUser(String otherUserId) async {
    bool response = await commonApiServices.followUser(otherUserId);
    return response;
  }

  @override
  Future<List<Comment>> getAndAddComments(String postId, String? text) async {
    List? response = await commonApiServices.getAndAddComments(postId, text);
    // print("object $response");
    if (response != null && response.isNotEmpty) {
      List<Comment> commentList =
          response.map((e) => Comment.fromMap(e)).toList();

      return commentList;
    }
    return [];
  }

  @override
  Future<bool> commentFunctionality(
      String postId, String type, String commentId) async {
    bool response =
        await commonApiServices.commentFunctionality(postId, type, commentId);
    print("object $response");
    return response;
  }

  @override
  Future<Map<String, dynamic>?> otherUsersData(String userId) async {
    Map<String, dynamic>? response =
        await commonApiServices.otherUsersData(userId);
    print("object $response");
    if (response != null) {
      return response;
    }
    return {};
  }
}
