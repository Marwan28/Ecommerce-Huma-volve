import 'package:dartz/dartz.dart';
import 'package:ecommerce_app_huma_volve/core/failures/failure.dart';
import 'package:ecommerce_app_huma_volve/features/auth/domain/entities/login_entity.dart';
import 'package:ecommerce_app_huma_volve/features/auth/domain/entities/signup_entity.dart';

abstract class AuthRepo {
  Future<Either<Failure, LoginEntity>> login({
    required String email,
    required String password,
  });

  Future<Either<Failure, SignupEntity>> signup({required String name,
    required String email,
    required String password,});
  Future<Either<Failure, bool>> hasSession();

  Future<Either<Failure, Unit>> logout();
}
