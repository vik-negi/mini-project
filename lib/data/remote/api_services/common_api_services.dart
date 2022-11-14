import 'dart:convert';

import 'package:evika/data/remote/api_interface.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

// const String baseUrl = 'http://192.168.43.65:8000';
// const String baseUrl = 'http://172.11.10.136:8000';
// const String baseUrl = 'http://192.168.137.94:8000'; //rohit laptop
// const String baseUrl = 'http://192.168.191.65:8000'; //rohit
const String baseUrl = 'http://192.168.252.65:8000'; //Aman
// const String baseUrl = 'http://192.168.43.65:8000'; //mobile hotspot
// const String baseUrl = 'http://192.168.100.112:8000';
// const String baseUrl = 'http://172.11.10.77:8000';
// const String baseUrl = 'http://localhost:8000';
// const String baseUrl = 'http://evika.herokuapp.com';

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
