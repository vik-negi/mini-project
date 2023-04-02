import 'package:dio/dio.dart';
import 'package:evika/data/remote/api_services/api_services.dart';
import 'package:evika/utils/sharedPreferenced.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';
import 'package:shared_preferences/shared_preferences.dart';

var dio = Dio();
String checkBase = "Post Api Service: ";

class PostApiServices {
  ApiServices apiServices = ApiServices();

  Future<Map<String, dynamic>?> registerUserInEvent(String eventId) async {
    try {
      String? token = await SharedPrefs.getString("token");
      if (token == null) {
        throw ("Null Token");
      }
      String postId = eventId;
      final response = await http
          .put(Uri.parse('$baseUrl/api/user/register-user/$postId'), headers: {
        "authorization": "Bearer $token",
      });

      debugPrint(
          "register User in event api response: " + response.body.toString());

      if (response.statusCode == 200) {
        Map<String, dynamic> body = apiServices.returnResponse(response);
        return body;
      } else {
        throw Exception('$checkBase Failed to register user in this event !!!');
      }
    } catch (e) {
      return null;
    }
  }

  Future<Map<String, dynamic>> getAllPosts() async {
    try {
      final response =
          await http.get(Uri.parse('$baseUrl/api/user/get-all-posts'));
      // print("response get all post ${response}");
      if (response.statusCode == 200) {
        Map<String, dynamic> body = apiServices.returnResponse(response);
        return body;
      } else {
        throw Exception('$checkBase Failed to load post!!!');
      }
    } catch (err) {
      // print(err);
    }
    return {};
  }

  Future<Map<String, dynamic>> getRegisteredUsers(String eventId) async {
    try {
      String? token = await SharedPrefs.getString("token");
      if (token == null) {
        throw ("Null Token");
      }
      final response = await http.get(
        Uri.parse('$baseUrl/api/user/get-registered-user/$eventId'),
        headers: {
          "authorization": "Bearer $token",
        },
      );
      if (response.statusCode == 200) {
        Map<String, dynamic> body = apiServices.returnResponse(response);
        return body;
      } else {
        throw Exception('$checkBase Failed to load registrations!!!');
      }
    } catch (err) {
      debugPrint(err.toString());
    }
    return {};
  }

  Future<Map<String, dynamic>> filterPosts(Map range) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    String token = sharedPreferences.getString("token")!;
    try {
      debugPrint("$checkBase Trying to fetch filtered posts...");
      final response = await http
          .post(Uri.parse('$baseUrl/api/user/filter-posts'), headers: {
        "authorization": "Bearer $token",
      }, body: {
        "maxrange": range['maxrange']
      });

      if (response.statusCode == 200) {
        Map<String, dynamic> body = apiServices.returnResponse(response);
        return body;
      } else {
        throw Exception('$checkBase Failed to fetch filtered post!!!');
      }
    } catch (err) {
      debugPrint(err.toString());
    }
    return {};
  }

  Future<String?> createPost(MultipartRequest request) async {
    String? x = await SharedPrefs.getString('token');
    debugPrint("$checkBase Current Token:- ${x ?? "No Token Found!"}");
    const api = '$baseUrl/api/user/create-post';
    try {
      debugPrint("$checkBase Trying to create post... ");
      var response = await request.send();
      var responseData = await response.stream.toBytes();
      var responseString = String.fromCharCodes(responseData);
      if (response.statusCode == 200) {
        return responseString;
      } else {
        throw Exception('$checkBase Failed to create post!!!');
      }
    } catch (err) {
      return null;
    }
  }

  Future<Map<String, dynamic>?> likePost(String postId) async {
    var api = '$baseUrl/api/user/like-post/$postId';
    try {
      var body = {
        'postId': postId,
      };

      SharedPreferences sharedPreferences =
          await SharedPreferences.getInstance();
      String token = sharedPreferences.getString("token")!;
      final response = await http.post(Uri.parse(api), body: {
        'postId': postId,
      }, headers: {
        "authorization": "Bearer $token",
      });
      // print("resssssssponnnceee");
      // print("response.body : ${response.body}");
      if (response.statusCode == 200 || response.statusCode == 201) {
        Map<String, dynamic> body = apiServices.returnResponse(response);
        return body;
      } else {
        return {"err": '$checkBase Failed to like post'};
      }
    } catch (err) {
      print(err);
      Get.snackbar("error", checkBase + err.toString());
      return null;
    }
  }
}
