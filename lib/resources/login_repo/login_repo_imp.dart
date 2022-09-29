import 'package:flutter/cupertino.dart';
import 'package:frontend/data/remote/api_service.dart';
import 'package:frontend/resources/login_repo/login_repo.dart';

class LoginRepoImp extends LoginRepo {
  ApiServices apiServices = ApiServices();

  @override
  Future<Map>? userSignin(Map data) {
    dynamic response = apiServices.userSignin(data);
    debugPrint("signin Repo Imp $response");
    return response;
  }

  @override
  Future<Map>? userSignup(Map data) {
    dynamic response = apiServices.userSignup(data);
    debugPrint("signup Repo Imp $response");
    return response;
  }
}
