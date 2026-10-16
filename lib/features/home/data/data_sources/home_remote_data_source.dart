import 'package:ecommerce_app_huma_volve/core/constants/api_constants.dart';
import 'package:ecommerce_app_huma_volve/core/network/dio_client.dart';
import 'package:ecommerce_app_huma_volve/features/home/data/models/category_model.dart';
import 'package:ecommerce_app_huma_volve/features/home/data/models/product_model.dart';

class HomeRemoteDataSource {
  final DioClient dioClient;

  HomeRemoteDataSource({required this.dioClient});

  Future<List<CategoryModel>> getCategories() async {
    final result = await dioClient.dio.get(ApiConstants.categoryEndpoint);
    return (result.data as List).map((e) => CategoryModel.fromJson(e)).toList();
  }

  Future<List<ProductModel>> getProducts({
    required String categoryId,
    required int limit,
    required int offset,
  }) async {
    final result = await dioClient.dio.get(
      '${ApiConstants.categoryEndpoint}/$categoryId/${ApiConstants.productEndpoint}',
      queryParameters: {'limit': limit, 'offset': offset},
    );
    return (result.data as List).map((e) => ProductModel.fromJson(e)).toList();
  }
}
