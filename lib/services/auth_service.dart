

import 'package:galerie_ecom_fe/models/user.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'api_service.dart';

class AuthService {
  final ApiService _apiService = ApiService();

  Future<bool> register(String username, String emailAddress, String password, List<String> list) async {
    final response = await _apiService.post('/auth/register', {
      'username': username,
      'email': emailAddress,
      'password': password
    });

    if(response.statusCode == 200) {
      final token = response.data['token'];
      _apiService.setAuthToken(token);
      return true;
    } else {
      return false; 
    }
  }

  Future<bool> login(String username, String password) async {
    final response = await _apiService.post('/auth/signon', {
      'username': username,
      'password': password
    });

    if(response.statusCode == 200) {
      final token = response.data['token'];
      _apiService.setAuthToken(token);
      return true;
    } else {
      return false; 
    }
  }
   Future<void> forgot_password(String email) async {
    await _apiService.post('/auth/forgot', {
      'email': email});
  }

  Future<User?> getCurrentUser() async {
    final prefs = await SharedPreferences.getInstance();

   /* String? userJson = prefs.getString('user');

    if (userJson != null) {
        Map<String, dynamic> userMap = jsonDecode(userJson);
        User user = User.fromJson(userMap);
        return user;
    }
    else {
      return null;
    }*/
    User user = User(email: "mikeffaust@yahoo.com", userId: "123456789012345",
       firstName: "Mike", lastName: "Faust",username: "MFAUST3270",
       profilePicture: "none"
    );
    return user;

  }
}