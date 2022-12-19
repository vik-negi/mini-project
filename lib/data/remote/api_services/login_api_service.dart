import 'dart:convert';

import 'package:evika/data/remote/api_interface.dart';
import 'package:evika/data/remote/api_services/api_services.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

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
  Future<Map<String, dynamic>?> userSignin(Map data) async {
    debugPrint(data.toString());
    debugPrint(data["username"]);
    debugPrint(data["password"]);
    var response = await http.post(
      Uri.parse('$baseUrl/api/account/signin'),
      // headers: <String, String>{
      //   'Content-Type': 'application/json; charset=UTF-8',
      // },
      body: {
        'email': data["username"],
        'password': data['password'],
      },
    );
    debugPrint(response.body);
    // return returnResponse(response);
    if (response == null) {
      debugPrint("Backed not connectted");
      return {};
    }
    var res = jsonDecode(response.body);
    return res;
  }

  @override
  Future<Map<String, dynamic>> userSignup(Map data) async {
    final response = await http.post(
      Uri.parse('$baseUrl/api/account/signup/'),
      body: data,
    );
    return returnResponse(response);
  }

  @override
  Future<Map<String, dynamic>> updateUserLocation(Map updateLocation) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    String token = sharedPreferences.getString("token")!;
    final response = await http.post(
      Uri.parse('$baseUrl/api/account/update-user-location/'),
      headers: {
        "authorization": "Bearer $token",
      },
      body: updateLocation,
    );
    print("response :::::::::: ${response.body}");
    return returnResponse(response);
  }
}
