import 'package:dartz/dartz.dart';
import 'package:ecommerce_app_huma_volve/core/errors/error_handler.dart';
import 'package:ecommerce_app_huma_volve/core/failures/failure.dart';
import 'package:ecommerce_app_huma_volve/features/home/data/data_sources/home_remote_data_source.dart';
import 'package:ecommerce_app_huma_volve/features/home/domain/entities/category_entity.dart';
import 'package:ecommerce_app_huma_volve/features/home/domain/entities/product_entity.dart';
import 'package:ecommerce_app_huma_volve/features/home/domain/repos/home_repo.dart';

class HomeRepoImp implements HomeRepo {
  final HomeRemoteDataSource homeRemoteDataSource;

  const HomeRepoImp({required this.homeRemoteDataSource});

  @override
  Future<Either<Failure, List<CategoryEntity>>> getCategories() async {
    try {
      final categoriesModels = await homeRemoteDataSource.getCategories();
      final categoriesEntities = categoriesModels
          .map((e) => e.toEntity())
          .toList();
      return Right(categoriesEntities);
    } catch (e) {
      return Left(ErrorHandler.handle(e));
    }
  }

  @override
  Future<Either<Failure, List<ProductEntity>>> getProducts({
    required String categoryId,
    required int limit,
    required int offset,
  }) async {
    try {
      final productsModels = await homeRemoteDataSource.getProducts(
        categoryId: categoryId,
        limit: limit,
        offset: offset,
      );
      final productsEntities = productsModels.map((e) => e.toEntity()).toList();
      return Right(productsEntities);
    } catch (e) {
      return Left(ErrorHandler.handle(e));
    }
  }
}
