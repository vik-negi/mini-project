import 'dart:convert';
import 'package:http/http.dart' as http;

// const String baseUrl = 'http://evika.herokuapp.com';
// const String baseUrl = 'http://172.11.10.136:8000';
// const String baseUrl = 'http://192.168.137.94:8000'; //rohit laptop
// const String baseUrl = 'http://192.168.191.65:8000'; //rohit
// const String baseUrl = 'http://192.168.252.65:8000'; //Aman
// const String baseUrl = 'http://192.168.100.112:8000';
const String baseUrl = 'http://192.168.43.65:8000'; //mobile hotspot
// const String baseUrl = 'http://172.11.10.136:8000';
// const String baseUrl = 'http://172.11.11.137:5000';

const mlBaseUrl = "https://evika-ml.herokuapp.com";

class ApiServices {
  dynamic returnResponse(http.Response? response) {
    // debugPrint(response!.body.toString());
    switch (response!.statusCode) {
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
}
