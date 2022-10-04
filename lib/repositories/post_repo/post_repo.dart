abstract class PostRepo {
  Future<Map>? getAllPost();
  Future<Map?>? createPost(Map<String, dynamic> data);
}
