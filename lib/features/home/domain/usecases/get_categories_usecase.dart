import 'package:dartz/dartz.dart';
import 'package:ecommerce_app_huma_volve/core/failures/failure.dart';
import 'package:ecommerce_app_huma_volve/features/home/domain/entities/category_entity.dart';
import 'package:ecommerce_app_huma_volve/features/home/domain/repos/home_repo.dart';

class GetCategoriesUsecase {
  final HomeRepo homeRepo;

  GetCategoriesUsecase({required this.homeRepo});

  Future<Either<Failure, List<CategoryEntity>>> call() async {
    return await homeRepo.getCategories();
  }
}
