import 'dart:convert';
import 'package:http/http.dart' as http;

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
