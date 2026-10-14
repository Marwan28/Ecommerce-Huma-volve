import 'package:dartz/dartz.dart';
import 'package:ecommerce_app_huma_volve/core/failures/failure.dart';
import 'package:ecommerce_app_huma_volve/features/auth/domain/repos/auth_repo.dart';

class LogoutUsecase {
  final AuthRepo authRepo;

  const LogoutUsecase({required this.authRepo});

  Future<Either<Failure, Unit>> call() {
    return authRepo.logout();
  }
}