import 'package:dartz/dartz.dart';
import 'package:ecommerce_app_huma_volve/core/failures/failure.dart';
import 'package:ecommerce_app_huma_volve/features/auth/domain/entities/signup_entity.dart';
import 'package:ecommerce_app_huma_volve/features/auth/domain/repos/auth_repo.dart';

class SignupUsecase {
  final AuthRepo authRepo;

  SignupUsecase({required this.authRepo});

  Future<Either<Failure, SignupEntity>> call({
    required String name,
    required String email,
    required String password,
  }) async {
    return await authRepo.signup(name: name, email: email, password: password);
  }
}
