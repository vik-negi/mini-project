import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:evika/data/remote/api_services/api_services.dart';
import 'package:evika/models/user/post_model.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';
import 'package:shared_preferences/shared_preferences.dart';

// const String baseUrl = 'http://evika.herokuapp.com';
// const String baseUrl = 'http://172.11.10.136:8000';
// const String baseUrl = 'http://192.168.137.94:8000'; //rohit laptop
// const String baseUrl = 'http://192.168.191.65:8000'; //rohit
const String baseUrl = 'http://192.168.252.65:8000'; //Aman
// const String baseUrl = 'http://192.168.100.112:8000';
// const String baseUrl = 'http://192.168.43.65:8000'; //mobile hotspot
// const String baseUrl = 'http://172.11.10.136:8000';
// const String baseUrl = 'http://172.11.11.137:5000';

const mlBaseUrl = "https://evika-ml.herokuapp.com";
var dio = Dio();

class PostApiServices {
  ApiServices apiServices = ApiServices();
  Future<Map<String, dynamic>> getAllPosts() async {
    try {
      print("fetched");
      final response =
          await http.get(Uri.parse('$baseUrl/api/user/get-all-posts'));
      print(response.statusCode);
      print(response);
      if (response.statusCode == 200) {
        print(response.body);
        Map<String, dynamic> body = apiServices.returnResponse(response);
        return body;
      } else {
        throw Exception('Failed to load post');
      }
    } catch (err) {
      print(err);
    }
    return {};
  }

  Future<String?> createPost(MultipartRequest request) async {
    const api = '$baseUrl/api/user/create-post';
    try {
      print("pppppppppppppppppppppp");
      var response = await request.send();
      var responseData = await response.stream.toBytes();
      var responseString = String.fromCharCodes(responseData);
      print(response);
      if (response.statusCode == 200) {
        // Map<String, dynamic> body = apiServices.returnResponse(response);

        return responseString;
      } else {
        throw Exception('Failed to create post');
      }
    } catch (err) {
      print("Catch Error $err");
      print(err);
      return null;
    }
  }

  Future<Map<String, dynamic>?> likePost(String postId) async {
    var api = '$baseUrl/api/user/like-post/$postId';
    try {
      var body = {
        'postId': postId,
      };

      // String queryString = Uri.parse(queryParameters: {
      //   'postId': postId
      // }).query;

      // var requestUrl = api + '?' + queryString;
      // final uri = Uri.http(
      //     "192.168.43.65:8000", '/api/user/like-post/', queryParameters);

      // print(uri);
      // final response = await http.post(uri);
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
