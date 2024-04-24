import 'package:http/http.dart' as http;
import 'dart:convert';
import 'model_login.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginAPI {
  final String baseUrl;

  LoginAPI(this.baseUrl);

  Future<bool> login(Login loginData) async {
    try {
      final response = await http.post(
        Uri.parse('$baseUrl/login'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(loginData.toJson()),
      );

      if (response.statusCode == 200) {
        final responseData = jsonDecode(response.body);
        final token = responseData['data']['token'];
        
        final prefs = await SharedPreferences.getInstance();
        prefs.setString('authToken', token);

        return true;
      } else {
        throw Exception('Failed to login');
      }
    } catch (e) {
      print('Error: $e');
      throw Exception('Failed to login');
    }
  }
}
