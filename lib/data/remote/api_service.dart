import 'dart:convert';

import 'package:frontend/data/remote/api_interface.dart';
import 'package:http/http.dart' as http;

// const String baseUrl = 'http://192.168.43.65:8000';
// const String baseUrl = 'http://172.11.10.77:8000';
const String baseUrl = 'http://evika.herokuapp.com';

class ApiServices extends ApiInterface {
  dynamic returnResponse(http.Response? response) {
    print(response!.body);
    switch (response.statusCode) {
      case 200:
        dynamic responseJson = jsonDecode(response.body ?? "");
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
    final response = await http.post(
      Uri.parse('$baseUrl/api/account/signin/'),
      body: data,
    );
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
