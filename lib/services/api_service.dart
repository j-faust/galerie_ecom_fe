import 'package:dio/dio.dart';
import '../config/api_constants.dart';

class ApiService {
  final Dio _dio = Dio(BaseOptions(baseUrl: ApiConstants.baseUrl));

  Future<Response> get(String path) async {
    return await _dio.get(path);
  }

  Future<Response> post(String path, Map<String, dynamic> data) async {
    return await _dio.post(path, data: data);
  } 

  void setAuthToken(String token) {
    _dio.options.headers["Authorization"] = "Bearer token";
  }

}