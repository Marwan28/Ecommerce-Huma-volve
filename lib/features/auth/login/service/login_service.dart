import 'package:dio/dio.dart';
import 'package:ecommerce_app_huma_volve/core/network/api_client.dart';
import 'package:ecommerce_app_huma_volve/core/network/api_endpoints.dart';
import 'package:ecommerce_app_huma_volve/features/auth/login/model/login_model.dart';

class LoginService {
  final ApiManager _apiManager;

  LoginService({required ApiManager apiManager}) : _apiManager = apiManager;

  Future<LoginModel> login(String username, String password) async {
    final response = await _apiManager.dio.post(
      ApiEndpoints.login,
      data: {'email': username, 'password': password},
    );

    return LoginModel.fromJson(response.data as Map<String, dynamic>);
  }
}
