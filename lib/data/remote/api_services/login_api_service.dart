import 'package:evika/data/remote/api_interface.dart';
import 'package:evika/data/remote/api_services/api_services.dart';
import 'package:http/http.dart' as http;

// const String baseUrl = 'http://192.168.43.65:8000';
// const String baseUrl = 'http://172.11.10.77:8000';
const String baseUrl = 'http://evika.herokuapp.com';

class LoginApiServices extends LoginApiInterface {
  ApiServices apiServices = ApiServices();

  @override
  Future<Map<String, dynamic>>? userSignin(Map data) async {
    final response = await http.post(
      Uri.parse('$baseUrl/api/account/signin/'),
      body: data,
    );
    return apiServices.returnResponse(response);
  }

  @override
  Future<Map<String, dynamic>>? userSignup(Map data) async {
    final response = await http.post(
      Uri.parse('$baseUrl/api/account/signup/'),
      body: data,
    );
    return apiServices.returnResponse(response);
  }
}
