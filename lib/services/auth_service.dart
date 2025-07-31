
import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'api_service.dart';
import '../models/user.dart';

class AuthService {
  final ApiService _apiService = ApiService();

  Future<bool> login(String username, String password) async {
    final response = await _apiService.post('/auth/signon', {
      'username': username,
      'password': password
    });

    if(response.statusCode == 200) {
      final token = response.data['token'];
      if(token != null) {
        await _saveToken(token);
        _apiService.setAuthToken(token);
      }

      return true;
    } else {
      return false; 
    }
  }

  Future<void> _saveToken(String token) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('auth_token', token);
  }


Future<bool> register(String username, String email, String password, {List<String> roles = const ["user"]}) async {
  final response = await _apiService.post("/auth/signup", {
    'username': username,
    'email': email,
    'password': password,
    'roles': roles,
  });

  return response.statusCode == 200 || response.statusCode ==201;
}

Future<bool> validate() async {
  final token = await _getToken();
  if(token == null) return false;

  _apiService.setAuthToken(token);
  final response = await _apiService.get("auth/user");
  return response.statusCode == 200;
}

Future<String?> _getToken() async {
  final prefs = await SharedPreferences.getInstance();
  return prefs.getString('auth_token');
}

Future<void> logout() async {
  final prefs = await SharedPreferences.getInstance();
  await prefs.remove('auth_token');
  _apiService.setAuthToken('');
}

Future<User?> getCurrentUser() async {
  final token = await _getToken();
  if(token == null) return null;

  _apiService.setAuthToken(token);
  final response = await _apiService.get("/auth/user");
  if(response.statusCode == 200) {
    return User.fromJson(response.data);
  } else {
    return null;

  }
} 

  
}