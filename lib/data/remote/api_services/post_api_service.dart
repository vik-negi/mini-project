import 'dart:convert';

import 'package:evika/data/remote/api_services/api_services.dart';
import 'package:evika/models/user/post_model.dart';
import 'package:http/http.dart' as http;

const String baseUrl = 'http://evika.herokuapp.com';
// const String baseUrl = 'http://172.11.10.2:8000';

class PostApiServices {
  ApiServices apiServices = ApiServices();
  Future<Map<String, dynamic>> getAllPosts() async {
    try {
      final response =
          await http.get(Uri.parse('$baseUrl/api/user/get-all-posts'));
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

  Future<Map<String, dynamic>?> createPost(Map<String, dynamic> data) async {
    try {
      final response = await http
          .post(Uri.parse('$baseUrl/api/user/create-post'), body: data);
      if (response.statusCode == 200) {
        Map<String, dynamic> body = apiServices.returnResponse(response);

        return body;
      } else {
        throw Exception('Failed to create post');
      }
    } catch (err) {
      print("Catch Error $err");
      print(err);
      return null;
    }
  }
}
