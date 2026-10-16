import 'package:dartz/dartz.dart';
import 'package:ecommerce_app_huma_volve/core/failures/failure.dart';
import 'package:ecommerce_app_huma_volve/features/home/domain/entities/product_entity.dart';
import 'package:ecommerce_app_huma_volve/features/home/domain/repos/home_repo.dart';

class GetProductsUsecase {
  final HomeRepo homeRepo;

  GetProductsUsecase({required this.homeRepo});

  Future<Either<Failure, List<ProductEntity>>> call({
    required String categoryId,
    required int limit,
    required int offset,
  }) async {
    return await homeRepo.getProducts(
      categoryId: categoryId,
      limit: limit,
      offset: offset,
    );
  }
}
