import 'package:evika/data/remote/api_services/common_api_services.dart';
import 'package:evika/views/profile/profile_page_repo.dart';
import 'package:flutter/material.dart';

class ProfileRepoImp extends ProfileRepo {
  // PostApiServices postApiServices = PostApiServices();
  CommonApiServices commonApiServices = CommonApiServices();
  @override
  Future<Map<String, dynamic>?> getUserPost(String id) async {
    // try{
    debugPrint("Get User post repo called");
    Map<String, dynamic> response = await commonApiServices.getUserPost(id);
    return response;
  }
}
