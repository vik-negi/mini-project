import 'package:evika/data/remote/api_services/login_api_service.dart';
import 'package:evika/repositories/login_repo/login_repo.dart';
import 'package:flutter/cupertino.dart';

class LoginRepoImp extends LoginRepo {
  LoginApiServices loginApiServices = LoginApiServices();

  @override
  Future<Map<String, dynamic>?> userSignin(Map data) async {
    dynamic response = await loginApiServices.userSignin(data);
    debugPrint("signin Repo Imp $response");
    if (response != null) {
      return response;
    } else {
      return null;
    }
  }

  @override
  Future<Map>? userSignup(Map data) {
    dynamic response = loginApiServices.userSignup(data);
    debugPrint("signup Repo Imp $response");
    return response;
  }
}
