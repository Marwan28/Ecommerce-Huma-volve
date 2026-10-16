import 'package:dartz/dartz.dart';
import 'package:ecommerce_app_huma_volve/core/failures/failure.dart';
import 'package:ecommerce_app_huma_volve/features/home/domain/entities/product_entity.dart';
import 'package:ecommerce_app_huma_volve/features/home/domain/repos/home_repo.dart';

class GetProductUsecase {
  final HomeRepo homeRepo;

  GetProductUsecase({required this.homeRepo});

  Future<Either<Failure, ProductEntity>> call({
    required String productId,
  }) async {
    return await homeRepo.getProduct(productId: productId);
  }
}
