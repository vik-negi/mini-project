import 'package:evika/data/remote/api_service.dart';
import 'package:evika/resources/login_repo/login_repo.dart';
import 'package:flutter/cupertino.dart';

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
