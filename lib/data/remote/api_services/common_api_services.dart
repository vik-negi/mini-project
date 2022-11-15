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
}
