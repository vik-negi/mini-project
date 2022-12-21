import 'dart:convert';

import 'package:evika/data/remote/api_interface.dart';
import 'package:evika/data/remote/api_services/api_services.dart';
import 'package:evika/utils/sharedPreferenced.dart';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

Future<String> getToken() async {
  SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
  return sharedPreferences.getString("token")!;
}

class CommonApiServices extends CommoApiInterface {
  ApiServices apiServices = ApiServices();
  @override
  Future<List<String>>? userLikedPosts() async {
    String token = await getToken();
    final response = await http.get(
      Uri.parse('$baseUrl/api/account/likedposts/'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        "authorization": "Bearer $token",
      },
    );

    // // print("common response.body : ${response.body}");
    if (response.statusCode == 200) {
      List<String> likedPosts = [];
      Map<String, dynamic> res = jsonDecode(response.body);
      likedPosts = res["data"].cast<String>();

      // print("likedPosts : $likedPosts");
      return likedPosts;
    }
    return [];
  }

  @override
  Future<List>? getAndAddComments(String postId, String? text) async {
    String token = await getToken();
    // print("token : $token");
    final response;
    if (text == null) {
      response = await http.get(
        Uri.parse('$baseUrl/api/user/get-comments/$postId'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          "authorization": "Bearer $token",
        },
      );
    } else {
      var r = await http.post(
          Uri.parse('$baseUrl/api/user/post-comment/$postId'),
          headers: <String, String>{
            "authorization": "Bearer $token",
          },
          body: {
            "comment": text
          });
      Map<String, dynamic> res = jsonDecode(r.body);
      // print(res["status"]);
      // print("pppppppppppppppppppppppp");
      if (res["status"] == "success") {
        response = await http.get(
          Uri.parse('$baseUrl/api/user/get-comments/$postId'),
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
            "authorization": "Bearer $token",
          },
        );
      } else {
        response = r;
      }
    }
    // print("response :::: ${response.body}");
    if (response.statusCode == 200) {
      List comments = [];
      Map<String, dynamic> res = jsonDecode(response.body);
      comments = res["data"];

      // print("get comment : $comments");
      return comments;
    }
    return [];
  }

  @override
  Future<bool> functionalityComment(String postId, String? text) async {
    String token = await getToken();
    // print("token : $token");
    final response = await http.post(
        Uri.parse('$baseUrl/api/user/post-comment/$postId'),
        headers: <String, String>{
          "authorization": "Bearer $token",
        },
        body: {
          "comment": text
        });
    // print("response :::: ${response.body}");
    if (response != null && response.statusCode == 200) {
      Map<String, dynamic> res = jsonDecode(response.body);
      // print("add comment res : $res");
      return res["success"] == "success" ? true : false;
    }
    return false;
  }

  @override
  Future<bool> commentFunctionality(
      String postId, String? type, String commentId) async {
    String token = await getToken();
    // print("commentId : $commentId");
    final response = await http.post(
        Uri.parse('$baseUrl/api/user/commentfunctionality/$postId'),
        headers: <String, String>{
          "authorization": "Bearer $token",
        },
        body: {
          "type": type,
          "commentID": commentId
        });
    print("response :::: ${response.body}");
    if (response != null && response.statusCode == 200) {
      Map<String, dynamic> res = jsonDecode(response.body);
      print("add comment res : $res");
      return res["success"] == "success" ? true : false;
    }
    return false;
  }

  @override
  Future<Map<String, dynamic>> getUserPost(String userId) async {
    try {
      debugPrint("fetched");
      var token = await SharedPrefs.getString("token");
      final response = await http.get(
        Uri.parse('$baseUrl/api/user/get-posts/$userId'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          "authorization": "Bearer $token",
        },
      );

      // debugPrint("get user url: $baseUrl/api/user/get-posts/$userId");
      // debugPrint('get user status code: ${response.statusCode.toString()}');
      debugPrint("get user post response: $response");
      if (response.statusCode == 200) {
        // debugPrint(response.body);
        Map<String, dynamic> body = apiServices.returnResponse(response);
        return body;
      } else {
        throw Exception('Failed to load post');
      }
    } catch (err) {
      debugPrint("$err");
    }
    return {};
  }

  @override
  Future<Map<String, dynamic>> otherUsersData(String userId) async {
    print("other user id : $userId");
    final response = await http.get(
      Uri.parse('$baseUrl/api/account/user-data/$userId'),
    );
    // print("other user response : ${response.body}");
    if (response.statusCode == 200) {
      Map<String, dynamic> body = apiServices.returnResponse(response);
      return body;
    }
    return {};
  }
}
