import 'package:dio/dio.dart';
import 'package:ecommerce_app_huma_volve/core/constants/api_constants.dart';
import 'package:ecommerce_app_huma_volve/core/network/dio_client.dart';
import 'package:ecommerce_app_huma_volve/features/auth/models/login_model.dart';
import 'package:ecommerce_app_huma_volve/features/auth/models/signup_model.dart';

class AuthService {
  final DioClient dioClient;

  AuthService({required this.dioClient});

  Future<LoginModel> login({
    required String email,
    required String password,
  }) async {
    final response = await dioClient.dio.post(
      ApiConstants.loginEndpoint,
      data: {'email': email, 'password': password},
    );
    final jsonData = response.data;
    final loginModel = LoginModel.fromJson(jsonData);

    return loginModel;
  }

  Future<SignupModel> signup({
    required String name,
    required String email,
    required String password,
  }) async {
    final response = await dioClient.dio.post(
      ApiConstants.signupEndpoint,
      data: {
        'name': name,
        'email': email,
        'password': password,
        'role': 'customer',
        'avatar': 'https://i.imgur.com/LDOO4Qs.jpg',
      },
    );
    final jsonData = response.data;
    final signupModel = SignupModel.fromJson(jsonData);
    return signupModel;
  }
}
