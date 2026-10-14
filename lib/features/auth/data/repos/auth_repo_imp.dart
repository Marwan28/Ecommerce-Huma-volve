import 'package:dartz/dartz.dart';
import 'package:ecommerce_app_huma_volve/core/errors/error_handler.dart';
import 'package:ecommerce_app_huma_volve/core/failures/failure.dart';
import 'package:ecommerce_app_huma_volve/features/auth/data/data_sources/auth_local_data_source.dart';
import 'package:ecommerce_app_huma_volve/features/auth/data/data_sources/auth_remote_data_source.dart';
import 'package:ecommerce_app_huma_volve/features/auth/domain/entities/login_entity.dart';
import 'package:ecommerce_app_huma_volve/features/auth/domain/entities/signup_entity.dart';
import 'package:ecommerce_app_huma_volve/features/auth/domain/repos/auth_repo.dart';

class AuthRepoImp implements AuthRepo {
  final AuthRemoteDataSource authRemoteDataSource;
  final AuthLocalDataSource authLocalDataSource;

  AuthRepoImp({
    required this.authRemoteDataSource,
    required this.authLocalDataSource,
  });

  @override
  Future<Either<Failure, LoginEntity>> login({
    required String email,
    required String password,
  }) async {
    try {
      final loginModel = await authRemoteDataSource.login(
        email: email,
        password: password,
      );
      await authLocalDataSource.saveTokens(
        accessToken: loginModel.accessToken,
        refreshToken: loginModel.refreshToken,
      );
      return Right(loginModel.toEntity());
    } catch (e) {
      return Left(ErrorHandler.handle(e));
    }
  }

  @override
  Future<Either<Failure, SignupEntity>> signup({
    required String name,
    required String email,
    required String password,
  }) async {
    try {
      final signupModel = await authRemoteDataSource.signup(
        name: name,
        email: email,
        password: password,
      );
      return Right(signupModel.toEntity());
    } catch (e) {
      return Left(ErrorHandler.handle(e));
    }
  }

  @override
  Future<Either<Failure, bool>> hasSession() async {
    try {
      final accessToken = await authLocalDataSource.getAccessToken();
      return Right(accessToken != null && accessToken.isNotEmpty);
    } catch (e) {
      return Left(ErrorHandler.handle(e));
    }
  }

  @override
  Future<Either<Failure, Unit>> logout() async {
    try {
      await authLocalDataSource.clearTokens();
      return const Right(unit);
    } catch (e) {
      return Left(ErrorHandler.handle(e));
    }
  }
}
