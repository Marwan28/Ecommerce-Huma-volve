import 'package:dartz/dartz.dart';
import 'package:ecommerce_app_huma_volve/core/failures/failure.dart';
import 'package:ecommerce_app_huma_volve/features/auth/domain/repos/auth_repo.dart';

class CheckSessionUsecase {
  final AuthRepo authRepo;

  const CheckSessionUsecase({required this.authRepo});

  Future<Either<Failure, bool>> call() {
    return authRepo.hasSession();
  }
}