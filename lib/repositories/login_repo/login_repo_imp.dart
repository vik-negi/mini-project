import 'package:evika/data/remote/api_services/login_api_service.dart';
import 'package:evika/repositories/login_repo/login_repo.dart';
import 'package:flutter/cupertino.dart';

class LoginRepoImp extends LoginRepo {
  LoginApiServices loginApiServices = LoginApiServices();

  @override
  Future<Map>? userSignin(Map data) {
    dynamic response = loginApiServices.userSignin(data);
    debugPrint("signin Repo Imp $response");
    return response;
  }

  @override
  Future<Map>? userSignup(Map data) {
    dynamic response = loginApiServices.userSignup(data);
    debugPrint("signup Repo Imp $response");
    return response;
  }
}
