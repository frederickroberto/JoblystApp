import 'dart:convert';
import 'package:http/http.dart' as http;
import 'model_register.dart';

class RegisterAPI {
  final String baseUrl;

  RegisterAPI(this.baseUrl);

  Future<bool> register(Register registerData) async {
    try {
      final response = await http.post(
        Uri.parse('$baseUrl/register'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(registerData.toJson()),
      );

      if (response.statusCode == 200) {
        return true;
      } else {
        return false;
      }
    } catch (e) {
      print('Error: $e');
      return false;
    }
  }
}