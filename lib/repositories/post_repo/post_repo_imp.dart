import 'package:evika/data/remote/api_services/post_api_service.dart';
import 'package:evika/repositories/post_repo/post_repo.dart';
import 'package:flutter/cupertino.dart';

class PostRepoImp extends PostRepo {
  PostApiServices postApiServices = PostApiServices();

  @override
  Future<Map<String, dynamic>>? getAllPost() async {
    Map<String, dynamic> response = await postApiServices.getAllPosts();
    // debugPrint("Post Repo Imp $response");
    return response;
  }

  @override
  Future<Map?>? createPost(Map<String, dynamic> data) async {
    Map<String, dynamic>? response = await postApiServices.createPost(data);
    if (response != null) {
      debugPrint("Post Repo Imp $response");
      return response;
    }
    return null;
  }
}
