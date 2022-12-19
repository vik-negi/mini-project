abstract class LoginRepo {
  Future<Map>? userSignup(Map data);
  Future<Map<String, dynamic>?> userSignin(Map data);
  Future<Map>? updateUserLocation(Map updateLocation);
}
