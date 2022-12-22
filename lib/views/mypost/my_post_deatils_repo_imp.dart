import 'package:evika/data/remote/api_services/post_api_service.dart';
import 'package:evika/views/mypost/my_post_detail_repo.dart';

class PostDetailsRepoImp extends PostDetailsRepo {
  PostApiServices postApiServices = PostApiServices();
  @override
  Future<List<Map<String, dynamic>>> getPostRegistrations(String postId) async {
    try {
      var response = await postApiServices.getRegisteredUsers(postId);
      if (response["status"] == "success") {
        return response["data"];
      } else {
        return [];
      }
    } catch (e) {
      return [];
    }
  }
}
