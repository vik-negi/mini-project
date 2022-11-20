import 'dart:convert';

import 'package:evika/data/remote/api_interface.dart';
import 'package:evika/data/remote/api_services/api_services.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class LoginApiServices extends LoginApiInterface {
  dynamic returnResponse(http.Response? response) {
    debugPrint(response!.body.toString());
    switch (response.statusCode) {
      case 200:
        dynamic responseJson = jsonDecode(response.body);
        return responseJson;
      case 400:
        throw Exception('Bad Request');
      case 401:
        return null;
      case 403:
        throw Exception('Unauthorized');
      case 500:
        return null;
      default:
        throw Exception('Internal Server Error');
    }
  }

  @override
  Future<Map<String, dynamic>>? userSignin(Map data) async {
    print(data);
    print(data["username"]);
    print(data["password"]);
    final response = await http.post(
      Uri.parse('$baseUrl/api/account/signin'),
      // headers: <String, String>{
      //   'Content-Type': 'application/json; charset=UTF-8',
      // },
      body: {
        'email': data["username"],
        'password': data['password'],
      },
    );
    print(response.body);
    return returnResponse(response);
  }

  @override
  Future<Map<String, dynamic>>? userSignup(Map data) async {
    final response = await http.post(
      Uri.parse('$baseUrl/api/account/signup/'),
      body: data,
    );
    return returnResponse(response);
  }
}
