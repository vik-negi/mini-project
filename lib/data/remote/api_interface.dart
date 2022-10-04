abstract class LoginApiInterface {
  Future<Map<String, dynamic>>? userSignin(Map data);
  Future<Map<String, dynamic>>? userSignup(Map data);
}

abstract class PostApiInterface {
  Future<Map<String, dynamic>>? getAllPosts();
}
