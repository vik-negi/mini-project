import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:evika/data/remote/api_services/api_services.dart';
import 'package:evika/models/user/post_model.dart';
import 'package:evika/utils/sharedPreferenced.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';
import 'package:shared_preferences/shared_preferences.dart';

var dio = Dio();

class PostApiServices {
  ApiServices apiServices = ApiServices();
  Future<Map<String, dynamic>> getAllPosts() async {
    try {
      // print("fetched");
      final response =
          await http.get(Uri.parse('$baseUrl/api/user/get-all-posts'));
      // print(response.statusCode);
      // print(response);
      if (response.statusCode == 200) {
        // print(response.body);
        Map<String, dynamic> body = apiServices.returnResponse(response);
        return body;
      } else {
        throw Exception('Failed to load post');
      }
    } catch (err) {
      // print(err);
    }
    return {};
  }

  Future<String?> createPost(MultipartRequest request) async {
    String? x = await SharedPrefs.getString('token');
    debugPrint("Current Token: ${x ?? "No Token Found!"}");
    const api = '$baseUrl/api/user/create-post';
    try {
      print("pppppppppppppppppppppp");

      // print("pppppppppppppppppppppp");
      var response = await request.send();
      var responseData = await response.stream.toBytes();
      var responseString = String.fromCharCodes(responseData);
      // print(response);
      if (response.statusCode == 200) {
        // Map<String, dynamic> body = apiServices.returnResponse(response);

        return responseString;
      } else {
        throw Exception('Failed to create post');
      }
    } catch (err) {
      // print("Catch Error $err");
      // print(err);
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
        return {"err": 'Failed to like post'};
      }
    } catch (err) {
      print(err);
      Get.snackbar("error", err.toString());
      return null;
    }
  }
}
