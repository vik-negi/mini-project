import 'dart:convert';

import 'package:evika/data/remote/api_interface.dart';
import 'package:evika/data/remote/api_services/api_services.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

Future<String> getToken() async {
  SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
  return sharedPreferences.getString("token")!;
}

class CommonApiServices extends CommoApiInterface {
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
    print("common response.body : ${response.body}");
    if (response.statusCode == 200) {
      List<String> likedPosts = [];
      Map<String, dynamic> res = jsonDecode(response.body);
      likedPosts = res["data"].cast<String>();

      print("likedPosts : $likedPosts");
      return likedPosts;
    }
    return [];
  }

  @override
  Future<List>? getAndAddComments(String postId, String? text) async {
    String token = await getToken();
    print("token : $token");
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
      print(res["status"]);
      print("pppppppppppppppppppppppp");
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
    print("response :::: ${response.body}");
    if (response.statusCode == 200) {
      List comments = [];
      Map<String, dynamic> res = jsonDecode(response.body);
      comments = res["data"];

      print("get comment : $comments");
      return comments;
    }
    return [];
  }

  @override
  Future<bool> functionalityComment(String postId, String? text) async {
    String token = await getToken();
    print("token : $token");
    final response = await http.post(
        Uri.parse('$baseUrl/api/user/post-comment/$postId'),
        headers: <String, String>{
          "authorization": "Bearer $token",
        },
        body: {
          "comment": text
        });
    print("response :::: ${response.body}");
    if (response != null && response.statusCode == 200) {
      Map<String, dynamic> res = jsonDecode(response.body);
      print("add comment res : $res");
      return res["success"] == "success" ? true : false;
    }
    return false;
  }
}
