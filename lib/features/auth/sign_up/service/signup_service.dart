import 'package:ecommerce_app_huma_volve/core/network/api_client.dart';
import 'package:ecommerce_app_huma_volve/core/network/api_endpoints.dart';
import 'package:ecommerce_app_huma_volve/features/auth/sign_up/models/signup_req_model.dart';
import 'package:ecommerce_app_huma_volve/features/auth/sign_up/models/signup_res_model.dart';

class SignupService {
  final ApiManager _apiManager;
  SignupService({required this._apiManager});
  Future<SignupResModel> signup(SignupReqModel reqModel) async {
    final response = await _apiManager.dio.post(
      ApiEndpoints.signup,
      data: {
        "name": reqModel.name,
        "email": reqModel.email,
        "password": reqModel.password,
        "avatar": "https://api.lorem.space/image/face?w=640&h=480",
      },
    );
    print('Signup Response: ${response.data}');
    return SignupResModel.fromJson(response.data);
  }
}
