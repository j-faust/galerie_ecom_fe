
import 'api_service.dart';

class AuthService {
  final ApiService _apiService = ApiService();

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
}