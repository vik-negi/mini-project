abstract class PostDetailsRepo {
  Future<List<Map<String, dynamic>>> getPostRegistrations(String postId);
}
