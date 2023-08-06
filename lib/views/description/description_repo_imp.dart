import 'package:evika/data/remote/api_services/post_api_service.dart';
import 'package:evika/views/description/description_repo.dart';
import 'package:flutter/cupertino.dart';

class DescriptionRepoImp extends DescriptionRepo {
  PostApiServices postApiServices = PostApiServices();
  @override
  Future<bool> registerUserInEvent(String eventId) async {
    try {
      Map<String, dynamic>? response =
          await postApiServices.registerUserInEvent(eventId);

      if (response == null) {
        throw ("Null Response while registering user");
      }

      if (response["status"] == "success") {
        return true;
      } else {
        return false;
      }
    } catch (e) {
      debugPrint("Description Repo: $e");
      return false;
    }
  }
}
