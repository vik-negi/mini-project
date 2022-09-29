abstract class ApiInterface {
  Future<Map<String, dynamic>>? userSignin(Map data);
  Future<Map<String, dynamic>>? userSignup(Map data);
}
