import 'package:evika/data/remote/api_services/post_api_service.dart';
import 'package:evika/repositories/post_repo/post_repo.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart';

class PostRepoImp extends PostRepo {
  PostApiServices postApiServices = PostApiServices();

  @override
  Future<Map<String, dynamic>>? getAllPost() async {
    Map<String, dynamic> response = await postApiServices.getAllPosts();
    // debugPrint("Post Repo Imp $response");
    return response;
  }

  @override
  Future<Map<String, dynamic>>? filterPost(Map range) async {
    Map<String, dynamic> response = await postApiServices.filterPosts(range);
    // debugPrint("Post Repo Imp $response");
    return response;
  }

  @override
  Future<String?>? createPost(MultipartRequest data) async {
    String? response = await postApiServices.createPost(data);
    if (response != null) {
      debugPrint("Post Repo Imp $response");
      return response;
    }
    return null;
  }

  @override
  Future<Map<String, dynamic>?>? likePost(String postId) async {
    Map<String, dynamic>? response = await postApiServices.likePost(postId);
    if (response != null) {
      debugPrint("Post Repo Imp $response");
      return response;
    }
    return null;
  }
}
