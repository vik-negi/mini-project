import 'package:http/http.dart';

abstract class PostRepo {
  Future<Map>? getAllPost();
  Future<String?>? createPost(MultipartRequest data);
  Future<Map<String, dynamic>>? filterPost(Map range);
  Future<Map<String, dynamic>?>? likePost(String postId);
}
